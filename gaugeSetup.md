This is the basic form to setup a gauge control:

```
var gauge1 = Gauge {
    ui: BasicGauge{}
    primaryLabel: "Km/H"
    secondaryLabel: "Speed"
    min: 0.0, max: 100.0
    value: 50.0
};
```
Basically you define a new control of the class `Gauge`. Next, you assign a visual appearance to the control, a type of control (`ui:BasicGauge{}`).

This type of gauge (`BasicGauge`) contains basic information about the gauge and it appearance. It includes the graphical resources for the control and initial information about it. For example, where is locate the rotating point of the needle, which is the minimum and maximum angle related to the minimum and maximum values in the gauge respectively. A few radius for the dial lines, numbers and highlighted ranges in the gauge, colors and fonts for the numbers, etc. (those are just initial parameters that you can customize).

The benefit of using this "types" of gauges, is that, you can replace and switch the whole look-and-feel of a gauge just by replacing the type, without having to adjust all the parameters manually. You just need to replace the `ui:BasicGauge` with a `ui:RectInvGauge` to go from a round basic gauge -with 300 degrees available for the needle to rotate- to a rectangular gauge with and inverted needle with a range of only 180 degrees to rotate.

Now you just need to bind the value in the gauge to a variable or another control and it will do its job:
```
var gauge1 = Gauge {
    ui: BasicGauge{}
    primaryLabel: "Km/H"
    secondaryLabel: "Speed"
    min: 0.0, max: 100.0
    value: bind myValue
};
```
You can customize the speed for the needle rotation by adding a simple:
```
    speed: Gauge.SLOW
```
If you wish to have the gauge responding instantaneously to the change of value, use:
```
    speed: Gauge.INMEDIATE
```
Finally, you can add the control to your app:
```
Stage {
    scene: Scene {
        content: [ gauge1, ...
    }
}
```
## Additional information ##

  * [Available gauge types](gaugeGtypes.md)
  * [Available options for setting up a gauge](gaugeOptions.md)
  * [How to highlight value ranges in the gauge](gaugeRanges.md)
  * [How to set a custom background](gaugeCustomColor.md)