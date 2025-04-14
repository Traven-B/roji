# exit hack needed, he said, anyway reading the args without quotes or brackets
# https://stackoverflow.com/questions/825748/how-to-pass-command-line-arguments-to-a-rake-task/36929059#36929059
posts_dir = "source/posts"
# set constant to vim or nvim
VIM = "vim"

desc "create a new post with \"rake post words as title\"  no quotes no ['s"
task :post do
  _, *args = ARGV

  title = args.join(" ")
  mkdir_p "#{posts_dir}"
  # filename = "#{posts_dir}/#{title.downcase.gsub(/[^\w]+/, "-")}-#{Time.now.strftime("%Y-%m-%d")}.html.md"
  filename = "#{posts_dir}/#{title.downcase.gsub( /[\W_]+/, "-")}-#{Time.now.strftime("%Y-%m-%d")}.html.md"
  # filename = "#{posts_dir}/#{title.downcase.gsub(/[^\p{L}]+/, "-")}-#{Time.now.strftime("%Y-%m-%d")}.html.md"
  puts "Creating new post: #{filename}"
  capture = `utils/count_tags_and_categories.rb`.strip
  File.open(filename, "w") do |f|
    f << <<~EOS
    #{capture}
    ---
    title: #{title}
    date: #{Time.now.strftime("%F %R %Z")}
    category:
    tags:
    ---


    EOS
  end

  # Uncomment the line below if you want the post to automatically open in your default text editor
  # system ("vim -M -c \":setlocal modifiable | :setlocal write | :next | :prev\" #{filename} utils/example_markdown.md")
  system ("#{VIM} -M -c \":setlocal modifiable | :setlocal write | :next | :prev | :cd source/posts\" #{filename} utils/example_markdown.md")

  exit
end

# give filename of post to re-edit if you want example_markdown.md to be in a 2nd buffer again
# filename would be one word no spaces, (title was not)
desc "give filename of post to re-edit if you want example_markdown.md to be in a 2nd buffer again"
task :re_edit do
  _, filename = ARGV

  FileUtils.cd(posts_dir)
  # Uncomment the line below if you want the post to automatically open in your default text editor
  system ("#{VIM} -M -c \":setlocal modifiable | :setlocal write | :next | :prev\" #{filename} ../../utils/example_markdown.md")
  # system ("vim #{title}")
  exit
end

desc "report widows"
task :find_widows do
  Dir.chdir("utils") do
    system("./find_widows.rb --always-report")
  end
end

desc "make extra css"
task :make_extra_css do
  filename = ARGV[1]

  FileUtils.cd("utils")
  system ("./make_extra_css.rb #{filename}")
  exit
end

desc "use data - give a filename of existing post with erb extension"
task :use_data do
  filename = ARGV[1]

  FileUtils.cd("utils")
  system ("./use_data.rb #{filename}")
  exit
end

desc "list tasks"
task :list do
  puts "Tasks: #{(Rake::Task.tasks - [Rake::Task[:list]]).join(", ")}"
  puts "(type rake -T for more detail)\n\n"
end
