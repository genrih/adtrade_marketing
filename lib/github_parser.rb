module AdtradeMarketing
  class GithubParser
    def initialize(login: nil, password: nil)
      @github = (login && password) ? Github.new(basic_auth: "#{login}:#{password}") : Github.new
      @login = login
      @password = password
    end

    def get_users(pages: 10, start_page_num: 0, per_page: 30, language: 'swift', columns: [])
      begin
        pages_processed = 0
        user_fields = columns.empty? ? column_names : columns
        src_users = make_users_query(per_page, language)
        start_page = nil

        while src_users.has_next_page?
          start_page ||= src_users.page start_page_num
          break if pages_processed == pages
          process_page(start_page, user_fields)
          start_page = start_page.next_page
          pages_processed += 1
        end
      rescue Github::Error::Forbidden => e
        GithubWorker.perform_async(start_page_num + pages_processed, @login, @password, 30, language, pages)
      end
    end

    #queries left
    def rate_limit
      @github.ratelimit_remaining
    end

    private

    def make_users_query(per_page, language)
      @github.search.users q: "language:#{language}", per_page: per_page
    end

    def process_page(page, column_names)
      page.body.items.each do |user|
        user_info = fetch_user(user['login'])
        next if !user_info.body['email'] || AdtradeMarketing::User.exists?(email: user_info.body['email'])
        AdtradeMarketing::User.create(user_info.body.slice(*column_names).to_hash.merge(source: 'github'))
      end
    end

    def fetch_user(login)
      @github.users.get user: login
    end

    def column_names
      %W(login html_url name company blog location email public_repos followers created_at)
    end
  end
end
