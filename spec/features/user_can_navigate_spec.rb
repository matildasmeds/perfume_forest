require 'spec_helper'
require_relative 'helpers/user_can_navigate_spec_helper'
RSpec.feature 'User can navigate between views' do

  before(:all) { setup_note_and_perfume }

  describe 'To perfumes # show' do
    scenario 'from perfumes # index' do
      start_at perfumes_path
      assert_navigates_to perfume, :show
    end

    scenario 'from notes # show' do
      start_at note_path(note.id)
      assert_navigates_to perfume, :show
    end
  end

  describe 'To notes # show' do
    scenario 'from perfumes # show' do
      start_at perfume_path(perfume.id)
      assert_navigates_to note, :show
    end

    scenario 'from notes # index' do
      start_at notes_path
      assert_navigates_to note, :show
    end
  end

  describe 'To notes # index' do
    scenario 'from notes # show' do
      start_at note_path(note.id)
      assert_navigates_to_notes
    end

    scenario 'from perfumes # show' do
      start_at perfume_path(perfume.id)
      assert_navigates_to_perfumes
    end
  end

  describe 'To perfumes # index' do
    scenario 'from notes # show' do
      start_at note_path(note.id)
      assert_navigates_to_perfumes
    end

    scenario 'from perfumes # show' do
      start_at perfume_path(perfume.id)
      assert_navigates_to_perfumes
    end
  end
end
