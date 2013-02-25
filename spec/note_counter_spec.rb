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

    context "two digit fret numbers" do

      let(:two_digit_frets) do
        "-3-\n-10-\n-0-\n-0-\n-2-\n-3-\nPANDA\n-3-\n   -0-\n-0-\n-0-\n-2-\n-3"
      end

      subject { described_class.new(two_digit_frets) }

      it "reads the notes correctly" do
        subject.notes[4][10].should eq 1
      end

    end

    context "when the line begins with the string note name" do

      let(:g_chord_tab) do
        "e|-3-\nB|-0-\nG|-0-\nD|-0-\nA|-2-\nE|-3-"
      end

      subject { described_class.new(g_chord_tab) }

      it "reads the notes correctly" do
        subject.notes[0][3].should eq 1
        subject.notes[1][2].should eq 1
      end

    end

    context "when the line begins with the string note name and a foward or back slash" do

      let(:g_chord_tab) do
        "e\\-3-\nB|-0-\nG|-0-\nD|-0-\nA|-2-\nE\\-3-"
      end

      subject { described_class.new(g_chord_tab) }

      it "reads the notes correctly" do
        subject.notes[0][3].should eq 1
        subject.notes[1][2].should eq 1
      end

    end

    context "test tab" do
    
      let(:hendrix_tab) do
        File.new(File.join(File.dirname(__FILE__), "hendrix.txt"), 'r').read
      end

      subject { described_class.new(hendrix_tab) }

      it "reads the tab" do
        subject.notes[0][12].should eq 1
        subject.notes[0][3].should eq 2
        subject.notes[0][0].should eq 1
        subject.notes[1][0].should eq 1
        subject.notes[1][2].should eq 1
        subject.notes[1][5].should eq 1
        subject.notes[1][7].should eq 1
        subject.notes[2][12].should eq 1
        subject.notes[2][5].should eq 3
        subject.notes[2][7].should eq 1
        subject.notes[3][0].should eq 3
        subject.notes[3][5].should eq 5
        subject.notes[3][4].should eq 3
        subject.notes[4][12].should eq 1
        subject.notes[4][3].should eq 6
        subject.notes[5][12].should eq 1
        subject.notes[5][5].should eq 1
        subject.notes[5][3].should eq 3
      end
    end
    
  end

end
