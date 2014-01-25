require File.join(File.dirname(__FILE__), "..", "src", "fretboard_distance")
require 'json'

describe FretboardDistance do
 
  let(:simple_fretboard_e) do
  [
    {
      "0" => 1,
      "1" => 0
    },
    {
      "0" => 0,
      "1" => 0
    }
  ]
	end

  let(:simple_fretboard_f) do
  [
   {
     "0" => 0,
     "1" => 1
   },
    {
      "0" => 0,
      "1" => 0
    }
  ]
	end

  let(:balanced_fretboard) do
    [
     {
       "0" => 0.25,
       "1" => 0.25
     },
      {
        "0" => 0.25,
        "1" => 0.25
      }
    ]
  end

  context "different fretboards" do

    it "returns 0.5" do
      described_class.new(simple_fretboard_e, simple_fretboard_f).distance.should eq 0.5
    end

  end

  context "identical fretboards" do

    it "returns 0.0" do
      described_class.new(simple_fretboard_e, simple_fretboard_e).distance.should eq 0
    end

  end

  context "balanced fretboard" do

    it "is .375 from e" do
      described_class.new(balanced_fretboard, simple_fretboard_e).distance.should eq 0.375
    end

    it "is .375 from f" do
      described_class.new(balanced_fretboard, simple_fretboard_f).distance.should eq 0.375
    end

  end

  context "compare everyone" do

    let(:everyone) do
      filenames = Dir.new(File.join(File.dirname(__FILE__), "..", "results")).select do |filename|
        filename =~ /\.json/
      end

      Hash[filenames.map do |filename|
        begin 
          hash = JSON.parse(File.open(File.join(File.dirname(__FILE__), "..", "results", filename)).read)
          [hash["artist_name"], hash["probability"]]
        rescue
         nil
        end
      end.compact]

    end

    it "calculates cartisian distances" do

     results = Hash[everyone.map do |artist_name, prob|
       distances = Hash[everyone.reject { |k,v| artist_name == k }.map do |artist_name_b, prob_b|
         [artist_name_b, described_class.new(prob, prob_b).distance]
       end]
       [artist_name, distances]
     end]

     results.each do |arist_name, distances|
       sorted_distances = distances.sort_by do |arist_name, distance| 
         distance
       end
       p "Closest to %s: %s" % [arist_name, sorted_distances.first.first]
       p "Furthest to %s: %s" % [arist_name, sorted_distances.last.first]
     end

    end
  end

end
