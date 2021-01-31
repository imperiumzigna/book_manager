require "capybara/rspec"
require "selenium-webdriver"

Capybara.configure do |config|
  Capybara.server_host = "0.0.0.0"
  Capybara.server_port = 4000
  Capybara.app_host = "http://website:4000"
end

Capybara.register_driver :headless_selenium_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w(headless disable-gpu window-size=1440x768  acceptInsecureCerts=true --ignore-ssl-errors=yes) }
  )

  Capybara::Selenium::Driver.new(app,
    browser: :remote,
    url: "http://chrome:4444/wd/hub",
    desired_capabilities: capabilities,
  )
end

Capybara.register_driver :selenium_chrome_in_container do |app|
  Capybara::Selenium::Driver.new(app,
    browser: :remote,
    url: "http://chrome:4444/wd/hub",
    desired_capabilities: :chrome
  )
end
