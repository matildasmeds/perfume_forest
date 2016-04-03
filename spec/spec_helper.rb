ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/expectations'
require 'rspec/rails'
require 'capybara/rails'
require 'shoulda/matchers'
require 'database_cleaner'
require 'factory_girl'
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
    Perfume.define_dynamic_methods
  end

  config.after(:suite) do
    DatabaseCleaner.clean
    puts "\n----------------------------------------------------"
    puts '| After suite: Clean up DB                         |'
    puts '----------------------------------------------------'
  end

  config.include Rails.application.routes.url_helpers
  config.run_all_when_everything_filtered = true

  # Enable Capybara server retrieve seeded data
  class ActiveRecord::Base
    mattr_accessor :shared_connection
    @@shared_connection = nil
    def self.connection
      @@shared_connection || retrieve_connection
    end
  end
  ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection

  config.include Capybara::DSL

  # Configure Selenium for Capybara
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end
  Capybara.run_server = true

  # Reinforce expect syntax
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
