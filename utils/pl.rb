#!/usr/bin/env ruby
DESC = <<EOS

Run this to list blog post markdown source file names that are
title-year-month-day in a less ragged looking way, and sorted
by the date part.

Perhaps place in HOME/bin as pl

This file can be anywhere, you invoke it from the posts directory.\

EOS

Usage_string = "Usage: #{@program_name = File.basename $PROGRAM_NAME}"

require "micro-optparse"

options = Parser.new do |p|
  p.banner = Usage_string + DESC
end.process!

r = Dir.glob(["*html.md", "*html.md.erb", "*html.erb"]).sort_by do |filename|
  filename.scan(/\d{4}-\d{2}-\d{2}/)
end

r.each do |e|
  line_match = e.match(
    /^(.*)-([0-9]{4}-[0-9]{2}-[0-9]{2})\.(html\.md|html\.md\.erb|html\.erb)$/
  )
  new_name = "#{line_match[2]} \t#{line_match[1]}- #{line_match[3]}"
  puts new_name
end
