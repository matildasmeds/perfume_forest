# Method collection to enable cleaner navigation specs

def setup_note_and_perfume
  let(:perfume) { Perfume.where(name: 'Envy Me', brand_id: Brand.find_by_name('Gucci').id).first }
  let(:note) { Note.find_by_name('Mango') }
end

def start_at(from_path)
  visit from_path
end

def assert_navigates_to(object, action)
  click_on object.name
  target_path = case action
      when :index
        send "#{object.class.name.tableize}_path"
      when :show
        send "#{object.class.name.downcase}_path", object.id
    end
  expect(current_path).to eq(target_path)
end
