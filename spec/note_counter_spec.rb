require File.join(File.dirname(__FILE__), "..", "src", "note_counter")

describe NoteCounter do
 
  context "instantiation" do
  
    it "takes a string" do
      lambda { described_class.new("mock_tab") }.should_not raise_error
    end

    it "stores the string passed in" do
      described_class.new("mock_tab").tab.should eq "mock_tab"
    end

  end

  context "#notes" do

    context "G Chord" do

      let(:g_chord_tab) do
        "-3-\n-0-\n-0-\n-0-\n-2-\n-3-"
      end

      subject { described_class.new(g_chord_tab) }

      it "correctly one line" do
        subject.lines.size.should eq 1
      end

      it "reads the notes correctly" do
        subject.notes[0][3].should eq 1
        subject.notes[1][2].should eq 1
      end

    end

    context "two lines with noise" do

      let(:g_chord_tabs) do
        "-3-\n-0-\n-0-\n-0-\n-2-\n-3-\nPANDA\n-3-\n   -0-\n-0-\n-0-\n-2-\n-3"
      end

      subject { described_class.new(g_chord_tabs) }

      it "correctly one line" do
        subject.lines.size.should eq 2
      end

      it "reads the notes correctly" do
        subject.notes[0][3].should eq 2
        subject.notes[1][2].should eq 2
      end

    end
    
  end

end
