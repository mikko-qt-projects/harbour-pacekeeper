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
import Pace.Keeper 1.0


Page {
    id: page

    allowedOrientations: Orientation.Portrait

    Running {
        id: running
    }

    Settings {
        id: settings
    }

    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.replace(Qt.resolvedUrl("Settings.qml"))
            }
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.replace(Qt.resolvedUrl("About.qml"))
            }
        }

        contentHeight: column.height

        Column {
            width: page.width
            spacing: Theme.paddingLarge

            PageHeader {
                id: header
                title: qsTr("PaceKeeper")
            }

            Label {
                x: Theme.paddingLarge
                font.pixelSize: Theme.fontSizeLarge
                text: qsTr("Instructions")
            }

            Text {
                x: Theme.paddingLarge
                width: page.width - Theme.paddingLarge
                font.pixelSize: Theme.fontSizeSmall
                color: "lightgrey"
                wrapMode: Text.WordWrap
                text: "This app uses GPS positioning and helps you to keep your pace close to target while running. Below the Start-button there is current settings and you can change those under Settings-page.\n* Length: the distance of excercise in km\n* Speed: target pace in min/km\n* Interval: the distance between pace info\nWhen Start is pressed, you have 5 seconds to get ready. I suggest to use earphones to hear the pace info. This app was made mostly of my own purposes."
            }

            Rectangle {
                id: mybtn
                x: Theme.paddingLarge
                width: page.width/2
                height: page.height/10
                radius: page.height/80
                color: "grey"
                opacity: running.isAccuracy? 0.9 : 0.3
                Text {
                    anchors.centerIn: parent
                    text: running.isRunning? "Stop" : "Start"
                }
                MouseArea {
                    anchors.fill: parent
                    enabled: running.isAccuracy
                    onClicked: {
                        if (running.isRunning) {
                            running.stopRunning()
                        } else {
                            running.startRunning()
                        }
                    }
                }
            }

            Row {
                spacing: 4
                x: Theme.paddingLarge
                Item {
                    width: page.width/4; height: page.height/12
                    Text {
                        id: lengthheader
                        color: "lightgrey"
                        font.pixelSize: Theme.fontSizeSmall
                        text: "Length:"
                    }
                    Text {
                        anchors.top: lengthheader.bottom
                        color: "lightgrey"
                        font.pixelSize: Theme.fontSizeSmall
                        text: settings.isLimited ? settings.length + " m" : "N/A"
                    }
                }
                Item {
                    width: page.width/4; height: page.height/12
                    Text {
                        id: speedheader
                        color: "lightgrey"
                        font.pixelSize: Theme.fontSizeSmall
                        text: "Speed:"
                    }
                    Text {
                        anchors.top: speedheader.bottom
                        color: "lightgrey"
                        font.pixelSize: Theme.fontSizeSmall
                        text: settings.speed /60 + " min/km"
                    }
                }
                Item {
                    width: page.width/4; height: page.height/12
                    Text {
                        id: intheader
                        color: "lightgrey"
                        font.pixelSize: Theme.fontSizeSmall
                        text: "Interval:"
                    }

                    Text {
                        anchors.top: intheader.bottom
                        color: "lightgrey"
                        font.pixelSize: Theme.fontSizeSmall
                        text: settings.freq + " m"
                    }
                }
            }
        }
    }
}


