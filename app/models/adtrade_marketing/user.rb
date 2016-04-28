module AdtradeMarketing
  class User < ActiveRecord::Base
    validates :email, uniqueness: true

    def self.export_to_csv
      CSV.generate do |csv|
        csv << column_names
        User.all.each do |user|
          csv << user.attributes.values_at(*column_names)
        end
      end
    end
  end
end
