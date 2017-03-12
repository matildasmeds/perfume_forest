class PerfumesController < ApplicationController

  def index
    @perfumes = Perfume.scoped
    fresh_when last_modified: @perfumes.maximum(:updated_at), public: true
  end

  def show
    @perfume = Perfume.includes(:notes).find(params['id'])
    fresh_when @perfume, public: true
  end
end
