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
 * Date   : February 4, 2009
 *
 */

package org.memefx.knob;

import javafx.scene.Node;
import javafx.scene.Group;
import javafx.scene.CustomNode;
import javafx.scene.transform.Rotate;
import javafx.scene.Cursor;
import javafx.animation.*;
import javafx.scene.paint.Color;
import javafx.scene.shape.*;
import java.lang.Math;

/**
 * Implements a Knob Control for data input
 */
public class Knob extends CustomNode {

    /** graphical resource for the knob */
    public var ui:BasicKnob;
    /** cursor */
    override public var cursor=Cursor.DEFAULT;
    /** allows animated adjustment to the knob control */
    public var animatedAutoAdjust:Boolean = true;
    /** minimum value allowed by the control */
    public var min:Number = 1.0;
    /** maximum value allowed by the control */
    public var max:Number = 10.0;
    /** the control accepts and returns only integer values */
    public var integerOnly:Boolean = false;
    /** instantaneous (not animated) adjustment for integer values */
    public var integerQuickAdjust:Boolean = false;
    /** angle for the minimum value in the control (-180 to 180) */
    public var minAngle:Number = -150.0;
    /** angle to the maximum value (can be higher than 360 degrees) */
    public var maxAngle:Number = 150.0;
    /** thickness of gauge lines */
    public var dialLinesWidth:Number = 2;
    /** frequency for long gauge lines (i.e. 3 = |··|··|··|...) */
    public var dialLinesLongEvery:Integer = 1;// on replace { drawLine() };
    /** total number of gauge lines */
    public var dialLinesNumber:Integer = 10 on replace { drawLines() };
    /** gauge lines color */
    public var dialLinesColor:Color = Color.BLACK;// on replace { drawLine() };
    /** contains an integer version of the current value */
    public-read var integerValue:Integer;
    /** contains the current value */
    public var value:Number = 1.0 on replace {
        integerValue = Math.round(value) as Integer;
        validateValue()
    };
    /** rotation speed */
    public var speed:Duration=2s;

    /** gauge lines sequence */
    var lines:Node[];
    /** angle (work) in the gauge */
    var degrees:Number;
    /** angle (0-360) in the gauge */
    var output:Number on replace { value = output / proportion() + min };
    /** previous mouse position */
    var x1:Number;
    var y1:Number;
    /** for animated adjustments */
    var newVal:Number;
    var oldVal:Number;


    /** validates de value in the control and rotates the knob */
    function validateValue() {
        // verifies limits
        if (value < min) then value = min;
        if (value > max) then value = max;
        // calculate angle according to current value, minimum valur and proportion
        degrees = (value - min) * proportion();
        // sets output with initial angle
        output = degrees;
    };

    /** calculates proportion between values and angles
     *  @return Proportion between range (min/max value) and angle (min/max angle)
     */
    function proportion():Number {
        // angle between minimum and maximum angles
        var angle = maxAngle - minAngle;
        // range between minimum and maximum value
        var range = max - min;
        // proportion between range and angles
        angle / range;
    }

    /** draw gauge lines */
    function drawLines() {
        // erase previous lines
        delete lines;
        // angle between minimum and maximum angle, up to 360 degrees
        var angle = Math.min(maxAngle - minAngle, 360);
        // degrees between gauge lines
        var stepLine = angle / (dialLinesNumber - 1) ;
        // create gauge lines
        var cnt=0;
        for (i in [0..angle step stepLine] ) {
            // math to calculate lines
            var rad = Math.toRadians(i + 90);
            var hor = Math.cos(rad);
            var ver = Math.sin(rad);
            // verifies if it's a long gauge line
            var isLong:Number = cnt mod dialLinesLongEvery;
            // count number of gauge lines
            cnt++;
            // verifies wich radius to use (for long/short gauge lines)
            // this radius are embedded with the knobs definitions
            var internal:Number;
            var external:Number;
            if (isLong == 0) then {
                internal = ui.internalRadDial;
                external = ui.externalRadDial;
            } else {
                internal = ui.internalShortRadDial;
                external = ui.externalShortRadDial;
            }
            // creates line
            var line = Line {
                    stroke: bind dialLinesColor
                    strokeWidth: bind dialLinesWidth
                    startX: bind ( ui.width / 2 ) - hor * internal
                    startY: bind ( ui.height / 2 ) - ver * internal
                    endX: bind ( ui.width / 2) - hor * external
                    endY: bind ( ui.height / 2 ) - ver * external
            }
            // insert line into the sequence
            insert line into lines;
        };
    };


    /** creates the knob control */
    override public function create():Node {
        Group {
            blocksMouse:true
            rotate: bind minAngle
            cursor: bind cursor
            content: [
                // embed knob graphics
                ui.knob,
                Group {
                    // rotates the "pointing element" in the knob
                    transforms:
                        Rotate {
                            angle: bind output
                            pivotX: bind ui.width / 2
                            pivotY: bind ui.height / 2
                        }
                    content: ui.gauge
                }
                // add the gauge lines
                lines
            ]

            onMousePressed: function(e) {
                // store mouse initial position
                x1 = e.x;
                y1 = e.y;
                // stops any possible current
                // animated adjustment of the knob
                anim.stop();
            }

            onMouseDragged: function(e) {
                // calculate angle to the previous mouse position
                var a1 = getAngle(ui.width / 2, ui.height / 2, x1, y1 );
                // calculate angle to the current mouse position
                var a2 = getAngle(ui.width / 2, ui.height / 2, e.x, e.y );
                // store current mouse position as previous position
                x1 = e.x;
                y1 = e.y;
                // difference between angles (previous and current)
                if (a2 - a1 > 180) then { a2 = a2 - 360 };
                if (a2 - a1 < -180) then { a1 = a1 - 360 };
                var variation = a2 - a1;
                // accumulates angle variations in the mouse position
                degrees += variation;

                // if reaches the minimum allowed angle
                if (degrees < 0) then
                    // pointing element keeps angle 0
                    { output = 0 }
                else {
                    // if reaches the maximum angle allowed
                    if (degrees > maxAngle - minAngle) then
                        // pointing element keeps maximum angle
                        { output = maxAngle - minAngle }
                    // if angle between limits
                    else
                        // pointing elements point to the current angle
                        { output = degrees };
                };
            }

            onMouseReleased: function(e) {
                // reset "virtual angle" to the current
                // angle of the pointing element
                degrees = output;
                // if accept only integer numbers
                if (integerOnly) {
                    // and it doesn't adjust to integer instantaneously
                    if (not integerQuickAdjust) then
                        // default (animated/not animated) adjustment to
                        // a round integer of the current value
                        { setValue(Math.round(value), animatedAutoAdjust) }
                    else
                        // instantaneous adjustment to a round integer
                        // of the current value
                        { setValue(Math.round(value), false) };
                }
            }
        };
    }

    /**
     * Calculate angle between two positions and the center of the knob
     * @param x1 previous horizontal coordinate of the mouse
     * @param y1 previous vertical coordinate of the mouse
     * @param x2 current horizontal coordinate of the mouse
     * @param y2 current vertical coordinate of the mouse
     * @return angle between the two positions and the center of the knob (0-360)
     */
    function getAngle(x1:Number, y1:Number, x2:Number, y2:Number):Number {
        // to avoid a division by zero
        var add = if (y2 - y1 == 0) then 0.0001 else 0.0;
        // calculate the angle between the two points
        var deg = Math.toDegrees(Math.atan(( x2 - x1 ) / ( y2 - y1 + add )));
        // if current vertical coordinate < than previous vertical coordinate
        if (y2 < y1) then {
            // if calculated degrees <0
            if (deg < 0) then
                // opposite sign
                { deg = -deg }
            else
                // complement to 360 degrees
                { deg = 360 - deg };
        }
        // if current vertical coordinate >= than previous vertical coordinate
        else
            // complement to 180 degrees
            { deg = 180 - deg };
        // return degrees
        return deg;
    };

    /** set knob value
     *  @param val new knob value
     *  @param animate adjustment will be animated
     */
    public function setValue(val:Number, animate:Boolean) {
        // if accepts only integer values
        if (integerOnly) then {
            // store temporarily the integer of the new value
            newVal = Math.round(val)
        // if accepts decimal values
        } else {
            // stores temporarily the new value
            newVal = val;
        }
        // validates new value is in the allowed range
        if (newVal < min) then newVal = min;
        if (newVal > max) then newVal = max;
        // if not animated adjustment
        if (not animate) then
            // set new value to the knob control
            { value = newVal }
        // if animated adjustment
        else {
            // animate adjustment
            oldVal = value;
            anim.playFromStart();
        }
    };

    /** set value, animated or not animated according
     * to the control's definitions
     * @param val New value for knob control
     */
    public function setValue(val:Number) {
        setValue(val, animatedAutoAdjust);
    };

    /** set value to the minimum
     * @param animate animated or not animated reset value
     */
    public function resetValue(animate:Boolean) {
        setValue(min, animate);
    }

    /** set value to the minimum, animated or not animated according
     * to the control's definitions
     */
    public function resetValue() {
        setValue(min, animatedAutoAdjust);
    }

    /** set value to the maximum
     * @param animate animated or not animated reset value
     */
    public function setMaxValue(animate:Boolean) {
        setValue(max, animate);
    }

    /** set value to the maximum, animated or not animated according
     * to the control's definitions
     */
    public function setMaxValue() {
        setValue(max, animatedAutoAdjust);
    }

    /** Timeline to animate the value adjustment */
    var anim=Timeline {
        repeatCount:1
        keyFrames: [
            KeyFrame {
                time: 0s
                values: [value => oldVal]
            }
            KeyFrame {
                time: bind speed
                values: [value => newVal tween Interpolator.EASEOUT]
            }
//            at (0s) { value => oldVal }
//            at (2s) { value => newVal tween Interpolator.EASEOUT}
        ]
    };

}
