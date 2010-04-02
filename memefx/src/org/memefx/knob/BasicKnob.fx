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
import javafx.fxd.FXDNode;

public class BasicKnob extends FXDNode {

    /** JavaFX image format containing the knob
     * Adobe Illustrator converted to fxz format */
    override public var url = "{__DIR__}knob2.fxz";
    /** knob width */
    public var width:Number = 150;
    /** knob height */
    public var height:Number = 150;
    /** internal radius for gauge long lines */
    public var internalRadDial:Number = 66;
    /** external radius for gauge long lines */
    public var externalRadDial:Number = 74;
    /** internal radius for gauge short lines */
    public var internalShortRadDial:Number = 66;
    /** external radius for gauge short lines */
    public var externalShortRadDial:Number = 69;

    /** contains knob appearance */
    public var knob: Node;
    /** moving piece in the knob */
    public var gauge: Node;

    /** loads image resources */
    override protected function contentLoaded() {
        knob = getNode("knob");
        gauge = getNode("gauge");
    }

}
