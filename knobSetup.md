# Setup a knob #

When you setup a knob, you can define different type of parameters for the control:

  * position and size (translateX, scaleY, etc)
  * appearance (ui, dialLinesNumber, dialLinesColor, etc)
  * range of values handled by the control (min, max, etc)
  * kind of value returned (integerOnly, etc)
  * animation (animatedAutoAdjust, integerQuickAdjust, etc)
  * and the initial value

For a detailed explanation of the options, please check [this page](knobOptions.md).

A general definition of a knob should look like this:

```
var myKnob = Knob { ui: BasicKnob {}
    min: 0, max: 4000, minAngle:0, maxAngle:1440
    dialLinesLongEvery:5, dialLinesNumber:50, dialLinesWidth:1,
    translateX: -30, translateY:100
    scaleX: 0.5, scaleY: 0.5,
};
```

Now, you can bind the value in the knob (myKnob.value) to the attribute of another object:

```
                Rectangle {
                    x: 110, y: 150
                    width: bind myKnob.value / 10
                    height: 50
                    fill: Color.RED
                }
```

You can get the integer version of the current value in the knob using myKnob.integerValue

After that, you can reset the value in the knob (to the minimum value allowed) using myKnob.reset(). The knob will adjust instantaneously or with an animation, according to the setup of the knob. You can avoid the animation by using myKnob.reset(false)

For other functions available for the knob control, please, check [this page](knobFunctions.md).

The knob control allows you to setup a maximum angle (associated to the maximum value handled by the control) higher than 360 degrees, but, the number of lines in the gauge are limited to 360 degrees. Then, you can have a knob that reach it maximum value after many turns, but the number of lines in the gauge are distributed only up to 360 degrees... or in a shorter range if the difference between the minAngle and maxAngle is shorter than 360 degrees.