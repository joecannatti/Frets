module WithAverage
  def average
    sum = self.inject(&:+)
    sum / self.size.to_f
  end
end

class FretboardDistance
 
  def initialize(a, b)
    @a = a
    @b = b
	end

  def distance
    diffences = @a.zip(@b).map do |string_from_a, string_from_b|
      diff_strings(string_from_a, string_from_b)
    end.flatten
    
    diffences.extend(WithAverage)
    diffences.average
    
  end

  def diff_strings(a,b)
    a.map do |fret_number, prob|
      (prob - b[fret_number]).abs
    end
  end
end
