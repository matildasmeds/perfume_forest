require 'yaml'
module Seeds
  # Data import methods
  # Usage
  #   Seeds::Import.brands
  #   Seeds::Import.perfumes
  class Import
    class << self
      def brands
        brand_items.each do |brand|
          Brand.create! brand if Brand.where(brand).empty?
        end
      end

      def perfumes
        perfume_items.each do |perfume|
          conds = parse_identifiers perfume['identifiers']
          p = Perfume.find_or_create_by! conds
          perfume['perfume_notes'].each do |notes_by_layer|
            layer_name = notes_by_layer.first.first
            notes = notes_by_layer.first.last
            add_perfume_notes!(p, layer_name, notes)
          end
          p.save if p.changed
        end
      end

      def add_perfume_notes!(perfume, layer_name, notes)
        layer_type = LayerType.find_or_create_by!(name: layer_name)
        conds = { perfume_id: perfume.id, layer_type_id: layer_type.id }
        notes.each do |name|
          conds[:note_id] = Note.find_or_create_by!(name: name).id
          if PerfumeNote.where(conds).empty?
            perfume.perfume_notes << PerfumeNote.create!(conds)
          end
        end
      end

      def brand_items
        YAML.load_file(File.join(__dir__, 'brands.yml'))
      end

      def perfume_items
        YAML.load_file(File.join(__dir__, 'perfumes.yml'))
      end

      def parse_identifiers(identifiers)
        conds = {}
        identifiers.each do |identifier|
          key, val = identifier.first
          if foreign_key? key
            conds[key.split('_by_').first] = parse_foreign_key key, val
          else
            conds[key] = val
          end
        end
        conds
      end

      def foreign_key?(key)
        key.include? '_id_by_'
      end

      def parse_foreign_key(key, val)
        klass, by_attr = key.split('_id_')
        klass.camelize.constantize.send("find_#{by_attr}", val).try :id
      end
    end
  end
end
