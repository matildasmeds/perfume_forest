class NotesController < ApplicationController

  def index
    @notes = Note.includes(:perfumes).order(:name)
  end

  def show
    @note = Note.includes(:perfumes).find(params["id"])
  end
end
