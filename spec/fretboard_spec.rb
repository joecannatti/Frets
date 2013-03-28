require File.join(File.dirname(__FILE__), "..", "src", "fretboard")
require File.join(File.dirname(__FILE__), "..", "src", "note_counter")

describe Fretboard do

  let(:g_chord_tab) do
    "-3-\n-0-\n-0-\n-0-\n-2-\n-3-"
  end

  let(:note_counter) { NoteCounter.new(g_chord_tab) }

  context "instantiation" do

    it "accepts a 2-d array of note counts" do
      lambda { Fretboard.new(note_counter.notes) }.should_not raise_error
    end

    it "accepts a 2-d array of note counts and an artist name" do
      lambda { Fretboard.new(note_counter.notes, "Test Artist") }.should_not raise_error
    end

  end

  context "#artist_name" do
    
    it "is stored" do
      Fretboard.new(note_counter.notes, "Test Artist").artist_name.should eq "Test Artist"
    end

  end

  context "summing" do

    it "adds all note counts" do
      fretboard1 = Fretboard.new(note_counter.notes) 
      fretboard2 = Fretboard.new(note_counter.notes) 
      resulting_fretboard = fretboard1 + fretboard2
      resulting_fretboard.notes[0][3].should eq 2
      resulting_fretboard.notes[1][2].should eq 2
      resulting_fretboard.notes[1][0].should eq 0
      resulting_fretboard.notes[1][1].should eq 0
      resulting_fretboard.notes[2][0].should eq 2
      resulting_fretboard.notes[3][0].should eq 2
      resulting_fretboard.notes[4][0].should eq 2
      resulting_fretboard.notes[5][0].should eq 0
      resulting_fretboard.notes[5][3].should eq 2
    end

  end
end
