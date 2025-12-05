require "capybara/cucumber"
require "selenium-webdriver"
require "tmpdir"

Capybara.default_max_wait_time = 10
Capybara.default_normalize_ws = true

Capybara.register_driver :chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new

  options.add_argument("--window-size=1400,1000")
  options.add_argument("--disable-gpu")
  options.add_argument("--no-sandbox")
  options.add_argument("--disable-dev-shm-usage")
  options.add_argument("--disable-background-networking")
  options.add_argument("--disable-sync")
  options.add_argument("--no-first-run")
  options.add_argument("--no-default-browser-check")

  # Avoid using the default profile
  options.add_argument("--user-data-dir=#{Dir.mktmpdir("capybara-chrome")}")

  options.add_argument("--headless=new") if ENV["HEADLESS"] == "true"

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end


Capybara.default_driver = :chrome
Capybara.javascript_driver = :chrome
