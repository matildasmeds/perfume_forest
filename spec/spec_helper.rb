ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/expectations'
require 'database_cleaner'
require 'shoulda/matchers'

RSpec.configure do |config|
  config.before(:suite) do
    puts 'Seed DB before suite'
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
    Rails.application.load_seed
  end

  # enough for now
  config.after(:suite) do
    DatabaseCleaner.clean
    puts 'Clean up DB after suite'
  end
end
