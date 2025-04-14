
wrap a video that comes embedded in an iframe with div class video-responsive
doesn't hurt to put it in a figure as we've styled a figure to have no left or
right margins at less than small size.

<figure>
<p class="video-responsive">
<iframe width="767" height="511" src="https://www.youtube.com/embed/iuWBPpCL6q4" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</p>
<figcaption markdown="span">
標的を見詰める凜とした眼差しがとても美しい。 -- video
</figcaption>
</figure>

in _more-pixyll.scss_
figure img {
  max-height: 25rem;
  height: 70%;
  width: auto;
}

<figure>
<span markdown="span">
![](2012-01-01-example-article/archery-12-1600-1067.jpg)
</span>
<figcaption markdown="span">
Most _kyudojo_ use the seated form for daily practice
</figcaption>
</figure>

this

stylesheet: posts-a-harmoniously-balanced-image-2023-06-30
---


.mhnn {
    max-height: 25rem;
    scroll-margin-top: 4rem;
}

@media screen and (min-width: $viewport-small) {
    .mhnn {
        max-height: 17rem;
    }
}

// 7 ok 12 not 11 ok 10 ok with always some margin
@media screen and (min-width: $viewport-large + 14) {
    pre {
        margin-left: -10em;
        margin-right: -10em;
    }
}

_![](posts/you-are-standing-on-my-toes-2023-06-13/tokyo-pastel.jpg){: .right .mb1 .mhnn}_

[_![](){: .right .mb1 .mhnn #--id--}_](#--id--)

with the \_ emphasized float image  \_ a clearfix can help
{: .clearfix}




or inside mediat query
    // or
    .mhnn {
        max-height: none;
        // an maybe overide the 50% // width: 45%;
    }

or this

<style>
@media screen and (min-width: 32em) {
  .mhnn {
    max-height: 17rem;
  }
}
</style>

or this

{:mhnn: style="max-height: 17rem;"}

substitute command to make level 2 headers in lorem text

% s/\n\n\(^.\+$\)\n\n/\r\r## \1\r\r/

<figure>
<span markdown="span">
![](posts/there-was-a-phone-call-for-you-2023-06-12/bandit-queen.jpg)
</span>
<figcaption markdown="span">
bandit queen
</figcaption>
</figure>


![](posts/there-was-a-phone-call-for-you-2023-06-12/aspidistra.jpg){: .right}{: .mb1}

youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' https://www.youtube.com/watch?v=iuWBPpCL6q4

/* brutalist ban of images in post summary */

.post-summary hr,
.post-summary img {
display: none;
}

.post-summary .ps-x-out {
display: none;
}

.x-out {
display: none;
}

# an inline style
{: style="display: none;"}

# a class selector
{:.x-out}


## [More Examples](#MoreExamples){: .no-link-underline}{: style="color: #333;"}
{: #MoreExamples}

[![Build Status](https://travis-ci.org/kostya/myhtml.svg?branch=master)][myhtml]{: .no-link-underline}

<div class="x-out"  markdown="1">
[![Code Triagers Badge](https://www.codetriage.com/crystal-lang/crystal/badges/users.svg)](https://www.codetriage.com/crystal-lang/crystal)

---

[![born-and-raised](https://cloud.githubusercontent.com/assets/209371/13291809/022e2360-daf8-11e5-8be7-d02c1c8b38fb.png)](https://manas.tech/)
</div>


![Sketchy](audrey_tautou.jpg){: .x-outt}

image written reference style
![fauci]

[fauci]: https://factcheck.afp.com/sites/de...es/fauci_screenshot_trump_ad_0.png


# A class attrubte
{: .h4 }

# an inline style
{: style="display: none;"}

a command at : prompt to change all occurances of git hub flavored
code fence stuff ``` to kramdown ~~~    this assumes 0 or more leading spaces
followed by exactly 3 ``` marks. Likely to be exactly 3.

%s/^\\( *\\)```/\\1\\~\\~\\~/

1. that drawn through the parallels
   1.  is smaller
   1. whence the beginning of Capricorn
   {: lower-roman}
2. that drawn through the lines indicating the hours
   2. is greater
   2. are left to the imagination
READMORE
   {: lower-roman}
{: upper-roman}

{:lower-roman: style="list-style-type: lower-roman"}
{:upper-roman: style="list-style-type: upper-roman"}

Suggest **splat, splat**, _underscore_ for the **_win_**.
(strong, em) *** or ___ gives strong em order and double ** is perhaps
easier to count than double __ and _ for em (italics) seems fitter for that
than than strong (bold).

~~~
tags:
- jekyll install
- ruby install

tags: jekyll install, ruby install

tags: a, b

tags: ["jekyll install", "ruby install"]
~~~

adding stylesheet: to current page data
~~~
---
title: Flex media object
date: 2019-04-17 02:42 CDT
category: flex
tags: flex, test
stylesheet: johno/flexbox/media-object
---
~~~
yields
~~~
<!-- sometimes CSS -->
    <link href="../assets/stylesheets/johno/flexbox/media-object-3f378a07.css" rel="stylesheet" />
~~~
in
~~~
assets/stylesheets/johno/flexbox/media-object.css
~~~

adding footer_art: to current page data, one of

    404 applications art art-2 balloons birdnflags community default friends i18n library search_no-results search support

~~~
---
title: Footer art balloons
date: 2011-10-08 19:06 CDT
category: art test
tags: art test
footer_art: balloons
---

---
summary: >
  This is the summary of the article from the yaml
  meta data.

summary: |
  ### This is the summary of the article from the yaml

  * meta
  * data.

title: Example Article
date: 2012-01-01 02:02 CST
category: example
tags: example
---

~~~

    # The most awesome of classes
    class Awesome
      def email_format
        email =~ /\S+@\S+\.\S+/
      end
    end
{: .language-ruby}

~~~ ruby
def what?
  42
end
~~~

{:t}
{:t: target="_blank"}

text run through kramdown.

{::nomarkdown}
looks like a paragraph but isn't
Don’t process the body with kramdown but output it as-is.
{:/nomarkdown}

should be a paragraph


{::comment}
this becomes an html comment in the web page
{:/comment}

| Lang     | Shard      | Lib             | Parse time, s | Css time, s | Memory, MiB
| -----    | ----       | -----           |         ----: |       ----: |       ----:
| Crystal  | lexbor     | lexbor          |          2.39 |           - |         7.7
| Crystal  | myhtml     | myhtml(+modest) |          2.70 |        0.22 |         8.3
| Crystal  | Crystagiri | libxml2         |          8.02 |        8.59 |        75.4
| Crystal  | Gumbo      | Gumbo           |         18.18 |           - |      2140.7
| Ruby 2.7 | Nokogiri   | libxml2         |         20.15 |       23.02 |       132.8
{: .heading-font-family}
{: .monospace-font-family}
{: .font-family}
{: .h4}
{: rules="cols"}

| Left         | Default    | Centered         | Right
|:-            -            :--:               -:
| Crystal      | lexbor     | lexbor           | 11112.39
| Crystal      | myhtml     | myhtml (+modest) |     2.70
| Crystal      | Crystagiri | libxml2          |     8.02
| Crystal lang | Gumbo      | Gumbo            |    18.18
| Ruby 2.7     | Nokogiri   | libxml2          |    20.15
|=
|              |            | Footer row       | 22222.22
{: style="font-family: 'DejaVu Sans Mono_', Consolas, monospace; font-size: 1.0rem; "}

<!-- {: rules="cols" } -->


did this search and replace to add {:t} to some markdown links
doesn't work for [![alt text](img url)][http key]
doesn't work for [text][key], [text][], nor [text]
doesn't span link breaks
doesn't work for <url>
AND ALSO prolly don't want it to operate on internal links, those without http in them
recoverd it from command history with ctrl-f kkk then v for visual then lll then y for yank

% s/\(\[.\{-}(.\{-})\)/\1{:t}/g



getalong's [kramdown reference](http://kramdown.gettalong.org/syntax.html).
And [quick reference](http://kramdown.gettalong.org/quickref.html).

" macro in l register for links in kramdown document. Have 3 line of text.

" long text link  becomes [long text link][short id key]     # Reference Link
" short id key            [short id key]: the url            # Link Definition
" the url                 {:t}                               # Block IAL

" cursor sits at end 1st line, the Reference Link, G moves you down to bottom
" of page where Link Definition and Block IAL are. From there, `a takes you
" back to mark at end of 1st line, the Reference Link.

" @s macro inserts {:t: target="_blank"}
" @t macro

" long text link  becomes [long text link][short id key]{:t} # Link Definition and block IAL
" short id key            [short id key]: the url
" the url

$font-family: 'Merriweather', 'PT Serif', Georgia, 'Times New Roman', serif !default;
$heading-font-family: 'Lato', 'Helvetica Neue', Helvetica, sans-serif !default;
$monospace-font-family: 'DejaVu Sans Mono_', Consolas, monospace !default;
