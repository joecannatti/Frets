class Fretboard

  attr_reader :notes

  def initialize(notes=[[]])
    @notes = notes
  end

  def +(fretboard)
    ret = [[],[],[],[],[],[]]
    @notes.each_with_index do |string, str_index|
      string.keys.each do |key|
        ret[str_index][key] = string[key] + fretboard.notes[str_index].fetch(key,0)
      end
    end
    self.class.new(ret)
  end
end
