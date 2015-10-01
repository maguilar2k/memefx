# How to setup a HTML text #

The TextHTML control supports pretty much the same attribute of the standard Text control, to make it easy to replace it.

```
TextHTML {

    x: 20,
    y: 20,
    wrappingWidth: 300

    content:
        "<p align=justify><font size=24 color=#ffff00>Easter "
        "Island</font> <i>(Rapa Nui)</i> is a Polynesian island "
        "in the southeastern <font size=24 face=Verdana "
        "color=#ff5555>Pacific Ocean</font>. The island is a "
        "<font face=TimesRoman size=24  color=#55ffff><a href=something>"
        "special</a> <i>territory</i></font> of <a href=Chile>"
        "Chile</a>. Easter Island is famous for its monumental "
        "statues, called <font color=#00ff00 size=18>moai.</font></p>"

    onLinkPressed: function(link) { println(link) }

}
```