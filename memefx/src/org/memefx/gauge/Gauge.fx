/*
 * Copyright (c) 2009, Mauricio Aguilar O.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * - Redistributions of source code must retain the above copyright notice,
 *   this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright notice,
 *   this list of conditions and the following disclaimer in the documentation
 *   and/or other materials provided with the distribution.
 * - Neither the name of Mauricio Aguilar O. nor the names of its contributors
 *   may be used to endorse or promote products derived from this software
 *   without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 * @author: Mauricio Aguilar O.
 * Website: http://aprendiendo-javafx.blogspot.com
 * email  : maguilar2k@yahoo.com
 * Date   : March 4 , 2009
 *
 */

package org.memefx.gauge;

import javafx.scene.*;
import javafx.scene.paint.*;
import javafx.scene.shape.*;
import javafx.scene.effect.*;
import javafx.scene.text.*;
import javafx.scene.transform.*;
import javafx.animation.*;
import java.lang.Math;

/** Instantaneous value update */
public def IMMEDIATE: Integer = 0;
/** Fastest needle rotation */
public def FASTEST: Integer = 1;
/** Fast needle rotation */
public def FAST: Integer = 2;
/** Intermediate needle rotation */
public def INTERMEDIATE: Integer = 3;
/** Slow needle rotation */
public def SLOW: Integer = 4;
/** Slowest needle rotation */
public def SLOWEST: Integer = 5;
/** User defined needle rotation speed */
public def USERDEFINED:Integer = 6;

/**
 * this class implements a Gauge element
 */
public class Gauge extends CustomNode {

    /** gauge lines sequence */
    var dial: Node[];
    /** needle shadow effect */
    var shadowNeedle: DropShadow = null;
    /** noise range */
    var noiseRange: Number;
    /** current noise value */
    var noiseValue: Number;

    /** load graphical appearance */
    public var ui: BasicGauge;

    /** show/hide gauge glass reflextion */
    public var reflexVisible = true on replace {
        ui.reflex.visible=reflexVisible;
    };

    /** value font */
    public var valueFont: Font on replace {
        if (valueFont != null) then {
            ui.dispvalue.font = valueFont;
            var h = ui.dispvalue.boundsInLocal.height;
            ui.dispvalue.y = ui.dispvaluey + ui.dispvalueh / 2 - h / 2;
            ui.dispvalue.textOrigin=TextOrigin.TOP;
        }
    }
    /** primary label font */
    public var primaryLabelFont: Font on replace {
        if (primaryLabelFont != null) then
        ui.primarylabel.font = primaryLabelFont;
    }
    /** secondary label font */
    public var secondaryLabelFont: Font on replace {
        if (secondaryLabelFont != null) then
        ui.secondarylabel.font = secondaryLabelFont;
    }
    /** value color */
    public var valueColor: Color on replace {
        if (valueColor != null) then
        ui.dispvalue.fill = valueColor;
    }
    /** primary label color */
    public var primaryLabelColor: Color on replace {
        if (primaryLabelColor != null) then
        ui.primarylabel.fill = primaryLabelColor;
    }
    /** secondary label color */
    public var secondaryLabelColor: Color on replace {
        if (secondaryLabelColor != null) then
        ui.secondarylabel.fill = secondaryLabelColor;
    }
    /** top label */
    public var primaryLabel: String on replace {
        ui.primarylabel.content = primaryLabel;
        ui.primarylabel.textAlignment = TextAlignment.CENTER;
        var w2 = ui.primarylabel.boundsInLocal.width;
        ui.primarylabel.x = ui.primarylabelx + ui.primarylabelw / 2 - w2 / 2;
    };
    /** bottom label */
    public var secondaryLabel: String on replace {
        ui.secondarylabel.content = secondaryLabel;
        ui.secondarylabel.textAlignment = TextAlignment.CENTER;
        var w3 = ui.secondarylabel.boundsInLocal.width;
        ui.secondarylabel.x = ui.secondarylabelx + ui.secondarylabelw / 2 - w3 / 2;
    };

    /** gauge minimum value */
    public var min: Number = 0.0;
    /** gauge maximum value */
    public var max: Number = 100.0;
        /** initial gauge value */
    public var initialValue = min on replace {
        currentValue=initialValue
    };

    /** angle for the minimum value in the control (-180 to 180) */
    public var minAngle: Number = ui.minAngle on replace {
        calculateNoiseRange()
    };
    /** angle to the maximum value (can be higher than 360 degrees) */
    public var maxAngle: Number = ui.maxAngle on replace {
        calculateNoiseRange()
    };

    /** gauge value transition speed */
    public-init var speed: Integer = FAST;
    /** user defined time to rotate needle */
    public var userDefinedSpeed:Duration=1.5s;

    /** Timeline to animate needle rotation */
    var timer: Timeline;

    /** gauge value */
    public var value = 0.0 on replace {
        timer.stop();
        if (speed == IMMEDIATE) {
            currentValue=value;
        } else {
            var time: Duration;
            if (speed == FASTEST) {
                time=0.5s;
            } else
            if (speed == FAST) {
                time=1s;
            } else
            if (speed == INTERMEDIATE) {
                time=2s;
            } else
            if (speed == SLOW) {
                time=4s;
            } else
            if (speed == SLOWEST) {
                time=8s;
            } else {
                time=userDefinedSpeed;
            };

            timer = Timeline {
                repeatCount: 1
                keyFrames: [
                    KeyFrame {
                        time: time
                        values: [currentValue => value]
                        canSkip:true
                    }
                ]
            };
            timer.play();
        };
    };

    /** gauge needle value */
    var needleValue: Number;
    /** gauge current value */
    public-read var currentValue = 0.0 on replace {
        ui.dispvalue.content="{currentValue as Integer}";
        var w = ui.dispvalue.boundsInLocal.width;
        ui.dispvalue.x=ui.dispvaluex + ui.dispvaluew / 2 - w / 2;
        var proportion = (maxAngle - minAngle) / (max - min);
        // calculate needle angle
        needleValue = proportion * (currentValue - min);
    };

    /** gauge long lines internal radius */
    public var internalLongRadDial: Number = ui.internalLongRadDial;
    /** gauge long lines external radius */
    public var externalLongRadDial: Number = ui.externalLongRadDial;
    /** gauge short lines internal radius */
    public var internalShortRadDial: Number = ui.internalShortRadDial;
    /** gauge short lines external radius */
    public var externalShortRadDial: Number = ui.externalShortRadDial;

    /** gauge large numbers radius (to calculate position) */
    public var largeNumberRadDial = ui.largeNumberRadDial;
    /** gauge small numbers radius (to calculate position) */
    public var smallNumberRadDial = ui.smallNumberRadDial;

    /** gauge large numbers font size */
    public var largeNumberFont = ui.largeNumberFont;
    /** gauge small numbers font size */
    public var smallNumberFont = ui.smallNumberFont;

    /** Numbers every X positions */
    public var dialNumsLargeEvery: Integer = 1;
    /** gauge numbers visible every X */
    public var dialNumsVisibleEvery: Integer = 1;
    /** gauge total numbers */
    public var dialNumsQuantity: Integer = 11;
    /** only integer gauge dial numbers */
    public var dialNumsIntegerOnly: Boolean = true;
    /** gauge dial numbers total of decimals */
    public var dialNumsDecimals: Number = 1;

    /** gauge numbers color */
    public var dialNumsColor = ui.dialNumsColor ;

    /** range highlight table */
    public var highlightRange: range[];
    /** internal radius for highlighted arc */
    public var highlightInternalRad = ui.highlightInternalRad;
    /** internal radius for highlighted arc */
    public var highlightExternalRad = ui.highlightExternalRad;
    /** thickness of long gauge lines */
    public var dialLongLinesWidth: Number = 3;
    /** thickness of short gauge lines */
    public var dialShortLinesWidth: Number = 1;
    /** frequency for long gauge lines (i.e. 3 = |··|··|··|...) */
    public var dialLinesLongEvery: Integer = 10;
    /** total number of gauge lines */
    public var dialLinesQuantity: Integer = 51;

    /** gauge lines color */
    public var dialLongLinesColor = ui.dialLongLinesColor;
    /** gauge lines color */
    public var dialShortLinesColor = ui.dialShortLinesColor;

    /** needle shadow color */
    public var shadowColor: Color = Color.BLACK on replace {
        needleShadow(shadowX, shadowY, shadowColor)
    };
    /** needle X shadow */
    public var shadowX: Integer = -2 on replace {
        needleShadow(shadowX, shadowY, shadowColor)
    };
    /** needle Y shadow */
    public var shadowY: Integer = -2 on replace {
        needleShadow(shadowX, shadowY, shadowColor)
    };
    /** show/hide gauge value display */
    public var displayVisible = true on replace {
        ui.display.visible = displayVisible;
        ui.dispvalue.visible = displayVisible;
    }
    /** show/hide gauge primary label */
    public var primaryLabelVisible: Boolean on replace {
        ui.primarylabel.visible = primaryLabelVisible;
    }
    /** show/hide gauge secondary label */
    public var secondaryLabelVisible: Boolean on replace {
        ui.secondarylabel.visible = secondaryLabelVisible;
    }
    /** show/hide gauge decoration */
    public var decorationVisible = true on replace {
        ui.decoration.visible = decorationVisible;
    }
    /** show/hide gauge labels */
    public var labelsVisible = true on replace {
        primaryLabelVisible = labelsVisible;
        secondaryLabelVisible = labelsVisible;
    }
    /** generates noise for the needle */
    var noiseGenerator = Timeline {
        repeatCount: Timeline.INDEFINITE
        keyFrames: [
            KeyFrame {
                time: 0.1s
                canSkip: true
                action: function() {
                    noiseValue = (Math.random() * noiseRange) - noiseRange / 2;
                }
            }
        ]
    };
    /** level of noise */
    public var noiseLevel: Number = 0.25;
    /** add noise (active) */
    public var noise: Boolean = false on replace {
        if (noise) then {
            // activate noise generator
            noiseGenerator.time=0s;
            noiseGenerator.playFromStart();
        }
        else {
            // reset/stop noise generator
            noiseGenerator.stop();
            noiseValue=0;
        }
    };
    /** replace gauge background */
    public var background: Node on replace {
        // if no custom background, standard background visible
        ui.background.visible=background == null;
    };
    /** show/hide gauge body */
    public var bodyVisible: Boolean = true on replace {
        ui.body.visible = bodyVisible;
    };
    /** reverse gauge scale */
    public var reverseScale: Boolean on replace {
        if (isInitialized(reverseScale)) {
            // invert min/max gauge angles
            var tmp = minAngle;
            minAngle=maxAngle;
            maxAngle=tmp;
        }
    }
    /** show/hide gauge numbers */
    public var noNumbers = false;
    /** show/hide gauge lines */
    public var noLines = false;
    /** use dots instead of lines */
    public var useDots = false;

    /** draw gauge lines */
    function drawDial() {

        // erase previous lines
        delete dial;
        // angle between minimum and maximum angle, up to 360 degrees
        var angle = Math.min(maxAngle - minAngle, 360);

        // create gauge's hightlighted ranges

        // degrees between gauge number
        var stepLineRange = angle / (max - min) ;

        // draw highlighted ranges
        for (aRange in highlightRange) {
            // starting angle
            var startRange = (aRange.start - min) * stepLineRange;
            // ending angle
            var endRange = (aRange.end - min) * stepLineRange;
            // range block
            var rangeBlock = endRange - startRange;

            // external radius / if it has range external radius
            var external = if (isInitialized(aRange.externalRad)) then {
                // range external radius
                aRange.externalRad;
            // if it doesn't have range external radius


            } else {
                // custom range external radius
                highlightExternalRad;
            };

            // internal radius / if it has range internal radius
            var internal = if (isInitialized(aRange.internalRad)) then {
                // range internal radius
                aRange.internalRad;
            // if it doesn't have range internal radius


            } else {
                // custom range internal radius
                highlightInternalRad
            };

            // create range arc
            var arc = Arc {
                centerX: ui.centerX,
                centerY: ui.centerY
                radiusX: external,
                radiusY: external
                startAngle: 90 - minAngle - startRange - rangeBlock
                length: rangeBlock
                type: ArcType.ROUND
                fill: aRange.color
                opacity: aRange.opacity
            };
            // if highlight range has internal radius
            if (internal > 0 ) then {
                insert
                ShapeSubtract {
                    a: arc
                    b: Circle {
                        centerX: ui.centerX
                        centerY: ui.centerY
                        radius: internal
                    }
                    fill: aRange.color
                    opacity: aRange.opacity
                } into dial;
            }
            else {
                insert arc into dial;
            }

        };


        // create gauge lines

        var stepLine: Number;
        var cnt: Integer;

        // visible lines
        if (not noLines) then {
        // degrees between gauge lines
            stepLine = angle / (dialLinesQuantity - 1) ;
        // init counter
            cnt = 0;
        // create gauge lines
            for (i in [0..angle step stepLine] ) {
            // math to calculate lines
                var rad = Math.toRadians(i + minAngle + 90);
                var hor = Math.cos(rad);
                var ver = Math.sin(rad);
            // verifies if it's a long gauge line
                var isLong: Number = cnt mod dialLinesLongEvery;
            // count number of gauge lines
                cnt++;
            // verifies wich radius to use (for long/short gauge lines)
                // this radius are embedded with the knobs definitions
                var internal: Number;
                var external: Number;
                var linesColor: Color;
                var thick: Number;
                if (isLong == 0) then {
                    internal = internalLongRadDial;
                    external = externalLongRadDial;
                    linesColor = dialLongLinesColor;
                // look for a custom color for highlight range
                    var lineValue = i / stepLineRange + min;
                    for (aRange in highlightRange) {
                        if (isInitialized(aRange.dialLongLinesColor) and
                        lineValue >= aRange.start and lineValue <= aRange.end)
                        linesColor = aRange.dialLongLinesColor;
                    }
                    thick = dialLongLinesWidth;
                } else {
                    internal = internalShortRadDial;
                    external = externalShortRadDial;
                    linesColor = dialShortLinesColor;
                // look for a custom color for highlight range
                    var lineValue = i / stepLineRange + min;
                    for (aRange in highlightRange) {
                        if (isInitialized(aRange.dialShortLinesColor) and
                        lineValue >= aRange.start and lineValue <= aRange.end)
                        linesColor = aRange.dialShortLinesColor;
                    }
                    thick = dialShortLinesWidth;
                };
                var mark: Shape;
                // if using dots
                if (useDots) then {
                    // creates circle
                    mark = Circle {
                        centerX: ui.centerX - hor * (external - thick)
                        centerY: ui.centerY - ver * (external - thick)
                        radius: thick / 2
                        fill: linesColor
                        stroke: linesColor
                    };

                } else {

            // creates line
                    mark = Line {
                        stroke: linesColor
                        strokeWidth: thick
                        startX: ui.centerX - hor * internal
                        startY: ui.centerY - ver * internal
                        endX: ui.centerX - hor * external
                        endY: ui.centerY - ver * external
                    }
                }
        // insert line into the sequence
        insert mark into dial;
            };
        };


        // create gauge numbers

        // visible numbers
        if (not noNumbers) then {
        // degrees between gauge number
            stepLine = angle / (dialNumsQuantity - 1) ;
        // increment for gauge numbers
            var numStep = (max - min) / (dialNumsQuantity - 1);
            var num = min;
        // create gauge numbers
            cnt = 0;
            for (i in [0..angle step stepLine] ) {
            // math to calculate lines
                var rad = Math.toRadians(i + minAngle + 90);
                var hor = Math.cos(rad);
                var ver = Math.sin(rad);
            // verifies if it's a large gauge number
                var isLarge: Number = cnt mod dialNumsLargeEvery;
            // is visible?
                var isVisible: Number = cnt mod dialNumsVisibleEvery;
            // count number of gauge numbers
                cnt++;
            // if visible
                if (isVisible == 0 ) then {
            // verifies wich radius to use (for large/small gauge numbers)
                    // this radius are embedded with the gauge definitions
                    var radius: Number;
                    var font: Font;
                // it's a large number
                    if (isLarge == 0) then {
                    // radius for large number position
                        radius = largeNumberRadDial;
                    // font for large numbers. If it doesn't have a custom font
                        font = largeNumberFont;
                    } else {
                    // radius for small numbers position
                        radius = smallNumberRadDial;
                    // font for small numbers. If it doesn't have a custom font
                        font = smallNumberFont;
                    };
            // generates number
                    var defNum: String;
            // only integers?
                    if (dialNumsIntegerOnly) then {
                        defNum = "{num as Integer}";
                    } else {
                        defNum = "{Math.round(num * (Math.pow(10, dialNumsDecimals))) / (Math.pow(10, dialNumsDecimals))}";
                    };
            // look for number color
                    var numColor = dialNumsColor;
                    for (aRange in highlightRange) {
                // if number in range
                        if (num >= aRange.start and num <= aRange.end and
                        isInitialized(aRange.dialNumsColor)) then {
                            numColor=aRange.dialNumsColor;
                        }
                    }

            // creates number
                    var txt = Text {
                        font: font
                        fill: numColor
                        x: ui.centerX - hor * radius
                        y: ui.centerY - ver * radius
                        content: defNum
                    }
            // obtain text dimension
                    var txtW = txt.boundsInLocal.width;
                    var txtH = txt.boundsInLocal.height;
            // translate text
                    txt.translateX = -txtW / 2;
                    txt.translateY = txtH / 2;
            // insert line into the sequence
                insert txt into dial;
                }

            // next number
                num += numStep;
            };
        };

        dial
    };


    /** calculate maximum noise range for needle */
    function calculateNoiseRange() {
        noiseRange = (maxAngle - minAngle) * 0.05;
    }



    /** creates the knob control */
    override public function create():
    Node {
        Group {
            content: [
                ui.body,
                background,
                drawDial(),
                ui.decoration,
                ui.display,
                ui.labels,
                Group {
                    content: Group {
                        transforms: Rotate {
                            angle: bind needleValue + minAngle + 
                            noiseValue * noiseLevel + ui.needleAngle
                            pivotX: bind ui.centerX
                            pivotY: bind ui.centerY
                        }
                        content: ui.needle
                    }
                    effect: {
                        shadowNeedle
                    }

                }
                ui.reflex
            ]
        }
    }


    /** add shadow to needle
    * @param x Horizontal shadow displacement
     * @param y Vertical shadow displacement
     * @param color Shadow color
     */
    public function needleShadow(x:Number, y:Number, color:Color) {
        if (x == 0 and y == 0) then {
            shadowNeedle=null;
        }
        else {
            shadowNeedle = DropShadow {
                offsetX: x
                offsetY: y
                color: color
            }
        }
    }

}

    /** gauge range highlight */
public class range {
        /** range starting value */
    public var start: Number;
        /** range ending value */
    public var end: Number;
        /** highlighted range color */
    public var color: Color;
        /** highlight internal radius */
    public var internalRad: Number;
        /** highlight external radius */
    public var externalRad: Number;
        /** range area opacity */
    public var opacity: Number = 1.0;
        /** color for gauge numbers in the range */
    public var dialNumsColor: Color;
        /** color for gauge long lines */
    public var dialLongLinesColor: Color;
        /** color for gauge short lines */
    public var dialShortLinesColor: Color;
}
