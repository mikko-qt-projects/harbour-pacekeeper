import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    allowedOrientations: Orientation.Portrait

    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: qsTr("Back to main")
                onClicked: pageStack.replace(Qt.resolvedUrl("FirstPage.qml"))
            }
            MenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.replace(Qt.resolvedUrl("Settings.qml"))
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
                text: qsTr("About")
            }

            Label {
                x: Theme.paddingLarge
                font.pixelSize: Theme.fontSizeMedium
                text: qsTr("Made by:")
            }

            Label {
                x: Theme.paddingLarge
                color: "white"
                font.pixelSize: Theme.fontSizeMedium
                text: qsTr("Mikko Manninen")
            }

            Label {
                x: Theme.paddingLarge
                font.pixelSize: Theme.fontSizeMedium
                text: qsTr("Contact:")
            }

            Label {
                x: Theme.paddingLarge
                color: "white"
                font.pixelSize: Theme.fontSizeMedium
                text: qsTr("mikkomanninen79@gmail.com")
            }

            Label {
                x: Theme.paddingLarge
                font.pixelSize: Theme.fontSizeMedium
                text: qsTr("Git:")
            }

            Label {
                x: Theme.paddingLarge
                color: "white"
                font.pixelSize: Theme.fontSizeMedium
                text: qsTr("https://github/mikkom79/")
            }
        }
    }
}
