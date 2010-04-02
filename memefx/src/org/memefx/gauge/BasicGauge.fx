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

import javafx.scene.Node;
import javafx.fxd.FXDNode;
import javafx.scene.text.*;
import javafx.scene.paint.*;
import javafx.scene.effect.*;
import javafx.scene.shape.*;

public class BasicGauge extends FXDNode {

    /** needle rotating point (X) */
    public var centerX = 150.0;
    /** needle rotating point (Y) */
    public var centerY = 150.0;

    /** minimum gauge angle */
    public var minAngle = -150.0;
    /** maximum gauge angle */
    public var maxAngle = 150.0;

    /** needle initial angle */
    public var needleAngle = 0.0;

    /** gauge long lines internal radius */
    public var internalLongRadDial = 120.0;
    /** gauge long lines external radius */
    public var externalLongRadDial = 132.0;

    /** gauge short lines internal radius */
    public var internalShortRadDial = 125.0;
    /** gauge short lines external radius */
    public var externalShortRadDial = 132.0;

    /** gauge large numbers radius (to calculate position) */
    public var largeNumberRadDial = 104.0;
    /** gauge small numbers radius (to calculate position) */
    public var smallNumberRadDial = 110.0;

    /** gauge large numbers font size */
    public var largeNumberFont = Font { size: 14
    };
    /** gauge small numbers font size */
    public var smallNumberFont = Font { size: 10
    };

    /** internal radius for highlighted arc */
    public var highlightInternalRad: Number = 90;
    /** internal radius for highlighted arc */
    public var highlightExternalRad: Number = 125;

    /** gauge numbers color */
    public var dialNumsColor: Color = Color.WHITE;
    /** gauge lines color */
    public var dialLongLinesColor: Color = Color.WHITE;
    /** gauge lines color */
    public var dialShortLinesColor: Color = Color.LIGHTGRAY;

    /** URL to gauge graphical resources */
    override public var url = "{__DIR__}gauge.fxz";

    public var reflex: Node;
    public var needle: Node;
    public var display: Node;
    public var labels: Node;
    public var decoration: Node;
    public var body: Node;
    public var background: Node;

    public var dispvalue: Text;
    public-read var dispvaluew;
    public-read var dispvalueh;
    public-read var dispvaluex;
    public-read var dispvaluey;

    public var primarylabel: Text;
    public-read var primarylabelw;
    public-read var primarylabelx;

    public var secondarylabel: Text;
    public-read var secondarylabelw;
    public-read var secondarylabelx;

    /** gauge custom background
    * @param color Fill for custom background (can be a Color, RadialGradient, etc)
     * @param effect Graphical effect applied to the custom background
     */
    public function customBackground(color:Paint, effect:Effect):Node {
        Circle {
            centerX: 150,
            centerY: 150
            radius: 135
            fill: bind color
        }
    };

    /** gauge custom background
    * @param color Fill for custom background (can be a Color, RadialGradient, etc)
     */
    public function customBackground(color:Paint):Node {
        customBackground(color, null);
    };

    override protected function contentLoaded() {

        reflex = getNode("reflex");
        needle = getNode("needle");
        display = getNode("display");
        labels = getNode("labels");
        decoration = getNode("decoration");
        body = getNode("body");
        background = getNode("background");

        dispvalue =
        getNode("dispvalue") as Text;
        dispvaluew = dispvalue.boundsInLocal.width;
        dispvalueh = dispvalue.boundsInLocal.height;
        dispvaluex = dispvalue.boundsInLocal.minX;
        dispvaluey = dispvalue.boundsInLocal.minY;

        primarylabel =
        getNode("primarylabel") as Text;
        primarylabelw = primarylabel.boundsInLocal.width;
        primarylabelx = primarylabel.boundsInLocal.minX;

        secondarylabel =
        getNode("secondarylabel") as Text;
        secondarylabelw = secondarylabel.boundsInLocal.width;
        secondarylabelx = secondarylabel.boundsInLocal.minX;

    }
}