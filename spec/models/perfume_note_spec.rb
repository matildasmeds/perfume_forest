require 'spec_helper'

RSpec.describe PerfumeNote, type: :model do
  describe 'validations' do
    it { should belong_to(:perfume) }
    it { should belong_to(:note) }
    it { should belong_to(:layer_type) }
    it { should validate_presence_of(:perfume) }
    it { should validate_presence_of(:note) }
    it { should validate_presence_of(:layer_type) }
  end
end
