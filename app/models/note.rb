class Note < ActiveRecord::Base
  has_many :perfume_notes
  has_many :perfumes, through: :perfume_notes
  validates :name, presence: true, uniqueness: true
end
