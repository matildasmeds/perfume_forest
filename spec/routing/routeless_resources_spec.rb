require 'spec_helper'

# Even here I see repetition... is it needed???
RSpec.describe 'Routeless resources', type: :routing do

  it '/brands' do
    expect(get: '/brands').not_to be_routable
  end

  it '/perfume_notes' do
    expect(get: '/perfume_notes').not_to be_routable
  end

  it '/layer_types' do
    expect(get: '/layer_types').not_to be_routable
  end

  it '/layer_types' do
    expect(get: '/layer_types').not_to be_routable
  end
end
