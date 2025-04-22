---
title: Pixyll in Action
date: 2017-10-10 18:39 CDT
category: pixyll
tags: pixyll
---
{::options syntax_highlighter="coderay" /}
{::options syntax_highlighter_opts="{line_numbers: false\}" /}

<!--
:syntax_highlighter: :coderay
:syntax_highlighter_opts:
  block:
    css: class
  default_lang: ruby
  wrap: span
line_numbers: null
-->

There is a significant amount of subtle, yet precisely calibrated,
styling to ensure that your content is emphasized while still looking
aesthetically pleasing.

All links are easy to [locate and discern](#), yet don’t detract from
the [harmony of a paragraph](#). The *same* goes for italics and
**bold** elements. Even the the strikeout works if <del>for some reason
you need to update your post</del>. For consistency’s sake, <ins>The
same goes for insertions</ins>, of course.

### Code, with syntax highlighting   {#code-with-syntax-highlighting}

Here’s an example of some ruby code with line anchors.

    # The most awesome of classes
    class Awesome < ActiveRecord::Base
      include EvenMoreAwesome
    
      validates_presence_of :something
      validates :email, email_format: true
    
      def initialize(email, name = nil)
        self.email = email
        self.name = name
        self.favorite_number = 12
        puts 'created awesomeness'
      end
    
      def email_format
        email =~ /\S+@\S+\.\S+/
      end
    end
{: .language-ruby}

Here’s some CSS:

    .foobar {
      /* Named colors rule */
      color: tomato;
    }
{: .language-css}

Here’s some JavaScript:

    var isPresent = require('is-present')
    
    module.exports = function doStuff(things) {
      if (isPresent(things)) {
        doOtherStuff(things)
      }
    }
{: .language-js}

Here’s some HTML:

    <div class="m0 p0 bg-blue white">
      <h3 class="h1">Hello, world!</h3>
    </div>
{: .language-html}


# Headings!   {#headings}

They’re responsive, and well-proportioned (in `padding`{: class=""},
`line-height`{: class=""}, `margin`{: class=""}, and `font-size`{:
class=""}). They also heavily rely on the awesome utility, [BASSCSS][2].

##### They draw the perfect amount of attention   {#they-draw-the-perfect-amount-of-attention}

This allows your content to have the proper informational and contextual
hierarchy. Yay.

### There are lists, too   {#there-are-lists-too}

* Apples
* Oranges
* Potatoes
* Milk

1.  Mow the lawn
2.  Feed the dog
3.  Dance

### Images look great, too   {#images-look-great-too}

![desk](https://cloud.githubusercontent.com/assets/1424573/3378137/abac6d7c-fbe6-11e3-8e09-55745b6a8176.png)

*![desk](https://cloud.githubusercontent.com/assets/1424573/3378137/abac6d7c-fbe6-11e3-8e09-55745b6a8176.png)*

### There are also pretty colors   {#there-are-also-pretty-colors}

Also the result of [BASSCSS][2], you can <span class="bg-dark-gray
white">highlight</span> certain components of a <span
class="red">post</span> <span class="mid-gray">with</span> <span
class="green">CSS</span> <span class="orange">classes</span>.

I don’t recommend using blue, though. It looks like a <span
class="blue">link</span>.

### Footnotes!   {#footnotes}

Markdown footnotes are supported, and they look great! Simply put e.g.
`[^1]`{: class=""} where you want the footnote to appear,[^1]{: .footnote}
and then add the reference at
the end of your markdown.

### Stylish blockquotes included   {#stylish-blockquotes-included}

You can use the markdown quote syntax, `>`{: class=""} for simple
quotes.

> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse
> quis porta mauris.

However, you need to inject html if you’d like a citation footer. I will
be working on a way to hopefully sidestep this inconvenience.

> Perfection is achieved, not when there is nothing more to add, but
> when there is nothing left to take away.
> 
> <footer>
> <cite title="Antoine de Saint-Exupéry">Antoine de Saint-Exupéry</cite>
> </footer>


### Tables

Tables represent tabular data and can be built using markdown syntax.  They are rendered responsively in Pixyll for a variety of screen widths.

Here's a simple example of a table:

| Quantity | Description |     Price |
|----------+-------------+----------:|
|        2 |      Orange |     $0.99 |
|        1 |   Pineapple |     $2.99 |
|        4 |      Banana |     $0.39 |
|==========|=============|===========|
|          |   **Total** | **$6.14** |

A table must have a body of one or more rows, but can optionally also have a header or footer.

The cells in a column, including the header row cell, can either be aligned:

- left,
- right or
- center.

Most inline text formatting is available in table cells, block-level formatting are not.

|----------------+----------------------+------------------------+----------------------------------|
| Default header | Left header          |     Center header      |                     Right header |
|----------------|:---------------------|:----------------------:|---------------------------------:|
| Default        | Left                 |        Center          |                            Right |
| *Italic*       | **Bold**             |   ***Bold italic***    |                      `monospace` |
| [link text](#) | ```code```           |     ~~Strikeout~~      |              <ins>Insertion<ins> |
| line<br/>break | "Smart quotes"       | <mark>highlight</mark> | <span class="green">green</span> |
| Footnote[^2]   | <sub>subscript</sub> | <sup>superscript</sup> |     <span class="red">red</span> |
|================+======================+========================+==================================+
| Footer row                                                                                        |
|----------------+----------------------+------------------------+----------------------------------|

### There’s more being added all the time   {#theres-more-being-added-all-the-time}

Checkout the [Github repository][3] to request, or add, features.

Happy writing.

* * *

<div class="footnotes" markdown="1">
[^1]: Important information that may distract from the main text can go in
    footnotes.
^

[^2]: Footnotes will work in tables since they're just links.
^
</div>

[1]: http://pixyll.com
[2]: http://www.basscss.com/
[3]: https://github.com/johnotander/pixyll
[4]: http://johnotander.com
[5]: https://twitter.com/4lpine
