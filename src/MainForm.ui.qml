import QtQuick 2.4

Rectangle {

    width: 360
    height: 360
    color: "#1f291f"

    Rectangle {
        id:  paddleRigth
        x: parent.width-width
        y: 141
        width: 22
        height: 79
    }

    Rectangle {
        id: paddleLeft
        x: 0
        y: 141
        width: 22
        height: 79
        //y: ball.y + ball.width / 2 - width / 2
        color: "green"
    }

    Rectangle {
        // id: net
        x: parent.width / 2
        y: 0
        width: 1
        height: parent.height
        color: "grey"
    }

    Rectangle {
        id: ball
        x: parent.width / 2 - width / 2
        y: parent.height / 2 - width / 2
        width: 34
        height: width
        color: "yellow"
        radius: width/2
    }
}
