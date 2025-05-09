#!/usr/bin/env ruby

DESC = <<EOS

Program to identify orphaned image directories.

Finds all directories in images/posts/ that contain images used in blog post
files, but do not have a corresponding file with the same name. This can happen
if the blog post file that the directory referred to has been deleted. The
program will report all of the orphaned directories that it finds.

Also finds widowed style files, in the additional_styles/posts/ directory,
where the name of the file should be the name of the now deleted article in the
source/posts/ directory without extensions.

Also finds orphaned data directories, in data/posts/\

EOS

Usage_string = "Usage: #{program_name = File.basename $PROGRAM_NAME} [OPTION]\n"

require "micro-optparse"

options = Parser.new do |p|
  p.banner = Usage_string + DESC
  p.option :always_report, "write a message when no widows are found"
end.process!

class String
  def bold
    "\e[1m#{self}\e[22m"
  end
end

img_dir_path = File.join(__dir__, "../source/assets/images/posts/")
style_dir_path = File.join(__dir__, "../source/assets/stylesheets/additional_styles/posts/")
data_dir_path = File.join(__dir__, "../data/posts/")
post_dir_path = File.join(__dir__, "../source/posts/")

img_directories = Dir.chdir(img_dir_path) do
  Dir.glob("*/")
end.map { |dir_name| dir_name.chomp("/") }

style_files = Dir.chdir(style_dir_path) do
  Dir.glob("*")
end.map { |filename| filename.split(".").first }

data_directories = Dir.chdir(data_dir_path) do
  Dir.glob("*/")
end.map { |dir_name| dir_name.chomp("/") }

post_files = Dir.chdir(post_dir_path) do
  Dir.glob("*")
end.map { |filename| filename.split(".").first }

orphaned_img_directories = img_directories.select do |img_directory|
  !post_files.include? img_directory
end

if orphaned_img_directories.any?
  puts "widowed image directories are:"
  orphaned_img_directories.each { |directory| puts directory.bold }
elsif options[:always_report]
  puts "no widowed image directories found"
end

orphaned_style_files = style_files.select do |a_style_file|
  !post_files.include? a_style_file
end

if orphaned_style_files.any?
  puts "widowed style files are:"
  orphaned_style_files.each { |style_file| puts style_file.bold }
elsif options[:always_report]
  puts "no widowed style files found"
end

orphaned_data_directories = data_directories.select do |data_directory|
  # We named the date directory with underscores instead of hyphens, because erb.
  # Here we change the underscores to hyphens to align with how we named the markdown post files.
  # By the way, the Rakefile does not produce an _ in filename if you gave_it one, it will read gave-it
  # When we create the dir, it should only have _, not -
  # Data file(s) will have underscores as well.
  !post_files.include? data_directory.gsub(/^_/, "").gsub("_", "-")
end

if orphaned_data_directories.any?
  puts "widowed DATA directories are:"
  orphaned_data_directories.each { |directory| puts directory.bold }
elsif options[:always_report]
  puts "no widowed DATA directories found"
end
