import QtQuick 2.0
import Sailfish.Silica 1.0
import Pace.Keeper 1.0


Page {
    id: page

    allowedOrientations: Orientation.Portrait

    Settings {
        id: settings
    }

    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: qsTr("Back to main")
                onClicked: pageStack.replace(Qt.resolvedUrl("FirstPage.qml"))
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
                text: qsTr("Settings")
            }

            TextSwitch {
                id: switcher
                text: "Enable length in km"
                checked: settings.isLimited
                onCheckedChanged: {
                    settings.isLimited = checked
                }
            }

            Slider {
                id: lengthslider
                label: "Length in km"
                enabled: settings.isLimited
                opacity: settings.isLimited ? 1.0 : 0.3
                width: parent.width
                minimumValue: 1
                maximumValue: 10
                stepSize: 1
                value: settings.length/1000
                valueText: value
                onValueChanged: {
                    settings.length = value * 1000
                }
            }

            Separator {
               x: Theme.paddingLarge
               width: page.width
               color: Theme.highlightDimmerColor
            }

            Slider {
                id: speedslider
                label: "Speed in min/km"
                width: parent.width
                minimumValue: 3
                maximumValue: 8
                stepSize: 0.25
                value: settings.speed/60
                valueText: value
                onValueChanged: {
                    settings.speed = value * 60
                }
            }

            Separator {
                x: Theme.paddingLarge
                width: page.width
                color: Theme.highlightDimmerColor
            }

            Slider {
                id: freqslider
                label: "Interval in m"
                width: parent.width
                minimumValue: 50
                maximumValue: 500
                stepSize: 50
                value: settings.freq
                valueText: value
                onValueChanged: {
                    settings.freq = value
                }
            }
        }
    }
}




