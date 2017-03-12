require 'similarity_scores'
class SimilarityScoresController < ApplicationController

  # Considering this controller is not currently used
  # probably should not be in master either :->

  def show
    score = SimilarityScores.compare(args_from_params(params))
    render json: { id: params[:id].to_i, score: score }.to_json
  end

  private

  def args_from_params(params)
    p_id = params[:id]
    liked_ids = params[:liked_ids]
    target_note_ids = Perfume.find(p_id).all_notes_ids
    liked_note_id_sets = liked_ids.map{ |id| Perfume.find(id).all_notes_ids }
    { target: target_note_ids, data: liked_note_id_sets }
  end
end
