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

package org.memefx.stage;

import javax.jnlp.*;
import java.io.*;
import java.net.URL;

/** This class implements the methods used by the JWS persistence service.
    it's a workaround, to avoid a runtime error when launching the app
    outside of the Java Web Start environment */
class PersistentMethods {

    /** Recovers the app window location and size from the JWS persistence service
     *
     * @param persistenceService JWS persistence service instance
     * @param codebase URL related to the JWS app
     * @return PersistData containing the app window location and size
     */
    public PersistentData recover(PersistenceService persistenceService, URL codebase) {

        // data to recover
        PersistentData cache=null;
        // recovers the object from the repository
        try {
            FileContents appSettings = null;
            appSettings = persistenceService.get(codebase);
            ObjectInputStream ois = new ObjectInputStream
                ( appSettings.getInputStream() );
            cache = (PersistentData) ois.readObject() ;
            ois.close();
        } catch (FileNotFoundException fnfe ) {
            // create the cache
            try {
                persistenceService.create(codebase, 1024);
            } catch (IOException ioe) {
            }
        } catch (Exception e) {
        }
        // returns null or the app window information
        return cache;
    }

    /** Stores the app window location and size into the JWS persistence repository
     *
     * @param persistenceService JWS persistence service instance
     * @param codebase URL related to the JWS app
     * @param cache PersistData containing the app window location and size
     */
    public void store(PersistenceService persistenceService, URL codebase, PersistentData cache) {

        // stores the app window data into the JWS persistence repository
        try {
            FileContents fc  = persistenceService.get(codebase);
            ObjectOutputStream oos = new ObjectOutputStream(fc.getOutputStream(true));
            oos.writeObject( cache );
            oos.flush();
            oos.close();
        } catch (Exception e) {
        }

    }

}
