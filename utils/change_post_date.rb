#!/usr/bin/env ruby

DESC = <<EOS

Program to update blog post dates and filenames while preserving timestamps.

Given a post filename with YYYY-MM-DD date pattern and a new target date:
  1. Updates the filename's date component
  2. Modifies the front matter date while preserving existing time/zone

Run while in `posts` dir, program can be located anywhere. Best when fix-up
occurs immediately after blog post file creation.\

EOS

Usage_string = "Usage: #{@program_name = File.basename $PROGRAM_NAME} POST-FILENAME YYYY-MM-DD\n"

require "micro-optparse"

options = Parser.new do |p|
  p.banner = Usage_string + DESC
end.process!

require "fileutils"

def update_blog_post_date(old_filename, new_date)
  unless new_date.match?(/^\d{4}-\d{2}-\d{2}$/)
    puts "Error: Date must be in YYYY-MM-DD format"
    exit 1
  end

  # Extract base name and handle multiple extensions
  base = old_filename.sub(/(-\d{4}-\d{2}-\d{2})(\..+)/, "")
  ext = old_filename.match(/(-\d{4}-\d{2}-\d{2})(\..+)/)[2]
  new_filename = "#{base}-#{new_date}#{ext}"

  # Process content
  content = File.read(old_filename)
  updated_content = content.gsub(/^(date: )\d{4}-\d{2}-\d{2}/, "\\1#{new_date}")

  # Rename and update
  FileUtils.mv(old_filename, new_filename)
  File.write(new_filename, updated_content)

  puts "Updated: #{old_filename} → #{new_filename}"
end

if ARGV.size != 2
  puts "Usage: #{$0} <filename> <new-date>"
  exit 1
end

update_blog_post_date(ARGV[0], ARGV[1])
