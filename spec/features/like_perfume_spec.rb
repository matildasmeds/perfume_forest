require 'spec_helper'
require_relative '../like_perfume_spec_helpers.rb'

describe 'Liking feature' do
  # Clearing localStorage in a after :each would be much nicer,
  # than calling the like_perfume again
  # Each perfume on page has heart element
  # The has css / has no css assertions are not working

  after(:each) do
    reset_local_storage
  end

  after(:all) do
      Capybara.reset_sessions!
      Capybara.use_default_driver
  end

  it 'likes a perfume', js: true do
    visit root_path
    expect(no_likes?).to eql(true)
    like_perfume(1)
    expect(count_likes?(1)).to eql(true)
  end

  it 'stores liked perfumes', js: true do
    visit root_path
    expect(no_likes?).to eql(true)
    like_perfumes([3,2,5])
    expect(count_likes?(3)).to eql(true)
    visit 'http://www.google.com'
    visit root_path
    expect(count_likes?(3)).to eql(true)
  end
end
