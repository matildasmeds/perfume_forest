require 'spec_helper'

RSpec.describe Brand, type: :model do
  describe 'validations' do
    it { should have_many(:perfumes).dependent(:destroy) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
