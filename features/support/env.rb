require 'cucumber/rails'
require "dotenv/load"
require "rspec/expectations"

ActionController::Base.allow_rescue = false

BASE_URL = ENV.fetch("BASE_URL")
EMAIL    = ENV.fetch("EMAIL")
PASSWORD = ENV.fetch("PASSWORD")

