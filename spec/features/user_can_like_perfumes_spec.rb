require 'spec_helper'
require_relative 'helpers/user_can_like_perfumes_spec_helper.rb'

RSpec.feature 'User can like perfumes' do

  after(:each) do
    reset_local_storage
  end

  after(:all) do
      Capybara.reset_sessions!
      Capybara.use_default_driver
  end

  scenario 'likes a perfume', js: true do
    visit root_path
    expect(no_likes?).to eql(true)
    like_perfume(1)
    expect(count_likes?(1)).to eql(true)
  end

  scenario 'previously liked perfumes persist between page loads', js: true do
    visit root_path
    expect(no_likes?).to eql(true)
    like_perfumes([3,2,5])
    expect(count_likes?(3)).to eql(true)
    visit 'http://www.google.com'
    visit root_path
    expect(count_likes?(3)).to eql(true)
  end
end
