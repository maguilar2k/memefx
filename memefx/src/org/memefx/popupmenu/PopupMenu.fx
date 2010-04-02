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
 * Date   : March 9 , 2009
 *
 */

package org.memefx.popupmenu;

import javafx.scene.CustomNode;
import javafx.scene.Node;
import javafx.scene.Group;
import javafx.scene.paint.*;
import javafx.scene.shape.*;
import javafx.scene.input.*;
import javafx.scene.text.*;
import javafx.scene.effect.DropShadow;
import javafx.animation.*;
import java.lang.Math;

/** list of available popup menus */
var menus: PopupMenu[];

/** registers a popupmenu */
public function add(menu:PopupMenu) {
    insert menu into menus;
};

/** returns the list of available popup menus */
public function activateMenus() {
    menus;
};

/** selected node (with popup menu) */
var activeNode: Node;
/** active node ID */
var activeNodeID: String;
/** original mouse event*/
var mouseEvent: MouseEvent;

/** implements a popup menu control */
public class PopupMenu extends CustomNode {

    // espacio hacia el borde del menu
    public var padding = 4.0;
    // espacio vertical entre opciones
    public var verticalSpacing = 2.0;

    // ancho del menu
    var menuWidth = 0.0;
    // alto del menu
    var menuHeight = 0.0;
    // escala del menu
    var scale = 1.0;

    // font del menu
    public var font: Font = Font{ size: 14
    };
    // color de fondo del menu
    public var fill: Color = Color.WHITE;
    // color del borde del menu
    public var borderColor: Color = Color.BLACK;
    // color del borde del menu
    public var stroke: Color = Color.BLACK;
    // ancho del borde del menu
    public var borderWidth: Number = 1;
    // color para destacar fondo de opcion
    public var highlight: Color = Color.LIGHTBLUE;
    // color para destacar texto de opcion
    public var highlightStroke: Color = Color.BLUE;
    // indica si tiene sombra
    public var shadow: Boolean=true;
    // sombra horizontal
    public var shadowX = 5.0;
    // sombra horizontal
    public var shadowY = 5.0;
    // esquinas redondeadas
    public var corner = 0.0;
    // gradiente opcional
    public var gradient: Paint=null;
    // animacion in/out
    public var animate = false;

    // opacidad
    override public var opacity=1.0;
    // giro del menu
    override public var rotate=0.0;


    // opciones del menu popup
    public var content: MenuItem[]=null on replace {
        // si cambia, obtiene dimensiones del menu y preprocesa opciones
        parseOptions(content) 
    };

    // opciones graficas
    var optionsObjects: Node[];
    // mouse event triggered
    var event: MouseEvent;

    // triggered when the mouse is click over an object
    public function click(event:MouseEvent) {
        // stores mouse event
        this.event=event;
        // hides all registered popup menus
        for (menu in menus) {
            menu.visible=false;
        }
        if (event.button == MouseButton.SECONDARY) {
            mouseEvent=event;
        };
        // si oprimio el boton derecho, hace visible el menu
        var isVisible = event.button == MouseButton.SECONDARY;
        this.visible = isVisible;
        // if animation is enabled
        if (animate == true) then {
            // animate menu popup
            appear.playFromStart();
        }
    };

    // procesa opciones del menu
    function parseOptions(options:MenuItem[]):Void {

        // si hay opciones y font definido
        if (options != null and font != null) then {

            // calcula ancho basico
            var maxWidth = 0.0;
            // calcula alto basico
            var maxHeight = padding;

            // recorre opciones
            for (option in options) {
                // obtiene texto de la opcion
                var text = Text {
                    font: bind font
                    content: option.text
                };
                // obtiene dimension del texto de la opcion
                var rec = text.boundsInLocal;
                // posicion vertical
                option.pos = maxHeight;
                // acumula alto del menu
                maxHeight +=
                rec.height + verticalSpacing;
                // busca el ancho maximo entre las opciones
                maxWidth = Math.max(rec.width, maxWidth);
            };

            // tamano calculado para el menu
            menuWidth = maxWidth;
            menuHeight = maxHeight - verticalSpacing;

            // crea botones de opciones y espacios
            for (option in options) {
                // obtiene texto de la opcion
                var text = Text {
                    font: bind font
                    content: option.text
                };
                // obtiene dimension del texto de la opcion
                var rec = text.boundsInLocal;
                
                // crea opcion
                var optionButton = Group {

                    // color para el fondo de la opcion
                    var color: Color = fill;
                    // color para el texto de la opcion
                    var txtcolor: Color = stroke;

                    // timeline para destacar la opcion con el mouse
                    var show = Timeline {
                        keyFrames: [
                            at (0s) {color => fill; txtcolor => stroke }
                            at (0.2s) {color => highlight; txtcolor => highlightStroke }
                        ]
                    };

                    // timeline para normalizar opcion luego de ser destacada
                    var hide = Timeline {
                        keyFrames: [
                            at (0s) {color => highlight; txtcolor => highlightStroke }
                            at (0.2s) {color => fill; txtcolor => stroke }
                        ]
                    };

                    // bloquea el click del mouse si hay elementos bajo del menu
                    blocksMouse: true

                    // declara la opcion de menu
                    content: [
                        // rectangulo de fondo para la opcion
                        Rectangle {
                            fill: bind color
                            x: bind event.x + padding
                            y: bind event.y + option.pos
                            width: bind maxWidth
                            height: bind rec.height
                        },
                        // texto de la opcion
                        Text {
                            fill: bind txtcolor
                            x: bind event.x + padding
                            y: bind event.y + option.pos
                            font: bind font
                            content: option.text
                            textOrigin: TextOrigin.TOP
                        },
                        // rectangulo transparente sobre el texto y fondo
                        Rectangle {
                            // bloquea el click para los elementos que estan debajo
                            blocksMouse: true
                            fill: Color.TRANSPARENT
                            x: bind event.x + padding
                            y: bind event.y + option.pos
                            width: bind maxWidth
                            height: bind rec.height
                            // si el usuario hace click sobre la opcion
                            onMousePressed: function(e) {
                                // con el boton principal del mouse
                                if (e.button == MouseButton.PRIMARY) {
                                    // ejecuta la funcion asociada al boton
                                    // traspasando el evento del mouse (posicion del mouse)
                                    if (isInitialized(option.call))
                                    option.call();
                                    if (isInitialized(option.callPos))
                                    option.callPos(mouseEvent);
                                    if (isInitialized(option.callId))
                                    option.callId(activeNodeID);
                                    if (isInitialized(option.callNode))
                                    option.callNode(activeNode);
                                    if (isInitialized(option.callPosId))
                                    option.callPosId(mouseEvent, activeNodeID);
                                    if (isInitialized(option.callPosNode))
                                    option.callPosNode(mouseEvent, activeNode);
                                    // reset active node
                                    activeNode=null;
                                    activeNodeID=null;
                                    mouseEvent=null;
                                    // oculta el menu flotante
                                    this.visible=false;
                                }
                            };
                            // si entra con el mouse a la opcion
                            onMouseEntered: function(e) {
                                // destaca la opcion (cambiando colores)
                                show.playFromStart();
                            };
                            // si sale de la opcion con el mouse
                            onMouseExited: function(e) {
                                // restaura opcion (repone colores)
                                hide.playFromStart();
                            };
                        },

                    ]
                };
                // agrega la opcion a una secuencia (array o arreglo)
                insert optionButton into optionsObjects;
            };
        };
    };

    // animacion para mostrar menu
    var appear = Timeline {
        repeatCount: 1
        keyFrames: [
            at (0s) { scale => 0.0 }
            at (0.2s) { scale => 1.0 tween Interpolator.EASEIN }
        ]
    };

    /** binds popupmenu to object */
    public function to(node:Node) {
        // stops mouse event propagation
        node.blocksMouse=true;
        // obtains the original function related to the onMousePressedEvent
        var origFunc:function(e:MouseEvent):Void=node.onMousePressed;
        // adds onmouse event to the object
        node.onMousePressed= function(e:MouseEvent) {
            // triggers the original function
            origFunc(e);
            // tries the popupmenu function
            click(e);
            // stores information about the clicked node
            activeNode = node;
            activeNodeID = node.id;
        };
    };

    // checks if the popupmenu was already registered
    function checkPopupRegistration() {
        var exist: Boolean;
        for (menu in menus) {
            if (this == menu) then
            exist=true;
        }
        // if it wasn't registered
        if (not exist)
            // register the popupmenu
        add(this);
    }


    // crea el componente del menu flotante
    override function create():Node {

        // no es visible al crearlo
        this.visible=false;

        Group {
            //            cache:true
            rotate: bind rotate
            scaleX: bind scale
            scaleY: bind scale
            opacity: bind opacity
            content: [
                // rectangulo de fondo del menu flotante
                Rectangle {
                    // posiciona en la ubicacion del mouse
                    x: bind event.x
                    y: bind event.y
                    arcHeight: bind corner
                    arcWidth: bind corner
                    // asigna tamano dependiendo de las opciones
                    width: bind menuWidth + padding * 2
                    height: bind menuHeight + padding
                    // parametros para pintar el fondo
                    fill: bind if (gradient != null) then gradient else fill
                    stroke: bind borderColor
                    strokeWidth: bind borderWidth
                    // si la sobra esta activa, la agrega, sino la omite
                    effect: bind if (shadow) {
                        DropShadow {
                            offsetX: bind shadowX
                            offsetY: bind shadowY
                        }
                    }
                    else null;
                },
                // agrega las opciones pregeneradas
                optionsObjects
            ]
        }
    }

    postinit {
        checkPopupRegistration();
    }


}
