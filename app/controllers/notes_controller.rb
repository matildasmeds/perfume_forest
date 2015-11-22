class NotesController < ApplicationController

  def index
    @notes = Note.all
  end

  def show
  end

end
