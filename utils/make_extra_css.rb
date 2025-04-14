#!/usr/bin/env ruby

DESC = <<EOS

Program to make extra style sheet.

Given a filename with or without extensions, removes the extensions, changes to
the directory stylesheets/additional_styles/posts/, and creates a boilerplate
sass file with that filename and extensions .css.scss\

EOS

Usage_string = "Usage: #{@program_name = File.basename $PROGRAM_NAME} [OPTION] name-string\n"

require "micro-optparse"

options = Parser.new do |p|
  p.banner = Usage_string + DESC
end.process!

def create_file(filename, content)
  style_dir_path = File.join(__dir__, "../source/assets/stylesheets/additional_styles/posts/")
  Dir.chdir(style_dir_path) do
    if File.exist?(filename)
      puts "#{@program_name}: File already exists."
      return
    end
    File.open(filename, "w") do |file|
      file.write(content)
    end
  end
end

def get_boilerplate_content(a_template_property)
  return <<~EOF
           // stylesheet: additional_styles/posts/#{a_template_property}

           @charset "utf-8";

           @import '../../_sass/_variables.scss';

         EOF
end

def run()
  if ARGV.length != 1
    puts "#{@program_name}: Please specify exactly one filename."
    return
  end
  filename = ARGV[0]
  filename = filename.split(".").first
  template_property = filename
  content = get_boilerplate_content(template_property)
  filename = filename + ".css.scss"
  create_file(filename, content)
end

run()
