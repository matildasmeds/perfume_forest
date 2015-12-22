require 'spec_helper'
require_relative 'shared_examples/note_collection'

RSpec.describe Perfume, type: :model do
  before(:all) do
    @perfume = Perfume.last
    puts 'WARN: Sample perfume not found in DB' unless @perfume
    puts 'WARN: Sample perfume must have notes' if @perfume.all_notes.empty?
  end
  describe 'validations' do
    it { should belong_to(:brand) }
    it { should have_many(:perfume_notes).dependent(:destroy) }
    it { should have_many(:notes) }
    it { should have_many(:layer_types) }
    it { should validate_presence_of(:name) }
    it do
      should validate_uniqueness_of(:name).scoped_to(:brand_id)
        .case_insensitive
    end
    it { should validate_presence_of(:year) }
    it { should validate_presence_of(:brand) }
  end
  describe '#all_notes' do
    it_behaves_like 'a note collection'
  end
  describe '#top_notes' do
    it_behaves_like 'a note collection'
  end
  describe '#middle_notes' do
    it_behaves_like 'a note collection'
  end
  describe '#base_notes' do
    it_behaves_like 'a note collection'
  end
end
