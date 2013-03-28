#!/usr/bin/env ruby

require 'json'

artists = []
Dir[File.join(File.dirname(__FILE__), "..", "results", "*")].each do |file_name|
  content = File.new(file_name, "r").read
  artists << JSON.parse(content)
end

artists = artists.sort { |a,b| a["number_of_tabs"] <=> b["number_of_tabs"] }
artists.each do |a|
  puts "#{a['artist_name']}, #{a['number_of_tabs']}"
end
