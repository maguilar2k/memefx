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

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.paint.Color;
import javafx.scene.Group;
import javafx.scene.shape.*;
import javafx.animation.*;
import javafx.scene.text.*;
import javafx.scene.Cursor;
import javafx.lang.FX;
import org.memefx.interpolator.SpringInterpolator;

/** vertical orientation */
public def VERTICAL=0;
/** horizontal orientation */
public def HORIZONTAL=1;

/** Implements an Images Accordion control */
public class ImagesAccordion extends CustomNode {

    /** Accordion control width */
    public var width=500.0;
    /** Accordion control height */
    public var height=400.0;
    /** Cursor */
    override var cursor=Cursor.DEFAULT;
    /** Accordion orientation */
    public var orientation = HORIZONTAL;
    /** minimum width for images (while image selected) */
    public var minWidth=40.0;
    /** color for separation line (between images) */
    public var lineColor = Color.WHITE;
    /** opacity for separation line (between images) */
    public var lineOpacity = 0.5;
    /** width for separation line (between images) */
    public var lineWidth = 1.0;
    /** caption text color */
    public var captionColor = Color.WHITE;
    /** caption text font */
    public var captionFont = Font { size: 24 };
    /** time to detect mouse exiting accordion */
    public var timeOnExit = 0.5s;
    /** time to expand selected image */
    public var timeToExpand = 0.5s;
    /** time to display extended message */
    public var timeToMessage = 1s;
    /** time to hightlight (brighter) the selected image */
    public var timeToNormalLevel = 0.5s;
    /** time to make the unselected images darker */
    public var timeToDarkLevel = 0.5s;
    /** time to hide caption */
    public var timeToHideCaption = 1s;
    /** time to show caption */
    public var timeToShowCaption = 1s;
    /** time to fade in extended message */
    public var timeFadeInMessage = 0.5s;
    /** deselect item on exit */
    public var hideOnExit = true;
    /** dark level for unselected images */
    public var darkLevel = -0.5;
    /** normal level for selected image */
    public var normalLevel = 0.0;
    /** extended message border space */
    public var messageBorder = 10.0;
    /** extended message corner arc */
    public var messageArc = 10.0;
    /** interpolator applied on items movement */
    public var interpolator:Interpolator = SpringInterpolator {
        mass: 1.2,
        bounce: true,
        stiffness: 10
    };
    /** function associated to mouse leaving the accordion */
    public var onAccordionExited:function():Void;
    /** select item on mouse pressed */
    public var selectOnPressed = false;

    /** available space to display the selected image */
    protected var availableWidth: Number;
    /** initial width for images (while no image is selected) */
    protected var initialWidth: Number;
    /** active ImageItem (Id, imagen, funcion, caption, etc). */
    public-read var activeItem: ImageItem;

    /** Sequence containing the accordion "images" */
    var pictures: AccordionItem[];
    /** Number of "mouseEntered" items. Workaround to blockmouse */
    var count: Integer=0;

    /** active imageitem index (mouseover image) */
    public-read var active: Integer on replace {
        /** triggers recalculation of images positions.
          * workaround: deferAction used to avoid a random image blink */
        FX.deferAction(function():Void {
            for (item in pictures) {
                item.adjust();
            };
        });
    };

    /** sequence containing the accordion's items */
    public var images: ImageItem[] on replace {
        // clean sequence
        delete pictures;
        // width for the images if no image is selected
        initialWidth = (if (orientation == HORIZONTAL) width else height) /
            sizeof images;
        // available space for the selected image
        availableWidth = (if (orientation == HORIZONTAL) width else height) -
            ((sizeof images - 1) * minWidth);
        // scan items to add elements to the accordion
        for (image in images) {
            // creates a new accordion item for every image
            insert
            AccordionItem {
                // owner of this item... the accordion
                owner: this
                // item information (image, caption, etc)
                item: image
                // position of the item in the accordion
                imagePos: indexof image
                // Entering event
                onMouseEntered: function(e) {
                    // if selected on mouse entered
                    if (not selectOnPressed) {
                        // will set the item as the active item
                        activeItem=image;
                        // will set the active item with this imageitem index
                        active=indexof image;
                        // will call function associated to onMouseEnter the image
                        image.onMouseEntered(image);
                    }
                    // will increase the number of active mouse entered
                    count++;
                }
                // Exiting event
                onMouseExited: function(e) {
                    // will reset timer to check for mouse exiting the accordion
                    timeReset.playFromStart();
                    // will decrease the number of active mouse entered
                    count--;
                }
                // Click event
                onMousePressed: function(e) {
                    // if select on mouse pressed
                    if (selectOnPressed) {
                        // will set the item as the active item
                        activeItem=image;
                        // will set the active item with this imageitem index
                        active=indexof image;
                    }
                    // will call function associated to onMousePressed the image
                    image.onMousePressed(image);
                }
            } into pictures;
        };
        // enforce initial distribution of images in the accordion
        active=-1;
    };

    /** implements the custumnode create function */
    public override function create(): Node {
        Group {
            // the component includes the "images" in the accordion
            content: pictures
            // clips the images in the accordion to avoid them from
            // exceeding the edges defined for the component
            clip: Rectangle {
                x: 0, y: 0, width: bind width, height: bind height
            }
        };
    };

    /** timer to detect the mouse exiting the accordion */
    var timeReset = Timeline {
        repeatCount: 1
        keyFrames: [
            KeyFrame {
                time: bind timeOnExit
                action: function() {
                    if (count == 0) {
                        if (hideOnExit) {
                            // no item selected
                            active=-1;
                            // no active item
                            activeItem=null
                        }
                        // calls onMouseExited from accordion
                        onAccordionExited();
                    }
                };
            }
        ]
    };

    /** Select image by ID */
    public function select(id:String) {
        for (img in images) {
            if (img.id==id) then {
                active=indexof img;
            }
        };
    };

    /** Select next image */
    public function next() {
        if (active+1>=sizeof images) then {
            active=0;
        } else {
            active++;
        };
    };

    /** Select previous image */
    public function previous() {
        if (active-1<0) then {
            active=sizeof images-1;
        } else {
            active--;
        };
    };
}

