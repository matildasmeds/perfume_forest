require 'spec_helper'

RSpec.describe Perfume, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:year) }
    it { should validate_presence_of(:brand) }
  end
end
