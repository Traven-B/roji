#!/usr/bin/env ruby

DESC = <<EOS

Program to make an image directory associated with a post.
Reads given file or standard input.

- First line: filename of post (with/without extension). The program strips 
  extensions and creates the directory images/posts/[filename]/. Reuses 
  existing directory if present.

- Second line: markdown image template line containing ![]().
  This line can contain one or more '--id--' substrings which become the base 
  name (no extension) of the images. This line is expanded for each image and
  written to standard output.

- Third and following lines: URLs or local file paths of images.
  May be followed by comma-separated values for name and extension, e.g.:
    http://example.com/img.jpg[suffix]
  where suffix can be:
    empty                 (default name: 'image', extension: 'jpg')
    ,name                 (basename only, no extension)
    ,name,extension       (basename and extension, as in ',photo,png')
    ,,extension           (extension only, as in ',,png')

Examples:
  http://site.com/kitty.jpg              saves as image.jpg
  http://site.com/kitty-cat.jpg          saves as image-2.jpg
  http://site.com/kitty.jpg,cat          saves as cat.jpg
  http://site.com/kitty.jpg,cat,jpeg     saves as cat-2.jpeg
  http://site.com/kitty.png,,png         saves as image-3.png
  ../../hold/an-image/selfie.jpg,selfie  saves as selfie.jpg

Important:
- The image "name" refers to the base filename only (no extension).

- Extensions default to 'jpg' unless explicitly specified. If you download
  a .png file, you have to specify the png extension.

- Repeating the same name across input lines is allowed; the program numbers
duplicates sequentially with suffixes like -2, -3, etc.

- Using sets of different names is also supported.

- The example input lines could be provided all in one run or across multiple
program invocations.

Note:
If you are working with a non-Markdown templating system (e.g., ERB), you can
still use this program to download images and create the directory by using the
simple 2nd input line placeholder ![](). You can redirect or discard the output
if you don't need it (do_images.rb input.txt > /dev/null). The images will be
downloaded and stored correctly.\

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
