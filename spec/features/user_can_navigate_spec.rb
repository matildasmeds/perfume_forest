require 'spec_helper'
require_relative 'helpers/user_can_navigate_spec_helper'
# Note: Capybara with selenium is not able
# to navigate these. Reason unknown.
RSpec.feature 'User can navigate between views' do

  before(:all) { setup_note_and_perfume }

  scenario 'perfumes -> perfume' do
    start_at perfumes_path
    assert_navigates_to perfume, :show
  end

  scenario 'note -> perfume' do
    start_at note_path(note.id)
    assert_navigates_to perfume, :show
  end

  scenario 'perfume -> note' do
    start_at perfume_path(perfume.id)
    assert_navigates_to note, :show
  end

  scenario 'notes -> note' do
    start_at notes_path
    assert_navigates_to note, :show
  end
end
