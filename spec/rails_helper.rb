# spec/rails_helper.rb
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rspec/rails'
require 'capybara/rails'

Capybara.register_driver :selenium_chrome_headless do |app|
  # capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
  #   chromeOptions: { args: ['--headless', '--disable-gpu', '--window-size=1920,1080'] }
  # )
  options = Selenium::WebDriver::Chrome::Options.new(args: ['--headless', '--disable-gpu', '--window-size=1920,1080'])
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    # desired_capabilities: capabilities,
    options:
    # driver_path: '/usr/local/bin/chromedriver'
  )
end

RSpec.configure do |_config|
  Capybara.default_driver = :selenium_chrome_headless
  Capybara.server_host = 'localhost'
  Capybara.server_port = '3000'
  # ... (your other configurations)
end

# # spec/rails_helper.rb
# require 'spec_helper'
# ENV['RAILS_ENV'] ||= 'test'
# require_relative '../config/environment'
# require 'rspec/rails'
# require 'capybara/rails'

# Capybara.register_driver :selenium_chrome_headless do |app|
#   capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
#     chromeOptions: { args: ['--headless', '--disable-gpu', '--window-size=1920,1080'] }
#   )
#   options = Selenium::WebDriver::Chrome::Options.new(args: ['--headless', '--disable-gpu', '--window-size=1920,1080'])
#   options.add_preference(:download, directory_upgrade: true, prompt_for_download: false)
#   Capybara::Selenium::Driver.new(
#     app,
#     browser: :chrome,
#     desired_capabilities: capabilities,
#     options: options,
#     driver_path: '/usr/local/bin/chromedriver' # Replace with the actual path to chromedriver
#   )
# end

# RSpec.configure do |config|
#   Capybara.default_driver = :selenium_chrome_headless
#   Capybara.server_host = 'localhost'
#   Capybara.server_port = '3000'
#   # ... (your other configurations)
# end
