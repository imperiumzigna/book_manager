require "rspec/rails"
require "devise"
require_relative "devise_macros"

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :request
  config.include Devise::Test::ControllerHelpers, type: :view
  config.include Devise::Test::IntegrationHelpers, type: :feature
  config.extend DeviseMacros, type: :controller
  config.extend DeviseMacros, type: :feature
end
