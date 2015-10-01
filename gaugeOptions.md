# Options #

**Gauge type. Contains the graphical appearance and basic info about the gauge. [Check the available options](gaugeGtypes.md)**
> ui: `BasicGauge`

> Available options: `BasicGauge, SquareGauge, SmallGauge, SmallInvGauge, SmallLGauge, SmallRGauge, RectGauge, RectInvGauge, FlatRectGauge, FlatRectInvGauge, CornerLLGauge, CornerLRGauge, CornerULGauge, CornerURGauge`

**Show / hide gauge glass reflextion**
> reflexVisible: true (default)

**Font for the display number. Default font set at design time**
> valueFont: Font

**Primary label font. Default font set at design time**
> primaryLabelFont: Font

**Secondary label font. Default font set at design time**
> secondaryLabelFont: Font

**Color for the display number. Default color set at design time**
> valueColor: Color

**Primary label color. Default color set at design time**
> primaryLabelColor: Color

**Secondary label color. Default color set at design time**
> secondaryLabelColor: Color

**Primary label string. Default string set at design time**
> primaryLabel: String

**Secondary label string. Default string set at design time**
> secondaryLabel: String

**Minimum value on the gauge**
> min: 0.0 (default)

**Maximum value on the gauge**
> max: 100.0 (default)

**Initial value on the gauge**
> initialValue: min (default)

**Minimum angle for the gauge dial**
> minAngle: gauge type minAngle (default)

**Maximum angle for the gauge dial**
> maxAngle: gauge type maxAngle (default)

**Needle rotation speed**
> speed: Gauge.FAST (default)

> Available options: `Gauge.USERDEFINED, Gauge.INMEDIATE, Gauge.SLOWEST, Gauge.SLOW, Gauge.INTERMEDIATE, Gauge.FAST, Gauge.FASTEST`

**User defined rotation speed (use with speed: `Gauge.USERDEFINED`)**
> userDefinedSpeed:0.3s

**Gauge value. Sets a new value for the gauge. It can trigger an animated transition (see speed).**
> value: 0.0 (default)

**Current needle value. Current value pointed by the gauge's needle**
> currentValue: Number

**Gauge long lines internal radius**
> internalLongRadDial: gauge type internalLongRadDial (default)

**Gauge long lines external radius**
> externalLongRadDial: gauge type externalLongRadDial (default)

**Gauge short lines internal radius**
> internalShortRadDial: gauge type internalShortRadDial(default)

**Gauge short lines external radius**
> externalShortRadDial: gauge type externalShortRadDial(default)

**Gauge large numbers radius (to calculate position)**
> largeNumberRadDial: gauge type largeNumberRadDial (default)

**Gauge small numbers radius (to calculate position)**
> smallNumberRadDial: gauge type smallNumberRadDial (default)

**Display a LARGE number every X numbers in the dial**
> dialNumsLargeEvery: 1 (default)

**Display a number in the dial every X numbers**/
> dialNumsVisibleEvery: 1 (default)

**Quantity of numbers in the gauge dial**
> dialNumsQuantity: 11 (default)

**Display only integer numbers in the dial**
> dialNumsIntegerOnly: true (default)

**Maximum number of decimals (in case dialNumsIntegerOnly:false)**
> dialNumsDecimals: 1 (default)

**Gauge dial numbers color**
> dialNumsColor = gauge type dialNumsColor (default)

**Sequence of highlighted value ranges ( [Check here for more information](gaugeRanges.md) )**
> highlightRange: Gauge.range`[]`

**Internal radius for highlighted value range arc. A highlighted range can include its own radius**
> highlightInternalRad = gauge type highlightInternalRad (default)

**External radius for highlighted value range arc. A highlighted range can include its own radius**
> highlightExternalRad = gauge type highlightExternalRad (default)

**Gauge dial long lines thick**
> dialLongLinesWidth: 3 (default)

**Gauge dial short lines thick**
> dialShortLinesWidth: 1 (default)

**Frequency for gauge long lines (i.e. 3 = |··|··|··|...)**
> dialLinesLongEvery: 10 (default)

**Quantity of gauge dial lines**
> dialLinesQuantity: 51 (default)

**Dial long lines color**
> dialLongLinesColor: gauge type dialLongLinesColor (default)

**Dial short lines color**
> dialShortLinesColor = gauge type dialShortLinesColor (default)

**Needle shadow color**
> shadowColor: Color.BLACK (default)

**Needle shadow X offset**
> shadowX: -2 (default)

**Needle shadow Y offset**
> shadowY: Integer = -2 (default)

**Show / hide gauge value display**
> displayVisible: true (default)

**Show / hide gauge primary label**
> primaryLabelVisible: true

**Show / hide gauge secondary label**
> secondaryLabelVisible: true

**Show / hide gauge primary and secondary labels**
> labelsVisible: true (default)

**Show / hide gauge decoration**
> decorationVisible: true (default)

**Activate noise for the needle**
> noise: false (default)

**Needle noise level (0.0 -> 1.0)**
> noiseLevel: 0.25 (default)

**Replace gauge background ( [Check here for more information](gaugeCustomColor.md) )**
> background: Node (New node below the needle and hides ui.background)

**Show / hide gauge body elements**
> bodyVisible: true (default)

**Inverts dial scale**
reverseScale: Boolean

**Show / hide dial numbers**
> noNumbers = false (default)

**Show / hide dial lines**
> noLines = false (default)

**Use dots instead of lines in the dial**
> useDots = false (default)