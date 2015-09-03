import QtQuick 2.4

Rectangle {
    id: battlefield

    width: 830
    height: 530
    color: "#1f291f"

    Rectangle {
        x: parent.width / 2
        y: 0
        width: 1
        height: parent.height
        color: "darkgrey"
    }
    Rectangle {
        anchors.fill: parent
        width: 1
        color: "transparent"
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 1
        anchors.topMargin: 0
        border.color: "darkgrey"
    }

    Rectangle {
        id: paddleRight
        x: parent.width-width
        y: (parent.height - height) / 2
        width: 23
        height: 70
        color: "#70181d"
        property var speed: -0.8
    }

    Rectangle {
        id: paddleLeft
        x: 0
        y: (parent.height - height) / 2
        width: 23
        height: 70
        color: "#70181d"
    }

    Rectangle {
        id: ball
        x: parent.width / 2 - width / 2
        y: parent.height / 2 - width / 2
        width: 20
        height: width
        color: "yellow"
        radius: width/2
    }

    Text {
        id: countLeft
        x: battlefield.width / 3 - width
        y: parent.height / 8
        color: "#d7bfbf"
        text: "0"
        horizontalAlignment: Text.AlignRight
        font.family: "Arial"
        font.pixelSize: parent.height / 8
    }
    Text {
        id: countRight
        x: 2 * battlefield.width / 3
        y: parent.height / 8
        color: "#d7bfbf"
        text: "0"
        horizontalAlignment: Text.AlignLeft
        font.family: "Arial"
        font.pixelSize: parent.height / 8
    }

    property alias ball: ball
    property alias paddleLeft: paddleLeft
    property alias paddleRight: paddleRight
    property alias countLeft: countLeft
    property alias countRight: countRight

}
