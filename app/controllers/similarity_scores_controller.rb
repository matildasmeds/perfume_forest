require 'similarity_scores'
class SimilarityScoresController < ApplicationController
  def show
    id = params[:id]
    liked_ids = params[:liked_ids]
    target = Perfume.find(id).all_notes_ids
    data = liked_ids.map{ |id| Perfume.find(id).all_notes_ids }
    score = SimilarityScores.compare(target: target, data: data)
    render json: { id: id.to_i, score: score }.to_json
  end
end
