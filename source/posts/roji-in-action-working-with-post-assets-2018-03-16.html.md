---
title: "Roji in action: working with post assets"
date: 2018-03-16 04:25 CDT
category: roji
tags: roji
stylesheet: additional_styles/posts/roji-in-action-working-with-post-assets-2018-03-16
---

## Workflows in this Guide

- [Workflow 1: How to Add Styled Images to Your Post](#image-flow)
- [Workflow 2: How to Use Data-Driven Content in Your Posts](#data-flow)
- [Appendix: Cleaning Up Post Assets with find_widows](#appendix)
{: .workflow-menu}

This guide walks through **two typical post workflows**READMORE:

1. **Images + Stylesheets** – fetching images into a per‑post directory, and creating a page‑scoped stylesheet.
2. **Post Data** – generating a sample data file with a rake task, and ERB code that injects the YAML data as markdown text.

Each workflow illustrates how Roji adopts per-post asset directories to keep content structured, self-contained, and easy to manage.

**Step 0:** At the moment we need the micro-optparse gem installed, globally.
Check for its presence with `gem list micro-optparse`. Install the gem via
`gem install micro-optparse`, it's quite tiny.

# How to Add Styled Images to Your Post
{: #image-flow}

This guide walks you through the exact steps to add styled images to your blog post using the example files and scripts.

## Step 1: Prepare Your Post Markdown

1. Copy an already example post markdown file to your source/posts/
   directory.  Navigate to the source/posts directory and do 

   ~~~
   cp ../../examples/example-post-with-images/example-with-styled-images-2025-08-28.html.md .
   ~~~
  **Note the trailing dot** indicating the current directory.

2. This file contains YAML front matter and just enough lorem text to float some images around.

## Step 2: Generate Image Markdown Lines

1. Run the image processing script **from the `source/posts` directory**,
supplying the relative path to the example input file.

   ~~~
   ../../utils/do_images.rb ../../examples/example-post-with-images/input-for-do-images.txt > /tmp/mk_lines.txt
   ~~~

   Compare `input-for-do-images.txt` with the output of `do_images.rb --help`. The
   second markdown pattern line can be as simple as `![]()`.

2. The script copies source images into your post's image directory with unique
   names and generates markdown lines linking to those images.

3. Review the Markdown lines saved in `/tmp/mk_lines.txt`.

## Step 3: Add Generated Markdown to Your Post

1. Edit the post markdown file in `source/posts` and insert the image markdown
   lines from `/tmp/mk_lines.txt` at the positions you want the images to
   appear. In the following code snippet, the lines to add are pointed to with
   '>>' chars.

   ~~~
      ## The Ancient Period

   >> [_![](posts/example-with-styled-images-2025-08-28/dorthy-toto.jpg){: .right .mb1 .mhnn #dorthy-toto}_](#dorthy-toto)
      From the fourth to the ninth century, Chinese culture strongly influenced the
      .
      .
      .
      from official inspectors.

   >> [_![](posts/example-with-styled-images-2025-08-28/dorthy-toto-2.jpg){: .left .mb1 .mhnn #dorthy-toto-2}_](#dorthy-toto-2)
      An increasing amount of land thus passed into true private holdings. Then, as
   ~~~

   Add the markdown for the images at the start of a paragraph in this case, no empty line between
   the added markdown and the paragraph text.

   Add above the lines starting with `From the fourth` and `An increasing amount`.

   Edit the second image's markdown to have class `.left` instead of `.right`, to *__float__ the second
   image to the __left__*.

2. Save the file. You can `bundle middleman build` at this time. Should look
OK. Usually we would add one image, then style it to see how much vertical
space it takes. In this case both images without additional styling look OK.
Try narrowing the view width of the browser.

## Step 4: Update the Stylesheet

1. Run the rake task to generate the stylesheet: (easiest when still in source/posts directory, as
you can do filename completion for the file name.)

   ~~~
   rake make_extra_css example-with-styled-images-2025-08-28.html.md
   ~~~

   This will create an  SCSS file at:

   ~~~
   ../assets/stylesheets/additional_styles/posts/example-with-styled-images-2025-08-28.css.scss
   ~~~

   We now have an image directory and a .css.scss file both named after the
   blog post. When/if we delete the blog post, we have a rake task that finds the
   widowed file and directory and reminds you they exist.

2. Edit the stylesheet file to append the example CSS rules (copy from
   `examples/complete-scss-style-contents.css.scss`).

   ~~~
   // stylesheet: additional_styles/posts/example-with-styled-images-2025-08-28

   @charset "utf-8";

   @import '../../_sass/_variables.scss';

   // Append the following lines / css rules to the file with the above contents.
   // Its location is
   //     assets/stylesheets/additional_styles/posts/example-with-styled-images-2025-08-28.css.scss
   // Keep the first line comment, // stylesheet: ...
   // It will be copied to the page meta data as a property.

   .mhnn {
       max-height: 25rem;
       scroll-margin-top: 4rem;
   }

   @media screen and (min-width: $viewport-small) {
       .mhnn {
           max-height: 17rem;
       }
   }
   ~~~

   So one thing we've done is to make available sass variables, you can see `$viewport-small` being
   used in the media query. The `.mhnn` class was already named in the markdown image lines we
   generated. Not implausible, we could anticipate needing a style class, and choose a generic name.

3. Copy the special comment line at the top of the stylesheet file (i.e., `//
stylesheet: additional_styles/posts/example-with-styled-images-2025-08-28`) and
paste it into the post's YAML front matter as the `stylesheet:` property.

   ~~~
      ---
      title: Example with styled images
      date: 2025-08-28 21:52 CDT
      category: test
      tags: test
   >> stylesheet: additional_styles/posts/example-with-styled-images-2025-08-28
      ---

      The question of Jimmu's existence is a subject outside the scope of this book,
      but it is interesting to note that in paintings and descriptions of his life,
      Jimmu is always depicted with a long bow and arrows.
   ~~~

4. Save the stylesheet and post markdown file.

## Step 5: Build and Preview

Run your build process (e.g., `middleman build` or equivalent) and preview the
post to see the styled images correctly rendered within your post.

Tip: After deleting this example post, run rake find_widows to identify any
orphaned post assets that you'll remove manually. See [Appendix: Cleaning Up](#appendix)

# How to Use Data-Driven Content in Your Posts
{: #data-flow}

This section covers generating a sample data file, that has boiler plate Embedded Ruby that you cut and past into an otherwise empty blog post. The blog post has final extension .erb , as in some-filename.html.md.erb.

## Step 1: Prepare Your Post Markdown

1. Copy an already example post markdown file to your source/posts/
   directory.  Navigate to the source/posts directory and do 

   ~~~
   cp ../../examples/example-post-using-data/example-using-data-2025-08-28.html.md.erb .
   ~~~
  **Note the trailing dot** indicating the current directory.

2. This file only contains YAML front matter. 

   The actual content will come from the data file generated in the next step.
   Inside that data file, we will cut out the ERB/Markdown sample code block and
   paste it into this .html.md.erb post.

## Step 2: Generate directory with example data and code

1. Run the rake task to generate the data: (easiest when still in source/posts directory, as
you can do filename completion for the file name.)

   ~~~
   rake use_data example-using-data-2025-08-28.html.md.erb
   ~~~

2. This will create a YAML data file at:

   ~~~
   ../../data/posts/example_using_data_2025_08_28/a.yml
   ~~~

   There could be more than one data file in the directory, but we have placed one.
   If you look at it, there is code at the end of it. We will cut that out next.

## Step 3: Add generated erb code to the .md.erb file

1. Edit both the data file `a.yml` and the post file `example-using-data-2025-08-28.html.md.erb`

2. In `a.yml` delete the comment block after the data and before the code.

3. Cut the code from the data file, and paste it after the front matter of the post.

   ~~~
   - :name: Faye Wong
     :img: https://spaceecho.chromewaves.net/wp-content/uploads/2021/05/chunkingexpress-868x488.jpeg
     :movies:
     - Chungking Express (1994)
     - 2046 (2004)

   ############
   ## make sure you RENAME THE POST FILE BY APPENDING .erb to the file name if you
   ## haven't already.
   ############

   <% elements = data.posts.example_using_data_2025_08_28.a %>

   <%# The initial map/join incorporates the name values from the data into the page summary. %>

   <% current_page.data.summary = elements.map { |e| "### #{e[:name]}\n\n" }.join %>
   ~~~

4. Save both files, the data file that has only data now, and the post that has the code
   cut from the data file and pasted in the body of the example post, after the front matter.

5. **If you lose the text you were editing**, the data and code boilerplate file is
   preserved at

   ~~~
   ../../utils/use_data_separate_boilerplate.txt
   ~~~

## Step 4: Update the Stylesheet

Additional stylesheet? We don't need no stinking additional styletheet!

## Step 5: Build and Preview

Run your build process (e.g., `middleman build` or equivalent) and preview the post. 

Oh look, the internet says Maggie Cheung also was in the movie "2046". Duplicate
that line in the `a.yml` file put it the Maggie Cheung list of movies too. Run the build.

Tip: After deleting this example post, run rake find_widows to identify any
orphaned post assets that you'll remove manually. See [Appendix: Cleaning Up](#appendix)

# Appendix: Cleaning Up Post Assets with find_widows
{: #appendix}

Both workflows create assets named after your post:

: Workflow 1 adds a per‑post image directory and a stylesheet.

: Workflow 2 adds a per‑post data directory.

If you later delete a post, these supporting assets are left behind. To keep
your project clean, Roji includes the find_widows task.

1. Run the Audit

   Anywhere in the project hierarchy run

   ~~~
   rake find_widows
   ~~~

   Sample clean result:

   ~~~
   no widowed image directories found
   no widowed style files found
   no widowed DATA directories found
   ~~~

   Sample result after deleting example-with-styled-images-2025-08-28.html.md:

   ~~~
   widowed image directories are:
   example-with-styled-images-2025-08-28
   widowed style files are:
   example-with-styled-images-2025-08-28
   no widowed DATA directories found
   ~~~

2. Remove Orphaned Assets

   Delete the orphaned files and directories that no longer have a matching post:

   ~~~
   rm -rf source/assets/images/posts/example-with-styled-images-2025-08-28
   rm -f source/assets/stylesheets/additional_styles/posts/example-with-styled-images-2025-08-28.css.scss
   # if the  example-using-data-2025-08-28.html.md.erb was deleted
   # rm -rf data/posts/example_using_data_2025_08_28
   ~~~

   That’s it - assets are now in sync with your posts.

3. Notes on Data Directories

   Workflow 2 uses underscores (\_) instead of hyphens (-) when creating the data/posts/ directory.

   This is required because Middleman treats entries in data/ as methods:

   ~~~
   <% elements = data.posts.example_using_data_2025_08_28.a %>
   ~~~

   Hyphens (-) would break this.

   If you remove a data‑driven post, remember to rm -rf its matching underscore‑named directory.

When to Use

: Each time you delete a test or example post.

: Periodically, to tidy up experiments or drafts.

You’ll run through this often if you practice creating and removing posts — the steps become second nature: build, test, delete, clean with find_widows, repeat.

**Tip for safety**: Use ls + tab‑completion first, then arrow back to the beginning of the line and replace ls with rm or rm -rf. It’s a simple trick that avoids fat‑fingering the wrong filename.
