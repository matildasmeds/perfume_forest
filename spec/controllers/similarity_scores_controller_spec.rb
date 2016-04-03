require 'spec_helper'

RSpec.describe SimilarityScoresController, type: :controller do

  let(:perfume_id) do
    params = { name: 'Gracious Tuberose', brand: 'Gucci' }
    brand_id = Brand.find_by_name(params[:brand]).id
    Perfume.where(name: params[:name], brand_id: brand_id).first.id
  end

  let(:liked_perfume_ids) do
    params = [ { name: 'Envy Me', brand: 'Gucci' },
               { name: 'White Woods', brand: 'Clean' },
               { name: 'Le Parfum', brand: 'Carven' } ]
    params.map{ |p| p[:brand_id] = Brand.find_by_name(p[:brand]).id }
    params.map do |p|
      Perfume.where(p.except(:brand)).first.id
    end
  end

  let(:expected_json) { { id: perfume_id, score: 2 }.to_json }

  it 'compares perfume similarity to liked perfumes' do
    params = { id: perfume_id, liked_ids: liked_perfume_ids }
    get :show, params
    expect(response.body).to eql(expected_json)
  end
end
