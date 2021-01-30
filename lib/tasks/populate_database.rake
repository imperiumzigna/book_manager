require "factory_bot_rails"

namespace :dev do
  desc "Populates development environment  data"
  task populate: :environment do
    FactoryBot.create_list(:book, 50)
    admin = FactoryBot.create(:admin)

    puts "--------- Database Populated ---------"
    puts "Login as admin with email #{admin.email} and password 123456"
  end
end
