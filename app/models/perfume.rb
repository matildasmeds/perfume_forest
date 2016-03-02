class Perfume < ActiveRecord::Base
  belongs_to :brand
  has_many :perfume_notes, dependent: :destroy
  has_many :notes, through: :perfume_notes
  has_many :layer_types, -> { distinct }, through: :perfume_notes
  validates_presence_of :name, :brand, :year
  validates :name, uniqueness: { scope: :brand_id, case_sensitive: false }

  # for views
  def title
    if name.include? brand.name
      "'#{name}'"
    else
      "'#{name}' by #{brand.name}"
    end
  end

  # Convenience attr_readers for layer-based note collections
  def self.define_dynamic_methods
    LayerType.all.each do |layer_type|
      next if layer_type.name == 'all'
      lns = "#{layer_type.name}_notes"
      define_method(lns) { notes_by(layer_type) }
      define_method("#{lns}_ids") { notes_by(layer_type).collect(&:id) }
      define_method("#{lns}_names") { notes_by(layer_type).collect(&:name) }
    end
  end

  # Had to encapsulate this to enable tests
  Perfume.define_dynamic_methods

  def all_notes
    notes.uniq
  end

  def layer_names
    layer_types.collect(&:name)
  end

  def all_notes_ids
    all_notes.collect(&:id)
  end

  def all_notes_names
    all_notes.collect(&:name)
  end

  private

  def notes_by(layer)
    pn = perfume_notes.includes(:note).where layer_type_id: layer.id
    pn.collect(&:note)
  end
end
