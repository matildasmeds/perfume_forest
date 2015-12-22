ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/expectations'
require 'rspec/rails'
require 'capybara/rails'
require 'shoulda/matchers'
require 'database_cleaner'
require 'byebug'

RSpec.configure do |config|

  # Seeding and DatabaseCleaner is fast enough for now
  config.before(:suite) do
    puts "\n----------------------------------------------------"
    puts '| Before suite: Seed DB                            |'
    puts '| DB clean up strategy transaction                 |'
    puts '| Running PerfumeForest test suite                 |'
    puts '----------------------------------------------------'
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
    Rails.application.load_seed
  end

  config.after(:suite) do
    DatabaseCleaner.clean
    puts "\n----------------------------------------------------"
    puts '| After suite: Clean up DB                         |'
    puts '----------------------------------------------------'
  end

  config.include Rails.application.routes.url_helpers
  config.include Capybara::DSL

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
