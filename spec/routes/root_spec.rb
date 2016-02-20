require 'spec_helper'

RSpec.describe "Root route", type: :routing do
  it 'redirects to perfumes' do
    expect(get: '/').to route_to(
      controller: 'perfumes', action: 'index')
  end
end
