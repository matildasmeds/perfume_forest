# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# brands

def import_brands
  find_or_create_records! Brand, brands, brands_cols
end

def brands
  [['Gucci', 1921], ['Calvin Klein', 1968], ['Chanel', 1909], ['Lancôme', 1935],
   ['Christian Dior', 1946], ['Giorgio Armani', 1975], ['Estée Lauder', 1946],
   ['Clinique', 1968], ['Carven', 1945], ['Trussardi', 1911], ['Serge Lutens', 1992],
   ['Clean', 2003]]
end

def brands_cols
  [:name, :year]
end

# perfumes

def import_perfumes
  data = perfumes_by_brand.dup
  data.keys.each{|brand| insert_association! Brand, { name: brand }, data[brand], 2}
  data.each do |brand, perfumes|
    find_or_create_records! Perfume, perfumes, perfumes_cols
  end
end

def perfumes_by_brand
  {
    'Gucci' => 
            [['Gucci Bamboo', 2015], ['Envy Me', 2004], ['Flora by Gucci Gracious Tuberose', 2012],
            ['Gucci Guilty', 2010], ['Gucci Guilty Black pour Femme', 2013]],
    'Clean' => 
            [['Clean Air', 2015], ['Clean Rain', 2012], ['Clean Skin', 2012], ['First Blush', 2013],
            ['Summer Sun', 2015], ['White Woods', 2013]]
  }
end

def perfumes_cols
  [:name, :year, :brand_id]
end

# layers

def import_layer_types
  LayerType.allowed_names.each do |name|
    LayerType.find_or_create_by name: name
  end
end

# notes

def import_notes
  notes.each{|name| Note.find_or_create_by name: name}
end

def notes
 ["African Orange Flower", "Amber", "Apple", "Bergamot", "Casablanca Lily", "Cassia", "Clementine", 
  "French Labdanum", "Honeysuckle", "Jasmine", "Juniper Berries", "Litchi", "Mango", "Musk", "Orange Blossom", 
  "Peach", "Peony", "Pineapple", "Pink Pepper", "Pomegranate", "Rose", "Sandalwood", "Sea", "Tahitian Vanilla", 
  "Teak Wood", "Tobacco", "Tonka Bean", "Tuberose", "Violet Leaf", "Virginia Cedar", "White Amber", "White Tea", 
  "White Woods", "Ylang-Ylang"] 
end

# perfume notes

def import_perfume_notes
  perfume_notes_by_perfume.each do |perfume, layers|
    perfume_id = Perfume.find_by_name(perfume).id
    layers.first.each do |layer, notes|
      layer_type_id = LayerType.find_by_name(layer).id
      notes.each do |note|
        note_id = Note.find_by_name(note).id
        values = {perfume_id: perfume_id, layer_type_id: layer_type_id, note_id: note_id}
        PerfumeNote.create(values) if PerfumeNote.where(values).empty?
      end
    end
  end
end

def perfume_notes_by_perfume
  {
    'Envy Me' =>
      [
      'top' => ['Peony', 'Pineapple', 'Pink Pepper', 'Cassia', 'Peach', 'Jasmine', 'Mango'],
      'middle' => ['Peony', 'Musk', 'White Tea', 'Pomegranate', 'Litchi', 'Jasmine', 'Rose'],
      'base' => ['Teak Wood', 'Sandalwood', 'Tonka Bean', 'Musk', 'Tobacco']
      ]
  }
end

# helpers

def find_or_create_records!(klass, recs, cols)
  recs.each do |rec|
    values = {}; cols.each_with_index{|col, index| values[col] = rec[index]}
    klass.find_or_create_by values
  end
end

def insert_association!(klass, identifier, recs, position)
  id = klass.send("find_by_#{identifier.keys.first}", identifier.values.first).id
  recs.each{|rec| rec << id}
end

# execute
import_brands
import_perfumes
import_layer_types
import_notes
import_perfume_notes
