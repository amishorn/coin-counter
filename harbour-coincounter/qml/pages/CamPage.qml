/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Media 1.0       // used for GStreamer
//import com.jolla.camera 1.0     // component not installed -> hence QtMultimedia
import QtMultimedia 5.4         // used for Camera


Page {
    id: camPage

    property bool debug: false
    property bool vFVis: true
    property QtObject viewfinder
    readonly property string resolution: "3200x1800" //JP "3264x1840"

    readonly property int viewfinderOrientation: {
            var rotation = 0
            switch (camPage.orientation) {
            case Orientation.Landscape: rotation = 90; break;
            case Orientation.PortraitInverted: rotation = 180; break;
            case Orientation.LandscapeInverted: rotation = 270; break;
            }
            return (720 + csfCamera.orientation + rotation) % 360
        }

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        id: cSFlick
        anchors.fill: parent

        Camera {
            id: csfCamera
            flash.mode: Camera.FlashAuto
            captureMode: Camera.CaptureStillImage
            focus.focusMode: Camera.FocusContinuous

            metaData {
                orientation: viewfinderOrientation
            }

            imageCapture {
                resolution: camPage.resolution
                onImageSaved: {
                    console.log("image Saved called");
                    postCapture();
                    console.log("function end")
                }
                onCaptureFailed: {
                    console.error("error: " + csfCamera.imageCapture.errorString);
                }
                onImageCaptured: { // does not work: missing SailfishOS feature
                    console.log("Image captured");
                }
            }
            onError: {
                console.error("error: " + csfCamera.errorString);
            }
        }

        Binding {
            target: camPage.viewfinder
            property: "source"
            value: csfCamera
        }

        Binding {
            target: camPage.viewfinder
            property: "visible"
            value: camPage.vFVis
        }

        MouseArea {
            id: csfMouseArea
            anchors.fill: parent
            onClicked: {
                console.log("mouse area clicked...")
                if(debug) postCapture();
                else csfCamera.imageCapture.capture();
            }
        }
    }

    function postCapture(){
        console.log("image saved");
        camPage.vFVis = false
        var recPage = pageStack.push(Qt.resolvedUrl("CoinRecPage.qml"));
        recPage.imagePath = !debug ? csfCamera.imageCapture.capturedImagePath : "/home/nemo/Pictures/testImgII.jpg";
        console.log(recPage.imagePath);
        onPageClosed: {
            camPage.vFVis = true
            console.log("rec page was closed, I guess...")
        }
    }
}


