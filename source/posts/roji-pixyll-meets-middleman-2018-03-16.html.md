---
title: "Roji: Pixyll meets Middleman"
date: 2018-03-16 06:25 CDT
category: roji
tags: roji
---

Roji is a respectful port of the Pixyll theme to the Middleman static site
generator. The original Liquid templates were replicated and rewritten for
Middleman's Embedded Ruby (ERB) language. Additional templates for categories
and tags were also created, which show how much effort goes into a
well-designed minimalist theme without adding unnecessary complexity. This was
a personal learning project, focused on using Middleman's flexibility to create
a straightforward blogging workflow. The goal was to honor the original theme
"crafted&nbsp;with&nbsp;<3" by John Otander.

Roji uses per-post directories and files to keep images, data, and stylesheets
organized and self-contained by using naming conventions linking an asset to a
post.

Images and YAML data files live in parallel directories named after the post's
filename inside images/posts/ and data/posts/. A single additional stylesheet
for each post is named after the post’s filename and placed in a designated
stylesheets directory for posts.

Small automation scripts help scaffold stylesheets, organize images, and audit
orphaned post-level assets like widowed data or image directories and
stylesheets, simplifying blogging workflows.

- **Data-Driven Content:** Posts use Embedded Ruby (ERB) templates to pull structured data from YAML files and place it within markdown or HTML. A rake task does the necessary setup for post-associated data, including sample data and code.

- **Page-Specific Styling:** Each post can have a unique stylesheet compiled separately from the main CSS bundle. A rake task creates a correctly named stub `.css.scss` file. The stub has an SCSS comment to be pasted into the front matter of the associated post as its 'stylesheet:' page data property, and it imports Pixyll's \_`variables.scss` file.

- **Image Management:** One flexible helper script manages post images by
  creating or using a directory named after the post, checking existing files
to avoid collisions, and allowing image name specification. It generates
markdown lines for image inclusion, optionally with kramdown attributes for CSS
classes and IDs. It fetches images from both the internet and local files, and
can be run multiple times to add images to a directory.

Because Middleman includes built-in Sass processing, additional stylesheets can
be organized in a limited sub-hierarchy under assets/stylesheets/, with
directories like additional_styles/ and additional_styles/posts/. This approach
keeps the Pixyll theme clean and uncluttered while enabling page- or
post-specific stylesheets clearly named for association.

Thanks to kramdown’s flexibility, CSS classes can be associated with markdown
block and span level elements, and markdown can be used within HTML tags,
enhancing styling and content control.

For detailed setup and examples, see the [Roji in Action guide][guide].

{:t: target="_blank"}

[guide]: 2018-03-16-roji-in-action-working-with-post-assets.html
