# tests Perfume#perfume_notes queried by layertype
shared_examples 'a note collection' do
  before(:all) do
    # parse name of the described method
    # so that methods can be sent to klass in examples
    arr = self.class.to_s.split('::')
    @notes = arr[arr.index('Perfume') + 1].underscore
    @notes_ids = "#{@notes}_ids"
    @notes_names = "#{@notes}_names"
  end
  it 'valid response to *_notes' do # would love to use @notes here, couldn't
    expect(@perfume.send(@notes).last).to be_instance_of Note
  end
  it 'valid response to *_notes_ids' do
    last = @perfume.send(@notes_ids).last
    expect(last).to be_kind_of Integer
    matching_notes = PerfumeNote.where(perfume_id: @perfume.id, note_id: last)
    expect(matching_notes.count).to eql 1
  end
  it 'valid response to *_notes_names' do
    last = @perfume.send(@notes_names).last
    expect(last).to be_instance_of String
    expect(last.size).to be > 0
  end
end
