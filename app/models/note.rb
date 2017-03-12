class Note < ActiveRecord::Base
  has_many :perfume_notes
  has_many :perfumes, through: :perfume_notes
  validates :name, presence: true, uniqueness: true
  scope :all_ordered_by_name, -> { includes(:perfumes).order(:name) }
end
