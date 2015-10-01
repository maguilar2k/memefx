# Defining a new knob type #

To describe a new type of knob for the control, you just need to create a new class that inherits from `BasicKnob`.

In this class you can set the path to the graphical resources of the knob (probably an Adobe Illustrator file converted to .FXZ using the JavaFX Production Suite) and set the radius for the gauge lines in this knob (distance from the center of the component to the start and end of the lines in the gauge).

The knob has two kind of gauge lines, short and long. So, once you instantiate a new knob, you just need to set the frequency for the long lines in the gauge without additional work.

The graphical resource (in the .fxz file) includes two elements or group of elements (layers). One named "knob", which contains the general appearance of the knob. The second layer named "gauge" contains the moving part of the knob (includes a transparent line connecting the center of the knob with the border of the knob. The class rotate the "gauge" using the tip of the line as the center of rotation).

The Netbeans project includes three Adobe Illustrator examples in the root directory.

```
import javafx.scene.Node;
import javafx.fxd.UiStub;
import org.memefx.knob.*;

public class OrangeKnob extends BasicKnob {

    /** JavaFX image format containing the knob
     * Adobe Illustrator converted to fxz format */
    override public var url = "{__DIR__}knob3.fxz";
    /** knob width */
    override public var width = 136;
    /** knob height */
    override public var height = 136;
    /** internal radius for gauge long lines */
    override public var internalRadDial = 57;
    /** external radius for gauge long lines */
    override public var externalRadDial = 70;
    /** internal radius for gauge short lines */
    override public var internalShortRadDial = 57;
    /** external radius for gauge short lines */
    override public var externalShortRadDial = 62;

}
```

You can always set a custom radius for your knob instances, replacing the default values in the knob type variables (i.e. internalRadDial, etc) while setting up a new knob control. For example:

```
var colorSelector = Knob{ ui: OrangeKnob{ internalRadDial:50 }, ...
```