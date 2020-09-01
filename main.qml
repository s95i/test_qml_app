import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.0
import QtQuick.Controls 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    ListModel {
        id: wifiList
        ListElement {
            name: "wifi1"
            signal: -50
        }
        ListElement {
            name: "wifi2"
            signal: -63
        }
        ListElement {
            name: "wifi2"
            signal: -93
        }
        ListElement {
            name: "wifi2"
            signal: -43
        }
        ListElement {
            name: "wifi2"
            signal: -33
        }

    }

    Component {
        id: nameDelegate
        Row {
            spacing :10
        Text {
            id: nameField
            text: name;
            font.pixelSize: 20
            Component.onCompleted: console.log("Welcome", model.index, model.name)
            Component.onDestruction: console.log("Good by", model.index, model.name)
        }
        Text {
            id: signalField
            //text: model.signal + ` dB`;
            font.pixelSize: 20
            //anchors.left: nameField.right
        }
        Image {
            id: signalIcon
            height: 25
            width: 25
            //anchors.left: nameField.right
            //source: "Images/wifi0.jpg"
            source: if(model.signal <=  -90)
                    {
                        "Images/wifi0.jpg"
                    }
            else if(model.signal > -90 && model.signal <= -70 )
                    {
                        "Images/wifi1.jpg"
                    }
             else if(model.signal > -70 && model.signal <= -40 )
                     {
                         "Images/wifi2.jpg"
                     }
              else if(model.signal > -40)
                     {
                          "Images/wifi3.jpg"
                      }

        }

        }

    }

    ListView {
        anchors.fill: parent
        model: wifiList
        delegate: nameDelegate
        clip: true
        cacheBuffer: 40

    }
}
