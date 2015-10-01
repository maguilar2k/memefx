# Popup Menu #

This control allows you to attach a pop up menu to the elements of your user interface.

## An example ##

First, we create a couple of graphic element:

```
var circle1 = Circle {
    id: "yellow circle"
    centerX: 220, centerY: 300, radius: 60
    fill: Color.YELLOW
};

var circle2 = Circle {
    id: "red circle"
    centerX: 100, centerY: 100, radius: 40
    fill: Color.RED
};
```

Next, we define a popup menu (you can use many parameters to customize the menu appearance):

```
var popupCircle = PopupMenu{
    font: Font { size: 16, name: "Verdana" };
    fill: Color.PURPLE
    stroke: Color.WHITE
    opacity: 0.9
    shadowX: 10, shadowY: 10
    verticalSpacing: 10
    highlight: Color.YELLOW

    content: [
        MenuItem { text: "Option #1\n"
                         "Get Circle ID", callId: id },
        MenuItem { text: "Option #2\n"
                         "Animate Circle!", callNode: node }
    ]

};
```

Now, we define the functions called when a user selects a menu option (the "type of call" used indicate the parameters the menu will return).

  * callId returns the Node id
  * callNode returns a reference to the Node over which the popup menu was activated.

```
function id(id:String):Void {
    textfield.text="Action on {id}";
};

function node(node:Node):Void {
    Timeline {
        repeatCount: 4
        autoReverse: true
        keyFrames: [
            at (0s) {node.scaleX => 1.0; node.scaleY => 1.0 }
            at (0.2s) {node.scaleX => 1.4; node.scaleY => 1.4}
        ]
    }.play();
};
```

At this point we can bind the popup menu to the circles:

```
popupCircle.to(circle1);
popupCircle.to(circle2);
```

Finally, we setup the Stage:

```
Stage {
    scene: Scene {
        content: [
            circle1, circle2
            // activate popup menus
            PopupMenu.activateMenus()
        ]
    }
}
```

It's a pretty simple and straight forward method.