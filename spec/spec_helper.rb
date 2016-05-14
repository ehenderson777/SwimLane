require 'selenium-webdriver'

#RSpec.configure do |config|
RSpec.configure do |config|
  config.example_status_persistence_file_path = 'examples.txt'
  config.run_all_when_everything_filtered = true


  config.before(:each) do |example|
    case ENV['host']
    when 'saucelabs'
      caps = Selenium::WebDriver::Remote::Capabilities.send(ENV['browser'])
      caps.version = ENV['browser_version']
      caps.platform = ENV['operating_system']
      caps[:name] = example.metadata[:full_description]

      @driver = Selenium::WebDriver.for(
        :remote,
        url: "http://#{ENV['SAUCE_USERNAME']}:#{ENV['SAUCE_ACCESS_KEY']}@ondemand.saucelabs.com:80/wd/hub",
        desired_capabilities: caps)
    else
      case ENV['browser']
      when 'firefox'
        @driver = Selenium::WebDriver.for :firefox
      when 'chrome'
        Selenium::WebDriver::Chrome::Service.executable_path = File.join(Dir.pwd, 'vendor/chromedriver')
        @driver = Selenium::WebDriver.for :chrome
      end
    end
  end

  config.after(:each) do |example|
    begin
      if ENV['host'] == 'saucelabs'
        if example.exception.nil?
          SauceWhisk::Jobs.pass_job @driver.session_id
        else
          SauceWhisk::Jobs.fail_job @driver.session_id
          raise "Watch a video of the test at https://saucelabs.com/tests/#{@driver.session_id}"
        end
      end
    ensure
      @driver.quit
    end
  end
end

