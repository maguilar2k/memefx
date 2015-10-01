# Valid HTML #

Note: implements just a limited number of tags and options. The control's HTML is pretty "strict", i.e. you can't use quotes for the values: `<font size="20">` is incorrect, you should use `<font size=20>`. You can't include additional spaces inside the tags: `<font color= #ffff00>` is incorrect, you should use `<font color=#ffff00>`. The component doesn't support images yet.

**`<font ...> ... </font>`**

> options:

  * size=...
> > font size (in pixels)

  * color=#rrggbb
> > Hex (RGB) color

  * face=...
> > font name

**`<a href=...> ... </a>`**


> href= "link" or id returned when a link is clicked

**`<i> ... </i>`**

> Italic font

**`<b> ... </b>`**

> Bold font

**`<p align=...> ... </p>`**

> Paragraph & alignment

> options:

  * left

  * right

  * center

  * justify

**`<br>`**

> break-line


---


**Special chars:**

> &quot;  ---> "

> &nbsp;  ---> non-breaking space

> &lt;    ---> <

> &gt;    ---> >

> &euro;  ---> €

> &amp;   ---> &