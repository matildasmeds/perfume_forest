ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/expectations'
require 'database_cleaner'
require 'shoulda/matchers'
require 'byebug'

RSpec.configure do |config|

  # Seeding and DatabaseCleaner is fast enough for now
  config.before(:suite) do
    puts '......................................................'
    puts '... Running PerfumeForest test suite               ...'
    puts '... Seed DB before suite                           ...'
    puts '... Test data creation choices pend on performance ...'
    puts '... DB clean up strategy transaction               ...'
    puts '......................................................'
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
    Rails.application.load_seed
  end

  config.after(:suite) do
    DatabaseCleaner.clean
    puts '......................................................'
    puts '... Clean up DB after suite                        ...'
    puts '......................................................'
  end

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
