# Example #

![http://lh3.ggpht.com/_esUBlqKjDzk/SenumBOdj3I/AAAAAAAABPU/ysg6fXV4uJM/texthtml.png](http://lh3.ggpht.com/_esUBlqKjDzk/SenumBOdj3I/AAAAAAAABPU/ysg6fXV4uJM/texthtml.png)

```

/* GLOBAL background color for links, across all the TextHTML controls */
TextHTML.mainOnLinkExitedColor = Color.DARKBLUE;

/* GLOBAL function to capture all mouse over link, across all the TextHTML controls */
TextHTML.mainOnLinkEntered = globalFunction;

/* GLOBAL function to capture all links clicked, across all the TextHTML controls */
TextHTML.mainOnLinkPressed = globalFunction;

function globalFunction(link:String) {
    ...
}


...


Rectangle {

    x: 5, y: 14
    width: 330, height: 160
    fill: Color.BLACK
    opacity:0.7
    arcHeight:16
    arcWidth:16

},

TextHTML {

    x: 20,
    y: 20,
    wrappingWidth: 300

    /* base font attributes */
    basicTextAttrib: TextAttributes {
        color:Color.WHITE
        size:17
    }

    content:
        "<p align=justify><font size=24 color=#ffff00>Easter "
        "Island</font> <i>(Rapa Nui)</i> is a Polynesian island "
        "in the southeastern <font size=24 face=Verdana "
        "color=#ff5555>Pacific Ocean</font>. The island is a "
        "<font face=TimesRoman size=24  color=#55ffff><a href=something>"
        "special</a> <i>territory</i></font> of <a href=Chile>"
        "Chile</a>. Easter Island is famous for its monumental "
        "statues, called <font color=#00ff00 size=18>moai.</font></p>"

    /* custom function for the links clicked in THIS CONTROL */
    onLinkPressed: function(link) { println(link) }

    /* custom background color for mouse over a link in THIS CONTROL */
    onLinkEnteredColor: Color.RED

    /* custom function triggered on mouse exiting a link in THIS CONTROL */
    onLinkExited: function(link) { println(link) }

}
```