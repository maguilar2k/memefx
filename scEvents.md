# Events #

The Stage Controller can trigger events on window resize and move (onResize and onMove). You just need to declare the events handlers in the Stage Controller declaration:

```
    onResize: function(e) {
        println("resize to {e.width},{e.height} at {e.minX},{e.minY}");
    }

    onMove: function(e) {
        println("moved to {e.minX},{e.minY} with {e.width},{e.height}");
    }
```

The event handlers receive a Rectangle2D as parameter. It contains the coordinates of the Stage in the screen, and it dimensions.

Here is a complete declaration example:

```
var cs = ControlStage {
    initialPosition:ControlStage.RIGHT + ControlStage.TOP, persist:true
    checkMinWidth:true, minWidth:440, checkMinHeight:true, minHeight:270,
    stickyBorders:true

    onResize: function(e) {
        println("resize to {e.width},{e.height} at {e.minX},{e.minY}");
    }
    onMove: function(e) {
        println("moved to {e.minX},{e.minY} with {e.width},{e.height}");
    }
};
```

You can call a function too:

```
var cs = ControlStage { 
    initialPosition:ControlStage.RIGHT + ControlStage.TOP, persist:true
    checkMinWidth:true, minWidth:440, checkMinHeight:true, minHeight:270,
    stickyBorders:true

    onResize: function(e) {
        myFunction(e);
    }
};

function myFunction(rect:Rectangle2D) {
    ...
}
```