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

import javafx.scene.Node;
import javafx.scene.input.MouseEvent;

// contiene una opcion del menu
public class MenuItem {

    // texto de la opcion
    public var text: String;
    // funcion asociada a la opcion del menu (lo que ejecuta)
    // le traspasa el mouseevent a la funcion; por ejemplo: si el usuario
    // quiere saber donde se hizo click cuando aparecio el menu flotante
    public var call: function():Void;
    public var callPos: function(e:MouseEvent):Void;
    public var callId: function(activeNodeID:String):Void;
    public var callNode: function(activeNode:Node):Void;
    public var callPosId: function(e:MouseEvent, activeNodeID:String):Void;
    public var callPosNode: function(e:MouseEvent, activeNode:Node):Void;
    // posicion de la opcion en el menu
    public var pos: Number=0;
    // indica que no es un separador de opciones del menu
    protected var isSeparator = false;

};
