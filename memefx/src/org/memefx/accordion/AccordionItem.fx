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
 * Date   : March 18 , 2009
 *
 */

package org.memefx.accordion;

import javafx.scene.Group;
import javafx.scene.image.*;
import javafx.scene.shape.*;
import javafx.animation.*;
import javafx.scene.text.*;
import javafx.scene.effect.*;
import org.memefx.html.*;

/** implements a graphical item included into the image accordion */
public class AccordionItem extends Group {

    /** Item data (caption, image, colors, etc) */
    public var item: ImageItem;
    /** owner of this accordion item */
    public var owner: ImagesAccordion;
    /** item position in the containing accordion (0...) */
    public var imagePos: Integer;

    /** horizontal position X of the item */
    var posX: Number;
    /** initial horizontal position for a transition */
    var startX: Number;
    /** current horizontal position of the item */
    var currentX: Number on replace {
        if (owner.orientation==ImagesAccordion.HORIZONTAL)
            this.translateX = currentX
        else
            this.translateY = currentX
    };
    /** item bright */
    var bright = owner.darkLevel;
    /** opacity for vertical text caption */
    var captionOpacity = 1.0;
    /** vertical text caption  */
    var caption: Text = Text {
        x: 0, y: 0,
        rotate: if (owner.orientation == ImagesAccordion.HORIZONTAL) -90 else 0
        font: owner.captionFont
        textOrigin: TextOrigin.BASELINE
        content: item.caption
        fill: owner.captionColor
        effect: DropShadow { offsetY: 2 }
        opacity: bind captionOpacity
    };
    /** current width of the caption text */
    var txtW = caption.boundsInLocal.width;
    /** current height of the caption text */
    var txtH = caption.boundsInLocal.height;

    /** Timeline para animate a position transition */
    var timeline: Timeline;
    /** Timeline to adjust image bright */
    var timebright: Timeline;
    /** Timeline to display the extended message */
    var timemsg: Timeline;

    /** opacity of the extended message */
    var msgOpacity = 0.0;
    /** flag indicating the extended message is displayed */
    var msgShow: Boolean;
    /** extented message */
    var message = Group {
        content: [
            // background
            Rectangle {
                arcHeight: owner.messageArc,
                arcWidth: owner.messageArc
                x: item.messageArea.minX
                y: item.messageArea.minY
                width: item.messageArea.width
                height: item.messageArea.height
                fill: item.messageAreaColor
                opacity: item.messageAreaOpacity
            },
            // message
            TextHTML {
                content: item.message
                wrappingWidth: item.messageArea.width - owner.messageBorder * 2
                x: item.messageArea.minX + owner.messageBorder
                y: item.messageArea.minY + owner.messageBorder - 6
                effect: DropShadow { offsetX: 3, offsetY: 3 }
                basicTextAttrib: TextAttributes {
                    name:item.messageFont.name
                    size:item.messageFont.size
                    color:item.messageColor
                    bold:item.messageFont.embolden
                    italic:item.messageFont.oblique
                }
                onLinkPressed:item.onLinkPressed
            }
        ]
        opacity: bind msgOpacity
    };

    /** calculate self horizontal position
      * and animates transition*/
    public function adjust() {
        // stop animation in case it was running
        timeline.stop();
        // captures current horizontal position
        startX = currentX ;
        // if there's no active item in the accordion
        if (owner.active == - 1) then {
            // calculates self position (all the items has the same width)
            posX = imagePos * owner.initialWidth;
        }
        // if there's an item selected in the accordion
        else {
            // all the pieces with minimum width
            posX = owner.minWidth * imagePos;
            // if this item is located after the selected item
            if (imagePos > owner.active) then {
                // adds to its horizontal position the available space for
                // the selected item minus the minimum space for that item
                posX += owner.availableWidth - owner.minWidth
            };
        };
        // if it will change it horizontal position
        if (posX != startX) {
            // creates and executed an animated transition (workaround)
            timeline = Timeline {
                repeatCount: 1
                keyFrames: [
                    KeyFrame {
                        time: 0s
                        values: [currentX => startX]
                    }
                    KeyFrame {
                        time: owner.timeToExpand
                        values: currentX => posX tween owner.interpolator
                        canSkip: true
                    }
                ]
            };
            timeline.playFromStart();
        }
        // if this is the selected item
        if (imagePos == owner.active) {
            // if it level of bright is different than "normal"
            if (bright != owner.normalLevel) {
                // creates and launch a gradual transition
                timebright.stop();
                timebright = Timeline {
                    repeatCount: 1
                    keyFrames: [
                        KeyFrame {
                            time: owner.timeToNormalLevel
                            // it has to reach normal bright
                            values: bright => owner.normalLevel
                        }
                        KeyFrame {
                            time: owner.timeToMessage
                            action: function() {
                                // it shows the extended message
                                showMessage();
                            }
                        }
                        KeyFrame {
                            time: owner.timeToHideCaption
                            // makes vertical caption invisible
                            values: [captionOpacity => 0.0]
                            canSkip:true
                        }
                    ]
                };
                timebright.playFromStart();
            };
        }
        // if it's not the active item
        else {
            // and the bright of the item is not darker
            if (bright != owner.darkLevel) {
            // creates and execute a transition to make it darker
                timebright.stop();
                timebright = Timeline {
                    repeatCount: 1
                    keyFrames: [
                        // it will becoma darker in 1/2 sec.
                        // and will the vertical caption will become visible
                        KeyFrame {
                            time: owner.timeToDarkLevel
                            values: [
                                bright => owner.darkLevel,
                            ]
                        },
                        KeyFrame {
                            time: owner.timeToShowCaption
                            values: captionOpacity => 1.0
                            canSkip:true
                        }

                    ]
                };
                timebright.playFromStart();
            };
            // if it's not showing the extended message
            if (msgShow) {
                // hides the extended message
                hideMessage();
            }
        };
    };

    /** show extended message */
    function showMessage() {
        // is showing message
        msgShow=true;
        // makes extended message area visible
        message.visible=true;
        // message fade in
        timemsg = Timeline {
            repeatCount: 1
            keyFrames: [
                KeyFrame {
                    time: owner.timeFadeInMessage
                    values: msgOpacity => 1.0
                    canSkip: true
                }
            ]
        };
        timemsg.playFromStart();
    };

    /** hides extended message */
    function hideMessage() {
        timemsg.stop();
        // not showing message
        msgShow=false;
        // makes extended message area invisible
        message.visible=false;
        // makes extended message tranparent
        msgOpacity=0.0;
    }


    /** Initialize this accordion item */
    init {
        // blocks mouse for the node under this one
        blocksMouse=true;
        // adjust vertical caption position
        if (owner.orientation==ImagesAccordion.HORIZONTAL) {
            caption.translateX -= txtW / 2 - txtH / 2 - 5 ;
            caption.translateY = txtW / 2 + 5;
        }
        else {
            caption.translateX = 8;
            caption.translateY = txtH / 2 + 2;
        };
        // setup the content of this accordion item
        content = [
            // item image
            ImageView{ 
                image: item.image
                effect: ColorAdjust {brightness: bind bright };
                // set cursor
                cursor: bind owner.cursor
            },
            // separation line, between accordion items
            Line {
                startX: 0, startY: 0,
                endX: if (owner.orientation == ImagesAccordion.HORIZONTAL) 
                    0 else owner.width,
                endY: if (owner.orientation == ImagesAccordion.HORIZONTAL)
                    owner.height else 0,
                strokeWidth: owner.lineWidth,
                stroke: owner.lineColor
                opacity: owner.lineOpacity
            },
            // vertical caption
            caption,
            // extended message
            message
        ];
    };
};
