class Perfume < ActiveRecord::Base
  belongs_to :brand
  has_many :perfume_notes, dependent: :destroy
  has_many :notes, through: :perfume_notes
  has_many :layer_types, -> { distinct }, through: :perfume_notes
  validates_presence_of :name, :brand, :year
  validates_uniqueness_of :name

  # for views
  def title
    if name.include? brand.name
      name
    else
      "'#{name}' by #{brand.name}"
    end
  end

  # supports '<layer>_notes_<attrs>'
  # where <layer> corresponds to any LayerType#name value in DB
  #       <attrs> corresponds to any attribute of Note, pluralized
  def method_missing(name)
    segments = name.to_s.split('_')
    layer = segments.first
    super unless segments.include?('notes') && has_layer?(layer)
    notes = fetch_notes_by layer
    return notes if segments.last == 'notes'
    attrb = segments.last.chop.to_sym
    return notes.collect(&attrb) if notes.last.respond_to? attrb
    super
  end

  def all_notes
    notes.uniq
  end

  def all_notes_ids
    all_notes.collect &:id
  end

  def all_notes_names
    all_notes.collect &:name
  end

  private
  def fetch_notes_by(layer_name)
    conds = "layer_type_id = #{LayerType.find_by_name(layer_name).id}"
    pn = perfume_notes.includes(:note).where conds
    pn.collect(&:note)
  end

  def has_layer?(layer_name)
    self.layer_types.collect(&:name).include? layer_name
  end
end
