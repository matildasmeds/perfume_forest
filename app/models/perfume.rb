class Perfume < ActiveRecord::Base
  belongs_to :brand
  has_many :perfume_notes, dependent: :destroy
  has_many :notes, through: :perfume_notes
  has_many :layer_types, -> { distinct }, through: :perfume_notes
  validates_presence_of :name, :brand, :year
  validates_uniqueness_of :name

  # for views
  def title
    if self.name.include? self.brand.name
      self.name
    else
      "'#{self.name}' by #{self.brand.name}"
    end
  end

  # supports '<layer>_notes_<attrs>'
  # where <layer> corresponds to any LayerType#name value in DB
  #       <attrs> corresponds to any attribute of Note, pluralized
  def method_missing(name)
    parts = name.to_s.split('_')
    super unless parts.include? 'notes'
    return [] unless self.layer_types.collect(&:name).include? layer_name = parts.first
    perf_notes = perfume_notes.includes(:note).where('layer_type_id = ?', LayerType.find_by_name(layer_name).id)
    return [] if perf_notes.empty?
    notes = perf_notes.collect(&:note)
    if notes.last.respond_to? attrb = parts.last.chop.to_sym
      notes.collect(&attrb)
    else 
      notes
    end
  end

  def all_notes
    self.notes.uniq
  end

end
