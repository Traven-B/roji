#!/usr/bin/env ruby

DESC = <<EOS

Program to make data directory associated with a post.

Given a filename of a post with or without extensions, removes the extensions, changes to
the data/posts/ directory, and creates a data directory named after the filename string.\

EOS

Usage_string = "Usage: #{@program_name = File.basename $PROGRAM_NAME} [OPTION] name-string\n"

require "micro-optparse"

options = Parser.new do |p|
  p.banner = Usage_string + DESC
end.process!

def create_directory(directory_name, content)
  data_dir_path = File.join(__dir__, "../data/posts/")
  Dir.chdir(data_dir_path) do
    if Dir.exist?(directory_name)
      puts "#{@program_name}: File already exists."
      return
    end
    Dir.mkdir(directory_name)
    content = content.gsub("xxxDIRNAME_HERExxx", directory_name)
    File.open(File.join(directory_name, "a.yml"), "w") do |file|
      file.write(content)
    end
  end
end

def get_boilerplate_content
  File.read(File.join(__dir__, "use_data_separate_boilerplate.txt"))
end

def run()
  if ARGV.length != 1
    puts "#{@program_name}: Please specify exactly one filename."
    return
  end
  filename = ARGV[0]
  directory_name = filename.split(".").first
  # In the following: gsub(/^\d/, '_\0')
  #   ^ matches the start of the string.
  #   \d matches any digit.
  #   _ is the replacement string.
  #   \0 is a backreference to the entire match (i.e. the digit at the start of the string).
  #
  # So the regular expression matches a string that starts with a digit, and the
  # replacement string replaces that digit with an underscore followed by the digit itself
  directory_name = directory_name.gsub(/^\d/, '_\0').gsub("-", "_")
  content = get_boilerplate_content
  create_directory(directory_name, content)
end

run()
