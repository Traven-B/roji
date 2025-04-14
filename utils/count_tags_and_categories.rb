#!/usr/bin/env ruby

# This code reads all of the Markdown files in the source/posts directory and
# counts the number of times each tag and category appears in the yaml
# metadata. The results are then printed to stdout in three columns.

# There can be 0 or more tags, 0 or more categories. I test to see if
# page_data["tags"].is_a? String, if there is a comma separated list as a string
# make it an array. After the flattens the tag_accumulator and
# category_accumulator are both arrays of strings.
# tag_accumulator goes from
# [nil, ["test"], ["teletype", "tty", "ruby"], ["imagetest"]]
# to
# ["empty_TAG", "test", "teletype", "tty", "ruby", "imagetest"]

require "yaml"

def nomalize(page_data, tags_or_category)
  # sting as comma separated list, becomes an array - string without commas becomes an array with one string element
  if page_data[tags_or_category].is_a? String
    page_data[tags_or_category] = page_data[tags_or_category].split(",").map(&:strip)
  end
  page_data[tags_or_category]
end

def count_categories(category_accumulator, category_or_tag)
  # flatten the accumulator, to be an array of strings and nils
  # change any nil to 'empty_tag' so they don't disappear somehow
  category_accumulator = category_accumulator.flatten.map { |e| e == nil ? "empty_#{category_or_tag.upcase}" : e }

  # https://stackoverflow.com/questions/1765368/how-to-count-duplicates-in-ruby-arrays
  # accumulate counts in a hash with keys that are tag strings, and values the count
  category_count = category_accumulator.reduce(Hash.new(0)) { |h, v| h.store(v, h[v] + 1); h }

  # sort the hash in descending order, using -value (my idea), category count becomes an array
  # others pages say use value then .reverse the array
  # https://stackoverflow.com/questions/2540435/how-to-sort-a-ruby-hash-by-number-value

  category_count = category_count.sort_by { |_key, value| -value }
  category_count.map! { |r| r.join(" ") }
  # category_count.class is an Array ["vim 4", "git 2"]

  # https://stackoverflow.com/questions/18338495/iterate-every-two-elements-in-ruby-for-loop
  # print the category strings 3 across
  printf "#{category_or_tag.capitalize} counts\n"
  printf "------------------------------------------------------------\n"
  category_count.each_slice(3) do |a, b, c|
    puts sprintf("%-20s %-20s %s", a, b, c).strip
  end
end

tag_accumulator = []
category_accumulator = []

Dir.glob(["source/posts/*.html*"]) do |fn|
  page_data = YAML.load_file(fn)
  category_accumulator.push(nomalize(page_data, "category"))
  tag_accumulator.push(nomalize(page_data, "tags"))
end

count_categories(category_accumulator, "category")
puts
count_categories(tag_accumulator, "tag")
