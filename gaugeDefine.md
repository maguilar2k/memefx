# Building a custom gauge type #

![http://lh5.ggpht.com/_esUBlqKjDzk/SbnxoHOfQ_I/AAAAAAAAAzU/Y_3ZbT8NKRA/customgauge.png](http://lh5.ggpht.com/_esUBlqKjDzk/SbnxoHOfQ_I/AAAAAAAAAzU/Y_3ZbT8NKRA/customgauge.png)

It is very easy to create a new [type of gauge](gaugeGtypes.md). Here are the three steps:

  * Create the graphical resources (a .fxz file). You can accomplish this by using a design tool -as Adobe Illustrator- and having installed the JavaFX production suite (that will allow you to export your work from Illustrator to a JavaFX file). Check the [newgaugetype.zip](http://code.google.com/p/memefx/downloads/list) file for a complete example (including an Adobe Illustrator file example).

The file requires to containg a few elements and layer, from bottom to the top this are the layer:

  * jfx:body (this is the edge for the gauge component)
  * jfx:background (this is the background area in the gauge component)
  * jfx:decoration (this includes all the miscellaneous decoration on the background)
  * jfx:labels (this layer includes the jfx:primarylabel and jfx:secondarylabel text elements)
  * jfx:display (this is the background area to display the numeric value)
  * jfx:dispvalue (this is the text element to display the numeric value)
  * jfx:needle (this is the needle element for the gauge)
  * jfx:reflex (this is a semitransparent decoration that mimics a glass reflection)

**Check the "adobe resources" directory for an Adobe Illustrator example**

Now, you must create a new JavaFX class in your project, like this one:

```
package newgaugetype;

import javafx.scene.text.*;
import javafx.scene.paint.*;
import javafx.scene.effect.*;
import javafx.scene.shape.*;
import org.memefx.gauge.*;

public class MyGaugeType extends BasicGauge {

    /** needle rotating point (X) */
    override public var centerX = 100;
    /** needle rotating point (Y) */
    override public var centerY = 100;

    /** minimum gauge angle */
    override public var minAngle = -150.0;
    /** maximum gauge angle */
    override public var maxAngle = 150.0;

    /** needle initial angle */
    override public var needleAngle = 0.0;

    /** gauge long lines internal radius */
    override public var internalLongRadDial = 80.0;
    /** gauge long lines external radius */
    override public var externalLongRadDial = 86.0;

    /** gauge short lines internal radius */
    override public var internalShortRadDial = 83.0;
    /** gauge short lines external radius */
    override public var externalShortRadDial = 86.0;

    /** gauge large numbers radius (to calculate position) */
    override public var largeNumberRadDial = 66.0;
    /** gauge small numbers radius (to calculate position) */
    override public var smallNumberRadDial = 66.0;

    /** gauge large numbers font size */
    override public var largeNumberFont = Font { size: 12 };
    /** gauge small numbers font size */
    override public var smallNumberFont = Font { size: 10 };

    /** internal radius for highlighted arc */
    override public var highlightInternalRad = 87;
    /** externar radius for highlighted arc */
    override public var highlightExternalRad = 89;

    /** gauge numbers color */
    override public var dialNumsColor = Color.RED;
    /** gauge long lines color */
    override public var dialLongLinesColor = Color.RED;
    /** gauge short lines color */
    override public var dialShortLinesColor = Color.RED;

    /** URL to gauge graphical resources */
    override public var url = "{__DIR__}mygaugetype.fxz";

    /** gauge custom background
    * @param color Fill for custom background (can be a Color, RadialGradient, etc)
     * @param effect Graphical effect applied to the custom background
     */
    override public function customBackground(color:Paint, effect:Effect):Shape {
        Circle {
            centerX: 100,
            centerY: 100
            radius: 87
            fill: bind color
        }
    };
}
```
This class contains basic information about the type of gauge you are creating, like the radius/distance from the needle rotating point to the starting and ending points for the dial lines, the distance from the center to the dial numbers, lines and numbers colors, etc. and a reference to the file containing the graphical resources (.fxz) for the gauge.

In the `customBackground` function, you must code how to draw a customized background for the gauge type. This function receives two parameters: color (can be a color or a gradient) and and optional graphic effect to apply to the background.

Finally, you can instantiate your new gauge in the application:
```
package newgaugetype;

import javafx.stage.Stage;
import javafx.scene.Scene;
import org.memefx.gauge.*;

var gauge = Gauge {
    ui: MyGaugeType{}
    primaryLabel: "Grade"
    secondaryLabel: "result"
    speed: Gauge.SLOW
    initialValue: 0
    value: 75
};

Stage {
    title: "My own gauge type"
    width: 250
    height: 250
    scene: Scene {
        content: gauge
    }
}
```