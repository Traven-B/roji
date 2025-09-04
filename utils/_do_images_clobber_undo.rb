#!/usr/bin/env ruby

DESC = <<EOS

Program to make an image directory associated with a post.

Program reads given file or standard input.

Given text whose first line is the filename of a post with or without
extensions, removes the extensions, creates an image directory named after the
filename string in the images/posts/ directory.

The second line is a markdown image template line, a line containing ![](), the
program placese inside the parentheses the relative path and filename of
subsequently specified image names.

The second line can contain 1 or more '--id--' substrings which become the
base name (without extension) of the image.

Treat 3rd and following lines as URLs of images or local file paths, that may
have comma-separated values as a suffix, http://example.com/path/image-name.jpg[suffix],
where suffix is:
        empty
    or ,name
    or ,name,extension
    or ,,extension

name defaults to 'image', and extension defaults to 'jpg', producing 'image.jpg',
'image-2.jpg', etc. for the computed file names. The directory contents are checked
for name collisions each time we are writing a next image.

For local file paths, provide either relative paths (e.g., ../../hold_images/image.jpg)
or absolute paths (e.g., /home/user/images/image.jpg).\

EOS

Usage_string = "Usage: #{@program_name = File.basename $PROGRAM_NAME} [OPTION] [FILE]...\n"

require "micro-optparse"

options = Parser.new do |p|
  p.banner = Usage_string + DESC
end.process!

require "fileutils"
require "open-uri"
require "pathname"

def fetch_and_write_image(url, directory, name, ext)
  ext_with_dot = ext.empty? ? "" : ".#{ext}"  # Add a dot to the extension if it's not empty
  filename = "#{name}#{ext_with_dot}"

  # Fetch all files that match the base name, stripping extensions
  existing_files = Dir.glob(File.join(directory, "#{name}*")).map do |file|
    # Use Pathname to handle file paths and names
    Pathname.new(file).basename.to_s.sub(/\.[^.]+\z/, "")
  end

  # Check if the base filename exists, ignoring extensions
  if existing_files.include?(name)
    i = 2
    # Increment the counter until a unique base name is found
    while existing_files.include?("#{name}-#{i}")
      i += 1
    end
    filename = "#{name}-#{i}#{ext_with_dot}"
  end

  # Write the image to the file
  File.open(File.join(directory, filename), "wb") do |file|
    file.write(URI.open(url).read)
  end

  # Return the base name without the extension for use as an id
  return File.basename(filename, ".*")
end

@url = ""
@name = ""
@ext = ""

def process_image_url(url_string)
  url, name, ext = url_string.split(/,/)
  @url = url.strip
  @name = (name = name.to_s.strip).empty? ? "image" : name
  @ext = (ext = ext.to_s.strip).empty? ? "jpg" : ext
end

directory_name = ""
abs_directory_name = ""
rel_directory_name = ""
image_template_line = ""

ARGF.lineno = 0 # ruby counts from 2 instead of one, bug, this is a workaround
ARGF.each do |line|
  line = line.strip
  if ARGF.lineno == 1
    directory_name = line.split(".").first

    # line is the name of the blog post file,
    # directory_name is the blog post file name without extensions
    # abs_directory_name is the absolute path to a sister directory of the util directory, it contains a ../
    # rel_directory_name is relative url posts/#{directory_name}/ with a trailing slash

    abs_directory_name = File.join(__dir__, "../source/assets/images/posts/#{directory_name}/")
    rel_directory_name = "posts/#{directory_name}/"
    FileUtils.mkdir_p(abs_directory_name)
  elsif ARGF.lineno == 2
    image_template_line = line
  else
    process_image_url(line)
    computed_base_name = fetch_and_write_image(@url, abs_directory_name, @name, @ext)
    rel_path_and_name = rel_directory_name + "#{computed_base_name}.#{@ext}"
    image_template_line = image_template_line.gsub(/\!\[\]\(.*?\)/, "![](#{rel_path_and_name})")
    puts image_template_line.gsub("--id--", computed_base_name)
  end
end
