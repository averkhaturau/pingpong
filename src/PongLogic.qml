import QtQuick 2.0

Item {
    id: pongLogic
    property Item battlefield: none
    property Item ball: none
    property Item paddleLeft: none
    property Item paddleRight: none
    property var count: [0,0]
    property Text countL: none
    property Text countR: none
    property var ballSpeed: [battlefield.width/55, Math.random(battlefield.height/100)]
    property int leftPaddleSpeed: ballSpeed[1]>0? 1: -1
    property int rightPaddleSpeed: ballSpeed[1]>0? 1: -1

    Timer{
        id: timer
        interval: 40
        repeat : true;
        running : true;
        triggeredOnStart : false

        onTriggered: {
            var newX = ball.x + ballSpeed[0];
            var newY = ball.y + ballSpeed[1];
            // check colision with paddls
            if (newX <= paddleLeft.x + paddleLeft.width && paddleLeft.y <= newY+ball.width/2 && newY+ball.width/2 <= paddleLeft.y+paddleLeft.height ||
                    newX + ball.width >= paddleRight.x && paddleRight.y <= newY+ball.width/2 && newY+ball.width/2 <= paddleRight.y+paddleRight.height   ){
                ballSpeed[0] = -ballSpeed[0] * 1.1;
                ballSpeed[1] =  ballSpeed[1] * 1.1;
            } else {
                // check field bounds
                var leftGoal = newX+ball.width >= battlefield.width;
                var rightGoal = 0 >= newX;
                if (leftGoal || rightGoal){
                    ++count[leftGoal?0:1];
                    countL.text = ''+count[0];
                    countR.text = ''+count[1];
                    ball.x = battlefield.width / 2 - ball.width / 2;
                    ball.y = battlefield.height / 2 - ball.width / 2;
                    ballSpeed = [battlefield.width/55 * (-1+2*Math.round(Math.random())), battlefield.height/100 * (-1+2*Math.round(Math.random()))]
                } else if(newY <=0 || newY+ball.width >= battlefield.height){
                    ballSpeed[1] = -ballSpeed[1];
                } else {
                    ball.x = newX;
                    ball.y = newY;
                }
            }

            //paddleLeft.y = Math.max(0, Math.min(paddleLeft.y + leftPaddleSpeed, battlefield.height-paddleLeft.height));
            //paddleRight.y = Math.max(0, Math.min(paddleRight.y + rightPaddleSpeed, battlefield.height-paddleRight.height));

            // auto mode
            paddleLeft.y =  Math.max(0, Math.min(ball.y - (paddleLeft.height+ball.height)/2, battlefield.height-paddleLeft.height));
            paddleRight.y = Math.max(0, Math.min(ball.y - (paddleLeft.height+ball.height)/2, battlefield.height-paddleRight.height));

        }
    }
}


