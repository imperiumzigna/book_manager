require "factory_bot_rails"

namespace :dev do
  desc "Populates development environment  data"
  task populate: :environment do
    FactoryBot.create_list(:book, 50)
  end
end
