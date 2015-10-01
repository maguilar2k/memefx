# Alternatives #

![http://lh6.ggpht.com/_esUBlqKjDzk/SbmJWOFcGXI/AAAAAAAAAy0/nAykYeojxDY/normal.png](http://lh6.ggpht.com/_esUBlqKjDzk/SbmJWOFcGXI/AAAAAAAAAy0/nAykYeojxDY/normal.png)

You have four alternatives to modify the background of the component:

  * Change it color
  * Change it color applying a gradient
  * Replace the whole background with your own graphic elements
  * Hide the gauge body and place the component on top of another graphical elements

## Changing background color ##

![http://lh6.ggpht.com/_esUBlqKjDzk/SbmJWX-flnI/AAAAAAAAAy8/6EfM-RTFNS0/backcolor.png](http://lh6.ggpht.com/_esUBlqKjDzk/SbmJWX-flnI/AAAAAAAAAy8/6EfM-RTFNS0/backcolor.png)

You can apply a new color to the background of the gauge. To do this you need to:

Create an instance of the [type of gauge](gaugeGtypes.md) that you want to use
```
    var gaugeTypeUsed=BasicGauge{}
```
Next, you create you Gauge control
```
var myGauge = Gauge {
    ui: gaugeTypeUsed
    primaryLabel: "Km/H"
    secondaryLabel: "Current\nSpeed"
    min: 0.0,
    max: 100.0
    dialNumsVisibleEvery: 2
    value: bind knob2.value
    dialLongLinesColor: Color.YELLOW
    background: gaugeTypeUsed.customBackground(Color.DARKBLUE)
};
```
The new color is set in this line:
```
    background: gaugeTypeUsed.customBackground(Color.DARKBLUE)
```

## Applying a gradient to the background ##

![http://lh5.ggpht.com/_esUBlqKjDzk/SbmJWTm2-cI/AAAAAAAAAzE/u5F82Mn_pmk/backgradient.png](http://lh5.ggpht.com/_esUBlqKjDzk/SbmJWTm2-cI/AAAAAAAAAzE/u5F82Mn_pmk/backgradient.png)

Like in the previous example, to apply a gradient to the background of the gauge, you have to create an instance of the [type of gauge](gaugeGtypes.md) in use, previously to the definition of the gauge control:

```
    var gaugeTypeUsed=BasicGauge{}
```
Next, you create you Gauge control
```
var myGauge = Gauge {
    ui: gaugeTypeUsed
    primaryLabel: "Km/H"
    secondaryLabel: "Current\nSpeed"
    min: 0.0,
    max: 100.0
    dialNumsVisibleEvery: 2
    value: bind knob2.value
    dialLongLinesColor: Color.YELLOW
    background: gaugeTypeUsed.customBackground(
        RadialGradient {
        centerX: 60, centerY: 80
        //focusX: 0.1, focusY: 0.1
        radius: 103
        proportional: false
        stops: [
            Stop {
                color: Color.WHITE
                offset: 0.0
            },
            Stop {
                color: Color.DARKBLUE
                offset: 1.0
            }
        ]
    })
};
```
As you can see, instead of assigning a plain color to the background, you can provide a gradient.

## A complete custom background and body ##

![http://lh6.ggpht.com/_esUBlqKjDzk/SbmNMU8fg6I/AAAAAAAAAzM/LUlIKEmP9P8/backcustom.png](http://lh6.ggpht.com/_esUBlqKjDzk/SbmNMU8fg6I/AAAAAAAAAzM/LUlIKEmP9P8/backcustom.png)

Finally, you can provide a complete new background for the gauge. In this case, you don't need to declare the [type of gauge](gaugeGtypes.md) in use separated from the gauge definition, you can provide the new background elements directly in the gauge definition, in the background parameter:

```
var myGauge = Gauge {
    ui: FlatRectGauge {}

    ...

    background: Group { content: [
            Rectangle {
                x: 10,
                y: 10
                arcHeight: 20
                arcWidth: 20
                width: 260,
                height: 180
                fill: Color.RED
            }
            Circle {
                centerX: 140,
                centerY: 52
                radius: 125
                fill: Color.DARKRED
                opacity: 0.5
                clip: Rectangle {
                    x: 15,
                    y: 35,
                    width: 250,
                    height: 180
                    arcHeight: 20,
                    arcWidth: 20
                }
        }]
    }
```
Once you provide a custom background, the gauge default background element becomes invisible. But the body of the gauge will remain visible. You can hide the default body of the gauge and the standard decoration using the bodyVisible:false and decorationVisible:false, to replace the whole appearance of the gauge.