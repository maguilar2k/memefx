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

import javafx.scene.text.*;
import javafx.scene.paint.*;
import javafx.scene.effect.*;
import javafx.scene.shape.*;

public class CornerLRGauge extends BasicGauge {

    /** needle rotating point (X) */
    override public var centerX = 174.81;
    /** needle rotating point (Y) */
    override public var centerY = 176.5;

    /** minimum gauge angle */
    override public var minAngle = -90.0;
    /** maximum gauge angle */
    override public var maxAngle = 0.0;

    /** needle initial angle */
    override public var needleAngle = 0.0;

    /** gauge long lines internal radius */
    override public var internalLongRadDial = 145.0;
    /** gauge long lines external radius */
    override public var externalLongRadDial = 157.0;

    /** gauge short lines internal radius */
    override public var internalShortRadDial = 150.0;
    /** gauge short lines external radius */
    override public var externalShortRadDial = 157.0;

    /** gauge large numbers radius (to calculate position) */
    override public var largeNumberRadDial = 131.0;
    /** gauge small numbers radius (to calculate position) */
    override public var smallNumberRadDial = 135.0;

    /** gauge large numbers font size */
    override public var largeNumberFont = Font { size: 12 };
    /** gauge small numbers font size */
    override public var smallNumberFont = Font { size: 9 };

    /** internal radius for highlighted arc */
    override public var highlightInternalRad = 144;
    /** internal radius for highlighted arc */
    override public var highlightExternalRad = 150;

    /** gauge numbers color */
    override public var dialNumsColor = Color.WHITE;
    /** gauge lines color */
    override public var dialLongLinesColor = Color.WHITE;
    /** gauge lines color */
    override public var dialShortLinesColor = Color.LIGHTGRAY;

    /** URL to gauge graphical resources */
    override public var url = "{__DIR__}gaugecorner2.fxz";

    /** gauge custom backgroun
    * @param color Fill for custom background (can be a Color, RadialGradient, etc)
     * @param effect Graphical effect applied to the custom background
     */
    override public function customBackground(color:Paint, effect:Effect):Shape {
        Rectangle {
            x: 7,
            y: 7
            arcHeight: 20
            arcWidth: 20
            width: 199,
            height: 199
            fill: bind color
        }
    };
}