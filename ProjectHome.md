This library provides a set of rich components for the JavaFX platform.

### New `TextHTML` component ###

![http://lh3.ggpht.com/_esUBlqKjDzk/SenumBOdj3I/AAAAAAAABPU/ysg6fXV4uJM/texthtml.png](http://lh3.ggpht.com/_esUBlqKjDzk/SenumBOdj3I/AAAAAAAABPU/ysg6fXV4uJM/texthtml.png)

# Java Web Start Demos #

**Requires Java 6 update 10 or later. [Click Here](http://www.java.com) to get it.**

  * [TextHTML control demo](http://javafxdemo.appspot.com/jfx/HTMLTest.jnlp)
  * [ImagesAccordion control demo](http://javafxdemo.appspot.com/jfx/imgFX.jnlp)
  * [Gauge + Knob controls demo](http://javafxdemo.appspot.com/jfx/democombo.jnlp)
  * [Knob control demo](http://javafxdemo.appspot.com/jfx/Knob.jnlp)
  * [Stage Controller basic demo](http://javafxdemo.appspot.com/jfx/stageController.jnlp)
  * [Stage Controller events demo](http://javafxdemo.appspot.com/jfx/stageControllerDemo.jnlp)
  * [Graphical PopupMenu control demo](http://javafxdemo.appspot.com/jfx/popupMenu.jnlp) (experimental)

<font color='red'><b><i>Notice how the demos persist -position and size- from session to session, that's because the Stage Controller component.</i></b></font>

# Documentation #

  * [TextHTML control](txthtmlIntro.md)
  * [ImagesAccordion control](accordIntro.md)
  * [Stage controller](stagecontrollercontrol.md)
  * [Gauge control](gaugeintro.md)
  * [Knob control](knobcontrol.md)
  * [PopupMenu](popupmenuIntro.md) (experimental)

## Latest memeFX library updates ##

  * v0.3.4 TextHTML: bug fixed, new instance functions `onLinkEntered` and `onLinkExited`, new global functions `mainOnLinkEntered` and `mainOnLinkExited`, new instance link background colors: `onLinkEnteredColor`, `onLinkExitedColor` and global link background colors: `mainOnLinkEnteredColor` and `mainOnLinkExitedColor` (see [documentation](txthtmlOptions.md) for details).
  * v0.3.3 TextHTML: bug fixed, tag "`font name=`" renamed to "`font face=`", `onClick` function renamed as `onLinkPressed`, implementation of a global function to capture all the links clicked accross all the TextHTML controls (see [documentation](txthtmlOptions.md) for details). ImagesAccordion: `onClick` item function renamed as `onLinkPressed`.
  * v0.3.2 TextHTML re-engineered code
  * v0.3.1 TextHTML bug fix
  * v0.3.0 **NEW HTML TEXT COMPONENT (TextHTML)**, ImagesAccordion now supports HTML text
  * v0.2.6 Gauge.INMEDIATE renamed as Gauge.IMMEDIATE
  * v0.2.5 April 7, 2009 - Cursor setup for ImagesAccordion & Knob controls
  * v0.2.4 March 27, 2009 - ImagesAccordion orientation + functions (select, next & previous). Additional speed configuration for Gauge control (speed:Gauge.USERDEFINED + userDefinedSpeed:duration) and Knob control (speed:duration).


## Demos code ##

  * Download the demos source code from the [download section](http://code.google.com/p/memefx/downloads/list).

## Experimental code ##

  * This code not necessarily will be included in future releases of the library.

# JavaFX tip #

<font color='red'><b>It's always a good idea to include the canSkip:true parameter into the Timelines related to animations. <a href='http://www.youtube.com/watch?v=DCD6HdP1hxQ'>Check this video</a></b></font>

# Memes #

**_A meme (pronounced /miːm/ - like theme) is a theorietical unit or element of cultural ideas, symbols or practices; such units or elements transmit from one mind to another through speech, gestures, rituals, or other imitable phenomena. The etymology of the term relates to the Greek word mimema for mimic. Memes act as cultural analogues to genes in that they self-replicate and respond to selective pressures._**

[Susan Blackmore: Memes and "temes"](http://www.youtube.com/watch?v=fQ_9-Qx5Hz4)