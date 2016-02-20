require 'spec_helper'
require_relative '../navigation_spec_helpers'
# Note: Capybara with selenium is not able
# to navigate these. Reason unknown.
describe 'Navigation' do
  describe 'Show paths' do

    setup_note_and_perfume

    it 'perfumes -> perfume' do
      start_at perfumes_path
      assert_navigates_to perfume, :show
    end

    it 'note -> perfume' do
      start_at note_path(note.id)
      assert_navigates_to perfume, :show
    end

    it 'perfume -> note' do
      start_at perfume_path(perfume.id)
      assert_navigates_to note, :show
    end

    it 'notes -> note' do
      start_at notes_path
      assert_navigates_to note, :show
    end
  end
end
