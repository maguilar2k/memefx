# Color selector #

This knob allows the user to select a value from between a reduced number of options. If the user sets the value manually, the control "jumps" to the nearest option/value instantaneously. If the value for the knob is set programmatically, it slides softly to the nearest option.
```
/** Color options */
var colors = [Color.RED, Color.BLUE, Color.YELLOW, Color.GREENYELLOW,
    Color.PURPLE, Color.CYAN, Color.BROWN];

/** Color selector */
var colorSelector = Knob { 
    ui: BasicKnob{}, dialLinesColor: Color.RED    
    min:1, max:bind sizeof colors, dialLinesNumber: bind sizeof colors
    integerOnly:true, animatedAutoAdjust:true, integerQuickAdjust:true
    scaleX: 0.5, scaleY:0.5, translateX:160
};

...

                Circle {
                    centerX: 200,
                    centerY: 200
                    radius: 100
                    fill: bind colors[colorSelector.integerValue - 1]
                }
```

# On/Off switch #

This knob allows the user to set an on/off switch. It returns an integer value of 0 or 1.

```
/** on/off switch */
var onSwitch = Knob{ ui: SwitchKnob{},
    min:0, max:1, value:0, minAngle:-30, maxAngle:30
    dialLinesNumber:2, dialLinesWidth:5
    integerOnly:true, integerQuickAdjust:true
    scaleX:0.7, scaleY:0.7, translateX:240, translateY:380
};

/** light bulb image for on/off switch */
var imgName = bind if (onSwitch.integerValue == 1) then
        "{__DIR__}bulbon.gif" else "{__DIR__}bulboff.gif";

...

                ImageView {
                    x: 380, y: 380
                    image: bind Image { url: imgName }
                },
```

# Many turns #

This knob allows the user to set a precise value having to turn the knob many times to pick a value:

```
var lenghtSelector = Knob{ ui: BasicKnob {}
    min: 0, max: 4000, minAngle:0, maxAngle:1440
    dialLinesLongEvery:5, dialLinesNumber:50, dialLinesWidth:1,
    translateX: -30, translateY:100
    scaleX: 0.5, scaleY: 0.5,
};

...

                Rectangle {
                    x: 110, y: 150
                    width: bind lenghtSelector.value / 12
                    height: 50
                    fill: Color.RED
                }

```