require 'spec_helper'
require_relative '../../lib/similarity_scores.rb'

RSpec.describe 'SimilarityScores' do

  let(:target) { [1, 2, 3, 4] }
  let(:non_similar) { [100, 200, 300, 400, 500, 900] }
  let(:data) { [[2, 3, 4], [5, 6, 3]] }
  let(:count_distinct) { 5 } # unique ids in array of id sets
  let(:sim_score) { 4 } # count occurrences of matching ids

  describe '.compare' do
    context 'can evaluate id set similarity' do
      it 'calculates similarity score for numeric list based input' do
        args = { target: target, data: data }
        score = SimilarityScores.compare(args)
        expect(score).to eql(sim_score)
      end
      it 'recognizes zero similarity' do
        args = { target: target, data: [ non_similar ] }
        score = SimilarityScores.compare(args)
        expect(score).to eql(0)
      end
    end
  end

  describe '.count_distinct' do
    it 'gives number of unique elements in array of sets' do
      score = SimilarityScores.count_distinct(data: data)
      expect(score).to eql(count_distinct)
    end
  end
end
