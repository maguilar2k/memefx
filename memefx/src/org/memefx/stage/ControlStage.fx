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
 * Date   : February 6, 2009
 *
 */

package org.memefx.stage;

import javafx.animation.*;
import javafx.util.Bits;
import javafx.geometry.Rectangle2D;
import java.lang.*;
import java.io.*;
import java.net.URL;
import javax.jnlp.*;


    /** Windows bar height */
    public var windowsBarHeight:Number = 30.0;
    /** Screen width resolution */
    public-read var maxScrWidth:Number = Float.parseFloat(FX.getProperty("javafx.screen.width"));
    /** Screen width resolution */
    public-read var maxScrHeight:Number = Float.parseFloat(FX.getProperty("javafx.screen.height")) - windowsBarHeight;

    /** Top location */
    public def TOP: Integer = 1;
    /** Bottom location */
    public def BOTTOM: Integer = 2;
    /** Left location */
    public def LEFT: Integer = 4;
    /** Right location */
    public def RIGHT: Integer = 8;
    /** Centered location */
    public def CENTER: Integer = 16;

/**
 * A class that allows to automatically control the stage (window) behavior
 * and persistent positioning and sizing among sessions
 */
public class ControlStage {

    /** Time to check "stickyness" */
    public var timeToCheckStickyness:Duration = 0.5s;
    /** Time to check place and size */
    public var timeToCheckPosSize:Duration = 0.15s;
    /** Time to check edge anchor */
    public var timeToCheckAnchoredEdges:Duration = 0.3s;
    /** Time to call functions (onResize, onMove) */
    public var timeToCallFunctions:Duration = 0.15s;

    /** JNLP persistance service */
    var persistenceService: PersistenceService = null;
    /** JWS app URL */
    var codebase: URL = null;
    /** indicates if the platforms supports JWS services*/
    var isWebStartEnabled: Boolean;

    public-read var error: String ="";

    /** Size and position persistence */
    public var persist: Boolean;
    /** Position persistence */
    public var persistPosition: Boolean;
    /** Size persistence */
    public var persistSize: Boolean;
    /** Initial location of the app window (ie. controlStage.TOP+controlStage.RIGHT) */
    public var initialPosition: Integer;
    /** Filename to store persistent data (every app needs a different name) */
    public var persistFile: String="persistStage.pos";

    /** Custom function to be executed on resize.
    * @param rect Rectangle containing the resized window
     */
    public var onResize: function(rect:Rectangle2D):Void;
    /** Custom function to be executed on move
    * @param rect Rectangle containing the move window
     */
    public var onMove: function(rect:Rectangle2D):Void;

    /** Check minimun window height? */
    public var checkMinHeight:Boolean = false on replace {
        checkHeight()
    };
    /** Minimum height */
    public var minHeight:Number = 200.0 on replace {
        checkHeight()
    };;
    /** Check maximum window height? */
    public var checkMaxHeight:Boolean = false on replace {
        checkHeight()
    };
    /** Maximum height */
    public var maxHeight:Number = 500.0 on replace {
        checkHeight()
    };;

    /** Check minimun window width? */
    public var checkMinWidth:Boolean = false on replace {
        checkWidth()
    };
    /** Minimum width */
    public var minWidth:Number = 200.0 on replace {
        checkWidth()
    };;
    /** Check maximum window width? */
    public var checkMaxWidth:Boolean = false on replace {
        checkWidth()
    };
    /** Maximum width */
    public var maxWidth:Number = 500.0 on replace {
        checkWidth()
    };;

    /** Enforce minimum width? */
    public var enforceMinWidth:Boolean = false on replace {
        checkWidth()
    };;
    /** Enforce minimum height? */
    public var enforceMinHeight:Boolean = false on replace {
        checkHeight()
    };;

    /** Enforce top edge? */
    public var limitTop:Boolean = false on replace {
        checkPos.playFromStart()
    };
    /** Enforce bottom edge? */
    public var limitBottom:Boolean = false on replace {
        checkPos.playFromStart()
    };
    /** Enforce left edge? */
    public var limitLeft:Boolean = false on replace {
        checkPos.playFromStart()
    };
    /** Enforce right edge? */
    public var limitRight:Boolean = false  on replace {
        checkPos.playFromStart()
    };
    /** Enforce all screen edges? */
    public var limitBorders: Boolean on replace {
        if (isInitialized (limitBorders) ) {
            limitTop = limitBorders;
            limitBottom = limitBorders;
            limitLeft = limitBorders;
            limitRight = limitBorders;
            checkPos.playFromStart();
        }
    };

    /** Threshold to stick to the border */
    public var stickyDistance:Number = 40.0 on replace {
        checkSticky.playFromStart()
    };
    /** Sticky top edge? */
    public var stickyTop:Boolean = false on replace {
        checkSticky.playFromStart()
    };
    /** Sticky bottom edge? */
    public var stickyBottom:Boolean = false on replace {
        checkSticky.playFromStart()
    };
    /** Sticky left edge? */
    public var stickyLeft:Boolean = false on replace {
        checkSticky.playFromStart()
    };
    /** Sticky right edge? */
    public var stickyRight:Boolean = false on replace {
        checkSticky.playFromStart()
    };
    /** Stick to all the screen edges? */
    public var stickyBorders: Boolean on replace {
        if (isInitialized (stickyBorders) ) {
            stickyTop = stickyBorders;
            stickyBottom = stickyBorders;
            stickyLeft = stickyBorders;
            stickyRight = stickyBorders;
            checkSticky.playFromStart();
        }
    };

    /** Anchor to the top edge? */
    public var anchorTop:Boolean = false on replace {
        anchorCenter = false;
        checkAnchor.playFromStart();
    };
    /** Anchor to the bottom edge? */
    public var anchorBottom:Boolean = false on replace {
        anchorCenter = false;
        checkAnchor.playFromStart();
    };
    /** Anchor to the left edge? */
    public var anchorLeft:Boolean = false on replace {
        anchorCenter = false;
        checkAnchor.playFromStart();
    };
    /** Anchor to the right edge? */
    public var anchorRight:Boolean = false  on replace {
        anchorCenter = false;
        checkAnchor.playFromStart();
    };
    /** Anchor to the center of the screen? */
    public var anchorCenter:Boolean = false on replace {
        if (anchorCenter) {
            anchorRight =
            anchorLeft =
            anchorBottom =
            anchorTop = false;
            checkCenter.playFromStart();
        }
    };

    /** Initially, set maximum screen width to the window */
    public var initialMaxWidth:Number on replace {
        if (isInitialized(initialMaxWidth)) then 
        width = maxScrWidth;
    };
    /** Initially, set maximum screen height to the window */
    public var initialMaxHeight:Number on replace {
        if (isInitialized(initialMaxHeight)) then
        height = maxScrHeight;
    };
    /** Time to relocate window (animateTo...) */
    public var animationSpeed:Duration=1s;

    /** original x pos to animate window */
    var origX: Number;
    /** original y pos to animate window */
    var origY: Number;
    /** destination x to animate window */
    var destX: Number;
    /** destination y to animate window */
    var destY: Number;
    /** to detect if the moved associated function was triggered */
    var sentPosition: Boolean;
    /** initial position and size */
    var initialWindow: Rectangle2D;

    /** sets if all the checkings are enabled or stopped */
    public var enabled:Boolean = true on replace {
        // if the checkings are disabled
        if (not enabled)
            // stops any window animation
            { 
            animateWindow.stop()

        }
        // if the checkings are enabled
        else {
            // check height and width (and other conditions, sticky, anchor, etc)
            checkHeight();
            checkWidth();
            // if its anchor to the center of the screen
            if (anchorCenter)
                // checks to keep the window centered
            checkCenter.playFromStart();
        }
    };

    /** Locks current width */
    var lockedWidth: Number;
    public var lockWidth: Boolean on replace {
        // if width is locked
        if (lockWidth) then
            // gets current width
            { 
            lockedWidth = width

        }
        else 
            // check width
        {
            checkWidth()

        };
    };

    /** locks current height */
    var lockedHeight: Number;
    public var lockHeight: Boolean on replace {
        // if height is locked
        if (lockHeight) then
            // gets current height
            { 
            lockedHeight = height

        }
        else
            // check height
        {
            checkHeight()

        };
    };

    /** Window height */
    public var height: Number = 500.0 on replace {
        // checks height
        checkHeight();
        // executes associated resize function
        callOnResize.playFromStart();
    };

    /** Checks window height */
    function checkHeight() {
        // if checkings are enabled
        if (enabled) {
            // if height is not locked
            if (not lockHeight) {
                // enforce the window not to be bigger than the screen height
                if (height > maxScrHeight)
                height = maxScrHeight;
                // if minimum height control is enabled and the height is
                // smaller than the minimum height allowed or minimum height
                // enforcement is enabled
                if ((checkMinHeight and height < minHeight) or enforceMinHeight) then
                    // sets height to the minimum allowed
                height = minHeight;
                // if maximum height control is enabled and height is 
                // bigger than the maximum height allowed
                if (checkMaxHeight and height > maxHeight) then
                    // sets height to the maximum allowed
                height = maxHeight;
                // if centered anchor is enabled
                if (anchorCenter) {
                    // keeps window centered
                    checkCenter.playFromStart();
                // not centered


                } else {
                    // check window conditions
                    checkPos.playFromStart();
                    checkAnchor.playFromStart();
                    checkSticky.playFromStart();
                };
            }
            // if height is locked
            else {
                // sets height to the locked height
                height = lockedHeight;
            };
        };
    };

    /** Window width */
    public var width: Number = 500.0 on replace {
        // checks width
        checkWidth();
        // executes associated resize function
        callOnResize.playFromStart();
    };

    /** Checks window width */
    function checkWidth() {
        // if checkings are enabled
        if (enabled) {
            // if width is not locked
            if (not lockWidth) {
                // enforce the window not to be wider than the screen width
                if (width > maxScrWidth)
                width = maxScrWidth;
                // if minimum width control is enabled and the width is
                // smaller than the minimum width allowed or minimum width
                // enforcement is enabled
                if ((checkMinWidth and width < minWidth) or enforceMinWidth) then
                    // sets width to the minimum allowed
                width = minWidth;
                // if maximum width control is enabled and width is
                // bigger than the maximum width allowed
                if (checkMaxWidth and width > maxWidth) then
                    // sets width to the maximum allowed
                width = maxWidth;
                // if centered anchor is enabled
                if (anchorCenter) {
                    // keeps window centered
                    checkCenter.playFromStart();
                // not centered


                } else {
                    // check window conditions
                    checkPos.playFromStart();
                    checkAnchor.playFromStart();
                    checkSticky.playFromStart();
                };
            }
            // if width is locked
            else {
                // sets width to the locked width
                width = lockedWidth;
            };
        };
    };

    /** Horizontal position */
    public var x:Number = 0.0 on replace {
        // if checkings are enabled
        if (enabled) {
            // if centered anchor is enabled
            if (anchorCenter) {
                // keeps window centered
                checkCenter.playFromStart();
            }
            // if anchor to the left or right
            else if (anchorLeft or anchorRight) {
                // check anchoring conditions
                checkAnchor.playFromStart();
            }
            // if not anchor to the left or right
            else {
                // if it sticks to left of right
                if (stickyLeft or stickyRight) then
                    // check sticky conditions
                checkSticky.playFromStart();
                // if it enforce left or right margins
                if (limitLeft or limitRight) then
                    // check window position
                checkPos.playFromStart();
            }
        }
        // if onMove function was executed
        if (sentPosition) then {
            // reset flag
            sentPosition = false;
            // stop timeline
            callOnMove.stop();
        };
        // starts/continues timeline
        callOnMove.play();
    };

    /** Vertical position */
    public var y:Number = 0.0 on replace {
        // if checkings are enabled
        if (enabled) {
            // if centered anchor is enabled
            if (anchorCenter) {
                // keeps window centered
                checkCenter.playFromStart();
            }
            // if anchor to the top or bottom
            else if (anchorTop or anchorBottom) {
                // check anchoring conditions
                checkAnchor.playFromStart();
            }
            // if not anchor to the left or right
            else {
                // if it sticks to the top or bottom
                if (stickyTop or stickyBottom) then
                    // check sticky conditions
                checkSticky.playFromStart();
                // if it enforce top or bottom margins
                if (limitTop or limitBottom) then
                    // check window position
                checkPos.playFromStart();
            };
        };
        // if onMove function was executed
        if (sentPosition) then {
            // reset flag
            sentPosition=false; 
            // stop timeline
            callOnMove.stop();
        };
        // starts/continues timeline
        callOnMove.play();
    };

    /** Set width to screen width */
    public function setMaxWidth() {
        width = maxScrWidth;
    }

    /** Set height to screen height */
    public function setMaxHeight() {
        height = maxScrHeight;
    }

    /** Maximize to screen size */
    public function maximize() {
        x=0;
        y=0;
        setMaxWidth();
        setMaxHeight();
    }

    /** Recovers initial position/size */
    public function recoverInitialWindow() {
        x = initialWindow.minX;
        y = initialWindow.minY;
        width = initialWindow.width;
        height = initialWindow.height;
    }

    /** Recovers initial position */
    public function recoverInitialPos() {
        x = initialWindow.minX;
        y = initialWindow.minY;
    }

    /** Recovers initial size */
    public function recoverInitialSize() {
        width = initialWindow.width;
        height = initialWindow.height;
    }

    /** Place window at the specified location
    * @param to Combination (sum) of stageControl.TOP, stageControl.BOTTOM,
     *            stageControl.LEFT, stageControl.RIGHT or stageControl.CENTER
     */
    public function move(to:Integer) {
        if (Bits.bitAnd(to, TOP) == TOP) then
        y = 0;
        if (Bits.bitAnd(to, BOTTOM) == BOTTOM) then
        y = maxScrHeight - height;
        if (Bits.bitAnd(to, LEFT) == LEFT) then
        x = 0;
        if (Bits.bitAnd(to, RIGHT) == RIGHT) then
        x = maxScrWidth - width;
        if (Bits.bitAnd(to, CENTER) == CENTER) then {
            x = maxScrWidth / 2 - width / 2;
            y = maxScrHeight / 2 - height / 2;
        };
    };

    /** Place window at the specified location
    * @param posx Horizontal coordinate
     * @param posy Vertical coordinate
     */
    public function move(px:Number, py:Number) {
        x = px;
        y = py;
    }

    /** Slides window to the specified coordinate
    * @param dx Horizontal coordinate for the window
     * @param dy Vertical coordinate for the window
     */
    public function animateTo(dx:Number, dy:Number) {
        origX = x;
        origY = y;
        destX = dx;
        destY = dy;
        anchorCenter = 
        anchorTop =
        anchorBottom =
        anchorLeft =
        anchorRight = false;
        animateWindow.playFromStart();
    }

    /** Slides window to the specified distance from the borders
    * @param corner Location used as reference for the destination of the window
     * @param dx     Horizontal distance to the location
     * @param dy     Vertical distance to the location
     */
    public function animateToBorder(corner:Integer, dx:Number, dy:Number) {
        destX =
        origX = x;
        destY =
        origY = y;
        if (Bits.bitAnd(corner, TOP) == TOP) then
        destY = dy;
        if (Bits.bitAnd(corner, BOTTOM) == BOTTOM) then
        destY = maxScrHeight - height - dy;
        if (Bits.bitAnd(corner, LEFT) == LEFT) then
        destX = dx;
        if (Bits.bitAnd(corner, RIGHT) == RIGHT) then
        destX = maxScrWidth - width - dx;
        anchorCenter = 
        anchorTop =
        anchorBottom =
        anchorLeft =
        anchorRight = false;
        animateWindow.playFromStart();
    }

    /** Asynchronous window position check */
    var checkPos:Timeline = Timeline {
        repeatCount: 1
        keyFrames: [
            KeyFrame {
                time: bind timeToCheckPosSize
                action: function() {
                    // if checkings are enabled
                    if (enabled) {
                        // if it enforces the top edge and exceeds it,
                        // set vertical position to the top
                        if (limitTop and y < 0) then { 
                            y = 0

                        };
                        // if it enforces the bottom edge and exceeds it,
                        if (limitBottom and y + height > maxScrHeight) then
                            // set vertical position to the bottom
                        y = maxScrHeight - height;
                        // if it enforces the left edge and exceeds it,
                        // set horizontal position to the left
                        if (limitLeft and x < 0) then { 
                            x = 0

                        };
                        // if it enforces the right edge and exceeds it,
                        if (limitRight and x + width > maxScrWidth) then {
                            // set horizontal position to the right
                            x = maxScrWidth - width;
                        }
                    }
                }
            }
        ]
    };

    /** Asynchronous stickyness check */
    var checkSticky:Timeline = Timeline {
        repeatCount: 1
        keyFrames: [
            KeyFrame {
                time: bind timeToCheckStickyness
                action: function() {
                    // if checkings are enabled
                    if (enabled) {
                        // if left edge is sticky and window is close to the left edge
                        if (stickyLeft and x < stickyDistance and
                        x > - stickyDistance) then
                            // stick window to the left edge
                            { 
                            x=0

                        }
                        else {
                            // if right edge is sticky and window is close to the right edge
                            if (stickyRight and
                            x + width > maxScrWidth - stickyDistance and
                            x + width < maxScrWidth + stickyDistance) then
                                // stick window to the right edge
                            {
                                x = maxScrWidth - width

                            };
                        };

                        // if top edge is sticky and window is close to the top edge
                        if (stickyTop and y < stickyDistance and
                        y > - stickyDistance) then
                            // stick window to the top edge
                            { 
                            y = 0

                        }
                        else {
                            // if bottom edge is sticky and window is close to the bottom edge
                            if (stickyBottom and
                            y + height > maxScrHeight - stickyDistance and
                            y + height < maxScrHeight + stickyDistance) then
                                // stick window to the bottom edge
                            {
                                y = maxScrHeight - height

                            }
                        };
                    };
                }
            }
        ]
    };

    /** Asynchronous anchoring check */
    var checkAnchor:Timeline = Timeline {
        repeatCount: 1
        keyFrames: [
            KeyFrame {
                time: bind timeToCheckAnchoredEdges
                action: function() {
                    // if checkings are enabled
                    if (enabled) {
                        // if anchored to the left, set horizontal position to the left
                        if (anchorLeft) { 
                            x = 0

                        }
                        // if anchored to the right, set horizontal position to the right
                        else if (anchorRight) { 
                            x = maxScrWidth - width


                        };

                        // if anchored to the top, set vertical position to the top
                        if (anchorTop) { 
                            y = 0

                        }
                        // if anchored to the bottom, set vertical position to the bottom
                        else if (anchorBottom) { 
                            y = maxScrHeight - height


                        };
                    }
                }
            }
        ]
    };

    /** Asynchronous centered check */
    var checkCenter:Timeline = Timeline {
        repeatCount: 1
        keyFrames: [
            KeyFrame {
                time: bind timeToCheckPosSize
                action: function() {
                    // if checkings are enabled
                    if (enabled) {
                        // set window position to the center of the screen
                        x = maxScrWidth / 2 - width / 2;
                        y = maxScrHeight / 2 - height / 2;
                    }
                }
            }
        ]
    };


    /** On window resize: asynchronous call to associated function */
    var callOnResize:Timeline = Timeline {
        repeatCount: 1
        keyFrames: [
            KeyFrame {
                time: bind timeToCallFunctions
                action: function() {
                    // if an associated function was set
                    if (isInitialized(onResize))
                        // executes the function passing window position and size
                    onResize(Rectangle2D {
                        minX: x,
                        minY: y
                        width: width,
                        height: height
                    });
                }
            }
        ]
    };


    /** On window move: asynchronous call to associated function */
    var callOnMove:Timeline = Timeline {
        repeatCount: 1
        keyFrames: [
            KeyFrame {
                time: bind timeToCallFunctions
                action: function() {
                    // if an associated function was set
                    if (isInitialized(onMove)) {
                        // executes the function passing window position and size
                        onMove(Rectangle2D { 
                            minX: x,
                            minY: y
                            width: width,
                            height: height
                        });
                        // sets flag to delay next function call
                        sentPosition = true;
                    };
                }
            }
        ]
    };


    /** Animates window movement */
    var animateWindow:Timeline = Timeline {
        repeatCount: 1
        keyFrames: [
            KeyFrame {
                time:0s
                values:[x => origX, y => origY]
            }
            KeyFrame {
                time: bind animationSpeed
                values: [x => destX, y => destY tween Interpolator.EASEOUT]
            }
//            at (0s) { x => origX; y => origY }
//            at (1s) { x => destX; y => destY tween Interpolator.EASEOUT}
        ]
    };


    /** Returns stage controller working directory
    * @return Path to working user's directory
     */
    function getAppPath():String {
        "{System.getProperty("user.home")}{File.separator}stagecontroller{File.separator}";
    };


    /** stores in local file the position and size of the window */
    public function persistStage() {

        // persistent data
        var cache = new PersistentData (x, y, width, height);

         // if the platform supports JWS services
        if (isWebStartEnabled) then {
            // stores cache with the JWS persistence service
            PersistentMethods{
            }.store(persistenceService, codebase, cache);
        } else {

            // check if the working directory exists
            var pDir: File=new File("{getAppPath()}");
            // if it doesn't exist
            if (not pDir.exists()) then {
                // create the working directory
                pDir.mkdir();
            }
            // stores position and size
            var pFile: File=new File("{getAppPath()}{persistFile}");
            try {
                var out: ObjectOutput = new ObjectOutputStream
                    (new FileOutputStream(pFile));
                out.writeObject(cache);
                out.close();
            } catch (e:Exception) {
            }
        };
    };


    /** recovers persistent information about the app window */
    function recoverPersistentStage():PersistentData {

        var cache: PersistentData = null;

         // if the platform supports JWS services
        if (isWebStartEnabled) then {
            // recovers cache with JWS persistence sevice
            cache = 
            PersistentMethods{
            }.recover(persistenceService, codebase);
        } else {
            // used to verify if the persistent file exist
            var fileExist = false;
            // Path to the local file
            var pFile: File=new File("{getAppPath()}{persistFile}");
             // Verifies if the local file exists
            fileExist = pFile.exists();
             // if file exist
            if (fileExist)
             {
             // load previous window position and size
                try {
                    var ois: ObjectInputStream  = new ObjectInputStream
                        (new FileInputStream(pFile));
                    cache =
                    ois.readObject() as PersistentData;
                    ois.close();
                } catch (e:Exception) {
                }
            }
        }
        return cache;
    };


    /** verifies if the platform includes a specific class*/
    function exists(className:String):Boolean
    {
        try {
            Class.forName (className);
            return true;
        } catch (exception:ClassNotFoundException ) {
            return false;
        }
    }


    /** init stage controller */
    init {
        // verify if JNLP library is available
        isWebStartEnabled=exists("javax.jnlp.FileContents");
        // if the platform supports JWS services
        if (isWebStartEnabled) then {

            try {
                var basicService: BasicService =
                ServiceManager.lookup("javax.jnlp.BasicService") as BasicService;
                var base = basicService.getCodeBase();
                codebase= new URL("{base.toString()}{persistFile}");
                persistenceService =
                ServiceManager.lookup("javax.jnlp.PersistenceService") as PersistenceService;
            } catch (use:Exception) {
            }

        }
    };

    /** after initializing the app */
    postinit {
        // used to stored the data to persist
        var cache: PersistentData=null;

        // if persistent position and/or size are/is enabled
        if (persist or persistPosition or persistSize) {
             
            // attemps to recover persistent dimension/position
            cache = recoverPersistentStage();

            // if it recovered something
            if (cache != null) then {
                // if persistent position+size or position is enabled
                if (persist or persistPosition) {
                    // set previous position for the window
                    x = cache.x;
                    y = cache.y;
                };
                // if persistent position+size or size is enabled
                if (persist or persistSize) {
                    // set previous size for the window
                    width = cache.width;
                    height = cache.height;
                };
            } else {
                // stores window position and size, locally
                persistStage();
            };

        }

        // if local file doesn't exist or not position+size and
        // not position persistance is enabled
        if (cache == null or (not persist and not persistPosition)) {
            // if an initial position for the window was set
            if (isInitialized(initialPosition)) {
                // place the window in the initial position
                move(initialPosition);
            }
            // if no initial position was set
            else {
                // place the window at the center of the screen
                move(CENTER);
            };

        };

        // stores initial position and size
        initialWindow = Rectangle2D {
            minX: x,
            minY: y,
            width: width,
            height: height
        };

    }
}