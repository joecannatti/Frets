#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'

TAB_DIR = File.join(File.dirname(__FILE__), "..", "..", "tabs")

def dt_for_tr(tr)
  tr.css('td[style="color:#DDDDCC"]').first
end

def rating_for_tr(tr)
  rating_span = tr.css('td[width="20%"] span').first
  rating_span ? rating_span['class'].sub(/^r_/,'') : 'not_rated'
end

def href_for_dt(dt)
  dt.css('a').first['href']
end

def title_for_dt(dt)
  dt.css('a').first.content
end

def filename(title,rating)
  "#{title}@@@#{rating}.txt"
end

def artist_dir_path(artist)
  File.join(TAB_DIR, artist)
end

def make_artist_dir(artist)
  FileUtils.mkdir(artist_dir_path(artist)) unless File.exist?(artist_dir_path(artist))
end

def write_file(name, dir, tab)
  File.open(File.join(dir, name), 'w') do |file|
    file.write tab
  end
end

artist_index_path = ARGV[0]
artist_name = ARGV[1]
index_page = Nokogiri::HTML(open(artist_index_path))

all_pages = [artist_index_path] + index_page.css('a.ys').map { |a| URI.join(artist_index_path, a['href']).to_s }

all_pages.each do |index_page_url|
  puts "Loading Index Page: #{index_page_url}"
  puts "-------------------------------------"
  index_page = Nokogiri::HTML(open(index_page_url)) if index_page_url != artist_index_path
  index_page.css('tr').each do |tr|
    dt = dt_for_tr(tr)
    next unless dt
    href = href_for_dt(dt)
    title = title_for_dt(dt)
    rating = rating_for_tr(tr)
    filename = filename(title,rating) 
    next if title =~ /(Guitar Pro|Power Tab|Pro Tab|Tab Pro)/i
    make_artist_dir(artist_name)
    puts "Loading Tab: title:#{title} rating:#{rating} href:#{href} rating:#{rating} href:#{href}"
    tab_page = Nokogiri::HTML(open(href))
    tab = tab_page.css('pre').last.content
    write_file(filename, artist_dir_path(artist_name), tab)
  end
end
