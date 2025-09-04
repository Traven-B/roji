# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

# activate :autoprefixer do |prefix|
#   prefix.browsers = "last 2 versions"
# end

# TODO: remove this, what is this, does it fix index-.html problem?
# set :strip_index_file, false

set :markdown_engine, :kramdown
set :markdown, :auto_ids => false
activate :syntax

activate :asset_hash

set :css_dir, "assets/stylesheets"
set :js_dir, "assets/javascripts"
set :images_dir, "assets/images"
set :fonts_dir, "assets/fonts"

# Configure Sass directories
# plain old css ind stylesheets dir works as before when using `set :css_dir ...`
sass_dirs = [
  "source/assets/stylesheets",
  "source/assets/stylesheets/additional_styles",
  "source/assets/stylesheets/additional_styles/posts",
]

# Configure Sass assets paths
set :sass_assets_paths, sass_dirs.map { |dir| File.join(root, dir) }

if !ENV["absolute"]
  # default is no environment variable absolute
  set :relative_links, true
  activate :relative_assets
end

###
# Propagate this to any old and new configs
# ignore 'stylesheets/*.sass'
ignore (/\..*\.sw[a-p]/)
ignore (/\.sw[a-p]/)
###

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
#
# With no layout
page "/*.xml", layout: false
page "/*.json", layout: false
page "/*.txt", layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# Activate and configure blog extension

activate :blog do |blog|
  Time.zone = "Central Time (US & Canada)"
  # This will add a prefix to all links, template references and source paths
  # blog.prefix = "blog"

  # #### blog.permalink = "{year}/{month}/{day}/{title}.html"
  blog.permalink = "blog/{year}-{month}-{day}-{title}.html"
  # Matcher for blog source files
  # #### blog.sources = "{year}-{month}-{day}-{title}.html"
  blog.sources = "posts/{title}-{year}-{month}-{day}.html"
  # blog.taglink = "tags/{tag}.html"
  # #### blog.layout = "layout"
  blog.layout = "post"
  blog.summary_separator = /(READMORE)/
  # # blog.summary_length = 250
  blog.summary_length = 130
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  # #### blog.default_extension = ".markdown"

  # #### using md without setting it to default works
  # #### using md in not blog pages works too
  blog.default_extension = ".md"

  blog.tag_template = "tag.html"
  # if we dont have a tag.html to use, remove it from the source dir
  # but need a reference to something anyway
  # blog.tag_template = "tag_does_not_exist.html"
  # blog.calendar_template = "calendar.html"
  blog.calendar_template = "calendar_does_not_exist.html"

  # blog.generate_tag_pages = false
  blog.generate_day_pages = false
  blog.generate_month_pages = false
  blog.generate_year_pages = false

  # Enable pagination
  blog.paginate = true
  blog.per_page = 5
  blog.page_link = "page/{num}"
  blog.custom_collections = {
    category: {
      link: "categories/{category}.html",
      template: "category.html",
    },
  }

  # this worked in a test project
  # so an example of less code doing less
  # blog.summary_generator = proc do |article, rendered, length, ellipsis|
  #   if article.data["summary"]
  #     Kramdown::Document.new(article.data["summary"], line_width: 80, hard_wrap: false, auto_ids: false).to_html
  #   else
  #     article.default_summary_generator(rendered, length, ellipsis)
  #   end
  # end

  if !ENV["show"]
    # default is no environment variable show
    # do this unless we said show

    blog.summary_generator = proc do |article, rendered, length, ellipsis|
      # article is Middleman::Sitemap::Resource # rendered is ActiveSupport::SafeBuffer
      if article.data["summary"]
        # we can haz fancy in summary, header, lists, et all
        # https://stackoverflow.com/questions/3790454/how-do-i-break-a-string-in-yaml-over-multiple-lines
        Kramdown::Document.new(article.data["summary"], line_width: 80, hard_wrap: false, auto_ids: false).to_html
      else
        # Auto-generated summary: Remove figures/images, strip ALL links
        doc = Nokogiri::HTML.fragment(rendered)
        doc.css("figure, img, a").each do |node|
          node.replace(node.text) if node.name == "a"
          node.remove
        end

        # Remove empty containers
        doc.css("ul, ol, p, em").each { |e| e.remove if e.content.strip.empty? }
        article.default_summary_generator(doc.to_html, length, ellipsis)
      end
    end
  end
end

page "/feed.xml", layout: false
# Reload the browser automatically whenever files change
# configure :development do
#   activate :livereload
# end

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

helpers do
  # used in source/layouts/post.erb alongside current_article.tags
  def current_article_categories_helper
    cat_array = current_article.metadata[:page][:category]  # was [:categories]
    if cat_array.class == String
      cat_array = [cat_array]
    end
    if cat_array == nil
      cat_array = []
    end
    cat_array
  end
end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

configure :build do
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end
