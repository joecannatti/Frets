class NoteCounter

  attr_reader :tab
 
  def initialize(tab)
    @tab = tab
  end

  def lines
    #match each block of 6 strings
    @tab.scan(/^[\s\|eE\\\/]*-[^\n]*\n[\s\|bB\\\/]*-[^\n]*\n[\s\|gG\\\/]*-[^\n]*\n[\s\|Dd\\\/]*-[^\n]*\n[\s\|Aa\\\/]*-[^\n]*\n[\s\|Ee\\\/]*-[^\n]*/)
  end

  def notes

    if ! @notes
      @notes = parse 
    end
    @notes 

  end

  private

  def parse
    unless @_parsed
      @_parsed = (0..5).map { Hash[(0..24).map { |n| [n,0] } ] }
      lines.each do |line|
        line.split("\n").each_with_index do |string, index|
          string_number = 5 - index 
          frets = string.scan(/\d+/).to_a
          frets.group_by { |n| n }.map { |k,v| @_parsed[string_number][k.to_i] += v.size }
        end
      end
    end
    @_parsed
  end

end
