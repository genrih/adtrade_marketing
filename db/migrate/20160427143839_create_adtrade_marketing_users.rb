class CreateAdtradeMarketingUsers < ActiveRecord::Migration
  def change
    create_table :adtrade_marketing_users do |t|
      t.string :login
      t.string :html_url
      t.string :name
      t.string :company
      t.string :blog
      t.string :location
      t.string :email
      t.string :public_repos
      t.string :followers
      t.string :created_at
      t.text :bio
      t.string :source

      t.timestamps null: false
    end
  end
end
