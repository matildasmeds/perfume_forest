class LayerType < ActiveRecord::Base
  has_many :perfume_notes
  has_many :notes, through: :perfume_notes
  validates :name, presence: true, uniqueness: true
  validate :naming

  def self.NAMES
    %w(top middle base all)
  end

  def naming
    errors.add(:name, 'is not allowed') unless LayerType.NAMES.include? name
  end
end
