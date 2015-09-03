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
        //y: ball.y + ball.width / 2 - width / 2
        color: "#70181d"
        property var speed: 0.9
    }

    Rectangle {
        id: ball
        x: parent.width / 2 - width / 2
        y: parent.height / 2 - width / 2
        width: 20
        height: width
        color: "yellow"
        radius: width/2

        property var speed: [battlefield.width/30, battlefield.height/100]

    }

    Timer{
        id: timer
        interval: 40
        repeat : true; running : true; triggeredOnStart : false
        onTriggered: {
            var newX = ball.x + ball.speed[0];
            var newY = ball.y + ball.speed[1];
            // check colision with paddls
            if (newX <= paddleLeft.x + paddleLeft.width && paddleLeft.y <= newY+ball.width/2 && newY+ball.width/2 <= paddleLeft.y+paddleLeft.height ||
                newX + ball.width >= paddleRight.x && paddleRight.y <= newY+ball.width/2 && newY+ball.width/2 <= paddleRight.y+paddleRight.height   ){
                ball.speed[0] = -ball.speed[0];
            } else
            // check field bounds
            if (0 >= newX || newX+ball.width >= battlefield.width || 0 >= newY || newY+ball.width >= battlefield.height){
                ball.x = battlefield.width / 2 - ball.width / 2;
                ball.y = battlefield.height / 2 - ball.width / 2;
            } else {
                 ball.x = newX;
                 ball.y = newY;
            }

            paddleLeft.y = Math.max(0, Math.min(paddleLeft.y + paddleLeft.speed, battlefield.height-paddleLeft.height));
            paddleRight.y = Math.max(0, Math.min(paddleRight.y + paddleRight.speed, battlefield.height-paddleRight.height));

        }
    }
}
