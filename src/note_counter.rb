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

  def base_results
    (0..5).map { Hash[(0..24).map { |n| [n,0] } ] }
  end

  def parse
    unless @_parsed
      @_parsed = base_results
      lines.each do |line|
        return base_results if line.split("\n").length != 6
        line.split("\n").each_with_index do |string, index|
          string_number = 5 - index 
          frets = string.scan(/\d+/).to_a
          return base_results if frets.any? { |v| v.to_i < 0 || v.to_i > 24 }
          frets.group_by { |n| n }.map { |k,v| @_parsed[string_number][k.to_i] += v.size }
        end
      end
    end
    @_parsed
  end

end
