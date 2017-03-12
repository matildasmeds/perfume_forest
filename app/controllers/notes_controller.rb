class NotesController < ApplicationController

  def index
    @notes = Note.all_ordered_by_name
    fresh_when last_modified: @notes.maximum(:updated_at), public: true
  end

  def show
    @note = Note.includes(:perfumes).find(params['id'])
    fresh_when @note, public: true
  end
end
