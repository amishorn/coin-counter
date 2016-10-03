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
import QtMultimedia 5.0
import Sailfish.Media 1.0


Page {
    id: camPage

    property string imagePath: ""

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        Camera {
            id: cCamera
            flash.mode: Camera.FlashAuto
            captureMode: Camera.CaptureStillImage
            focus.focusMode: Camera.FocusContinuous
            imageCapture {
                resolution: "3264x1840"
                onImageSaved: {
                    console.log("image saved");
//                    imagePath = cCamera.imageCapture.capturedImagePath;
                    imagePath = "testImg.jpg";
                    console.log(imagePath);
                    pageStack.push(Qt.resolvedUrl("CoinRecPage.qml"));
                }
                onCaptureFailed: {
                    console.error("error: " + cCamera.imageCapture.errorString);
                }
                onImageCaptured: { // does not work: missing SailfishOS feature
                    console.log("Image captured");
                }
            }
            onError: {
                console.error("error: " + cCamera.errorString);
            }
        }

        GStreamerVideoOutput {
            id: cVideoPreview
            anchors.centerIn: parent
            source: cCamera
//            MouseArea {
//                anchors.fill: parent
//                onClicked: {
//                    console.log("capturing");
//                    messageLabel.text = "";
//                    camera.imageCapture.captureToLocation(imagePath);
//                }
//            }
        }

        Button {
            id: cCaptureButton
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Capture"
            onClicked: {
                console.log("capturing");
//                imagePath = ccounter.getNewImgURI();
//                cCamera.imageCapture.captureToLocation(imagePath);
                cCamera.imageCapture.capture();
            }
        }
    }
}


