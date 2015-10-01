# How to... #

To setup a Stage Controller you just need to instantiate the `ControlStage` class and define [the behaviors and characteristics](scOptions.md) you wish to attach to your application, for example:

```
var cs = ControlStage { persist:true, persistFile: "appStage.per"
    initialPosition:ControlStage.RIGHT + ControlStage.TOP 
    checkMinWidth:true, minWidth:440, checkMinHeight:true, minHeight:270,
    stickyBorders:true
};
```

To learn about the available options, visit the [Options page](scOptions.md).

Next, you have to bind the Stage Controller to the Stage position and size attributes:

```
    width: bind cs.width with inverse
    height: bind cs.height with inverse
    x: bind cs.x with inverse
    y: bind cs.y with inverse
```

If you wish for the application to be able to persist it position and/or size through different sessions, you must include a persistStage() call at the Stage onClose function.

```
    onClose: function() { cs.persistStage() };
```

Finally, you have the option to handle two events triggered by the window resize and move:

```
    onResize: function(e) {
        println("resize to {e.width},{e.height} at {e.minX},{e.minY}");
    }
    onMove: function(e) {
        println("moved to {e.minX},{e.minY} with {e.width},{e.height}")
    };
```

**Note: You must setup a different filename in _persistFile_ for each application. persistFile is optional for Java Web Start apps, ONLY if the Java Web Start app is the only one in the same URL path.**


## Complete code ##

```
var cs = ControlStage { persist:true, persistFile: "appStage.per"
    initialPosition:ControlStage.RIGHT + ControlStage.TOP
    checkMinWidth:true, minWidth:440, checkMinHeight:true, minHeight:270,
    stickyBorders:true

    onResize: function(e) {
        println("resize to {e.width},{e.height} at {e.minX},{e.minY}");
    }
    onMove: function(e) {
        println("moved to {e.minX},{e.minY} with {e.width},{e.height}")
    };

};

Stage {
    // bind Stage (window) to the controller
    width: bind cs.width with inverse
    height: bind cs.height with inverse
    x: bind cs.x with inverse
    y: bind cs.y with inverse

    // on stage close, stores last position and size
    onClose: function() { cs.persistStage() };

    scene: Scene { 
        ...
```