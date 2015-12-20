class LayerType < ActiveRecord::Base
  has_many :perfume_notes
  has_many :notes, through: :perfume_notes
  validates :name, presence: true, uniqueness: true
  validate :name_allowed?

  def self.NAMES
    %w(top middle base all)
  end

  def name_allowed?
    if LayerType.NAMES.include? name
      true
    else
      errors.add(:name, 'is not allowed')
      false
    end
  end

end
