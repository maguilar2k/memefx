# Highlight ranges #

![http://lh4.ggpht.com/_esUBlqKjDzk/SblyCY6BojI/AAAAAAAAAys/6e1rwEvQzRE/ranges.png](http://lh4.ggpht.com/_esUBlqKjDzk/SblyCY6BojI/AAAAAAAAAys/6e1rwEvQzRE/ranges.png)

To highlight value ranges in a gauge, you just need to add in the Gauge definition a sequence of `Gauge.range`s:

```
    highlightRange: [
        Gauge.range {
            start: 0
            end: 70
            color: Color.GREEN
            opacity: 0.8
        },
        Gauge.range {
            start: 70
            end: 90
            color: Color.YELLOW
            dialLongLinesColor: Color.YELLOW
            dialShortLinesColor: Color.YELLOW
            opacity: 0.5
        },
            Gauge.range {
            start: 90
            end: 100
            color: Color.RED
            dialLongLinesColor: Color.RED
            dialShortLinesColor: Color.RED
            opacity: 0.5
        }
    ]
```

## Ranges options ##

For each range you can define the following parameter:

**Starting value for the range**
> start: Number

**Ending value for the range**
> end: Number

**Range color**
> color: Color

**Range arc internal radius**
> internalRad: Number

**Range arc external radius**
> externalRad: Number

**Range arc opacity (0.0 -> 1.0)**
> opacity: 1.0 (default)

**Color for dial numbers in the range**
> dialNumsColor: Color

**Color for dial long lines in the range**
> dialLongLinesColor: Color

**Color for dial short lines in the range**
> dialShortLinesColor: Color

## Complete code ##

```
var gauge4 = Gauge {
    ui: SquareGauge {}
    decorationVisible: false
    primaryLabel: "Km/H"
    secondaryLabel: "Speed"
    secondaryLabelFont: Font { size: 15 }
    valueColor: Color.CYAN
    valueFont: Font { size:19 oblique:true name:"Verdana"}
    min: 0.0, max: 100.0
    speed: Gauge.FAST
    initialValue: 0
    value: bind knob4.value
    highlightRange: [
        Gauge.range {
            start: 0
            end: 70
            color: Color.GREEN
            opacity: 0.8
        },
        Gauge.range {
            start: 70
            end: 90
            color: Color.YELLOW
            dialLongLinesColor: Color.YELLOW
            dialShortLinesColor: Color.YELLOW
            opacity: 0.5
        }
            Gauge.range {
            start: 90
            end: 100
            color: Color.RED
            dialLongLinesColor: Color.RED
            dialShortLinesColor: Color.RED
            opacity: 0.5
        }
    ]
};
```