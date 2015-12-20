class PerfumesController < ApplicationController

  def index
    @perfumes = Perfume.all
  end

  def show
    @perfume = Perfume.includes(:notes).find(params["id"])
  end

end
