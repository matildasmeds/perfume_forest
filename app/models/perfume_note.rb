class PerfumeNote < ActiveRecord::Base
  belongs_to :perfume
  belongs_to :note
  belongs_to :layer_type
  validates_presence_of :perfume, :note, :layer_type
end
