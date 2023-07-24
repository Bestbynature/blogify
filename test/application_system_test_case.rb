# test/application_system_test_case.rb
require 'test_helper'

WINDOWS_HOST = `cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }'`.strip
CHROMEDRIVER_URL = "http://#{WINDOWS_HOST}:9515/".freeze

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium_remote_chrome

  Capybara.register_driver :selenium_remote_chrome do |app|
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: { args: ['--start-maximized'] }
    )

    Capybara::Selenium::Driver.new(
      app,
      browser: :remote,
      url: CHROMEDRIVER_URL,
      desired_capabilities: capabilities
    )
  end

  Capybara.configure do |config|
    config.server_host = 'localhost'
    config.server_port = '3000'
  end
end
