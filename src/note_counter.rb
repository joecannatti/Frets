class NoteCounter

  attr_reader :tab
 
  def initialize(tab)
    @tab = tab
  end

  def lines
    @tab.scan(/^[\s\|]*-[^\n]*\n[\s\|]*-[^\n]*\n[\s\|]*-[^\n]*\n[\s\|]*-[^\n]*\n[\s\|]*-[^\n]*\n[\s\|]*-[^\n]*/)
  end

  def notes

    if ! @notes
      @notes = parse 
    end
    @notes 

  end

  private

  def parse
    ret = (0..5).map { Hash[(0..24).map { |n| [n,0] } ] }
    lines.each do |line|
      line.split("\n").each_with_index do |string, index|
        string_number = 5 - index 
        frets = string.scan(/\d+/).to_a
        frets.group_by { |n| n }.map { |k,v| ret[string_number][k.to_i] += v.size }
      end
    end
    ret
  end

end
