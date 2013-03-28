class Fretboard

  attr_reader :notes, :artist_name, :number_of_tabs

  def initialize(notes=[[]], artist_name="",number_of_tabs=1)
    @notes = notes
    @artist_name = artist_name
    @number_of_tabs = number_of_tabs
  end

  def +(fretboard)
    ret = [{},{},{},{},{},{}]
    @notes.each_with_index do |string, str_index|
      string.keys.each do |key|
        ret[str_index][key] = string[key] + fretboard.notes[str_index].fetch(key,0)
      end
    end
    self.class.new(ret,@artist_name,self.number_of_tabs + fretboard.number_of_tabs)
  end

  def total_notes
    @notes.inject(0) { |sum, string| sum + string.values.inject(&:+) }
  end

  def probability
    @notes.map do |string|
      Hash[string.map { |key,value| [key, value.to_f/total_notes] }]
    end
  end

  def to_json
    {notes: notes, artist_name: @artist_name, number_of_tabs: @number_of_tabs}.to_json
  end
end
