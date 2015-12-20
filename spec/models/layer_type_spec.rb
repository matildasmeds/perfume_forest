require 'spec_helper'

RSpec.describe LayerType, type: :model do
  describe 'validations' do
    it { should have_many(:perfume_notes) }
    it { should have_many(:notes) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
