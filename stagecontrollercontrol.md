# Stage Controller #

<a href='http://www.youtube.com/watch?feature=player_embedded&v=DHlLrnF3Qxg' target='_blank'><img src='http://img.youtube.com/vi/DHlLrnF3Qxg/0.jpg' width='425' height=344 /></a>

This class allows you to attach some automatic behaviors to your JavaFX app window (Stage). For example, you can make the window to stick to the edges of the screen with a simple stickyBorders:true or select the borders you want to make sticky, ie. stickyLeft:true

You can persist the position and/or size of the window from session to session (with a simple persist:true, persistPosition:true or persistSize:true). You can anchor the window to the borders too (ie. anchorBottom:true). Enforce minimum and maximum sizes or enforce a specific size for the window or keep it in the middle of the screen, etc.

It can trigger two events that you can handle: onResize and onMove, so, your app can obtain it screen position and size at any moment.

  * [Intro/demo video](http://www.youtube.com/watch?v=DHlLrnF3Qxg) (same video on the top)
  * [Java Web Start demo](http://javafxdemo.appspot.com/jfx/stageController.jnlp)

  * [Events handling demo video](http://www.youtube.com/watch?v=Jmm6Yd1jlR8)
  * [Java Web Start events handling demo (onResize, onMove)](http://javafxdemo.appspot.com/jfx/stageControllerDemo.jnlp)

# Details #

  * [How to use the Stage Controller](scHowto.md)
  * [Stage Controller options](scOptions.md)
  * [Positioning constants](scPositioning.md)
  * [Stage Controller functions](scFunctions.md)
  * [Handling onResize and onMove events](scEvents.md)
  * [Obtaining the screen resolution](scScreenres.md)