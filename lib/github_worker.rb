class GithubWorker
  include Sidekiq::Worker
  require 'github_parser'

  def perform(page_num = 0, login, password, per_page, language, pages)
    git = AdtradeMarketing::GithubParser.new(login: login, password: password)
    git.get_users(language: language, per_page: per_page, start_page_num: page_num, pages: pages)
  end
end
