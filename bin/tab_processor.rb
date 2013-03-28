#!/usr/bin/env ruby

require 'json'

require File.join(File.dirname(__FILE__), "..", "src", "note_counter")
require File.join(File.dirname(__FILE__), "..", "src", "fretboard")


Dir[File.join(File.dirname(__FILE__), "..", "tabs", "*")].each do |dir_name|
  artist_name = File.basename(dir_name)
  fretboard = nil
  Dir[File.join(dir_name, "*")].each do |file_name|
    content = File.new(file_name, "r").read
    notes = NoteCounter.new(content).notes
    unless fretboard
      fretboard = Fretboard.new(notes,artist_name)
    else
      fretboard += Fretboard.new(notes)
    end
  end
  File.open(File.join(File.dirname(__FILE__), "..", "results", "#{artist_name}.json"), 'w') do |out_file|
    out_file.write fretboard.to_json
  end
end
