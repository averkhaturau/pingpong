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
    property var ballSpeed: [0,0]
    property real leftPaddleSpeed: 0
    property real rightPaddleSpeed: 0

    property bool isLeftPaddleAutoMode: false
    property bool isRightPaddleAutoMode: false

    readonly property real padleSpeedRate: 11

    function startGame(){
        ball.x = battlefield.width / 2 - ball.width / 2
        ball.y = battlefield.height / 2 - ball.width / 2
        ballSpeed = [battlefield.width/100 * (-1+2*Math.round(Math.random())), battlefield.height/200 * (-1+2*Math.round(Math.random()))]
        paddleLeft.y = (battlefield.height - paddleLeft.height)/2
        paddleRight.y = (battlefield.height - paddleRight.height)/2
    }

    function updateCount() {
        countL.text = ''+count[0];
        countR.text = ''+count[1];
    }

    function resetCount() {
        count = [0,0]
        updateCount()
    }

    function isInBounds(left, x, right){
        return left <=x && x <= right;
    }

    function updateBallPosition(){
        var newX = ball.x + ballSpeed[0];
        var newY = ball.y + ballSpeed[1];
        // check colision with paddls
        if (newX <= paddleLeft.x + paddleLeft.width && isInBounds(paddleLeft.y, newY+ball.width/2, paddleLeft.y+paddleLeft.height) ||
            newX + ball.width >= paddleRight.x && isInBounds(paddleRight.y, newY+ball.width/2, paddleRight.y+paddleRight.height)   ){
            ballSpeed[0] = -ballSpeed[0] * 1.1;
            ballSpeed[1] =  ballSpeed[1] * 1.1;
        } else {
            // check field bounds
            var leftGoal = newX+ball.width >= battlefield.width;
            var rightGoal = 0 >= newX;
            if (leftGoal || rightGoal){
                ++count[leftGoal?0:1];
                updateCount()
                startGame()
            } else if(!isInBounds(0, newY, battlefield.height - ball.width)){
                ballSpeed[1] = -ballSpeed[1];
            } else {
                ball.x = newX;
                ball.y = newY;
            }
        }
    }

    function setPaddleToFieldBoundsY(y){
        return Math.max(0, Math.min(y, battlefield.height-paddleLeft.height))
    }

    function updatePaddlesPosition(){
        if (isLeftPaddleAutoMode)
            paddleLeft.y =  setPaddleToFieldBoundsY(ball.y - (paddleLeft.height-ball.height)/2);
        //else if (typeof leftTouchPoint != 'undefined' && leftTouchPoint.pressed)
        //  paddleLeft.y = setPaddleToFieldBoundsY(leftTouchPoint.y-paddleLeft.height/2);
        else
            paddleLeft.y = setPaddleToFieldBoundsY(paddleLeft.y + leftPaddleSpeed);

        if (isRightPaddleAutoMode)
            paddleRight.y = setPaddleToFieldBoundsY(ball.y - (paddleLeft.height-ball.height)/2);
        //else if (typeof rightTouchPoint != 'undefined' && rightTouchPoint.pressed)
        //    paddleLeft.y = setPaddleToFieldBoundsY(rightTouchPoint.y-paddleRight.height/2);
        else
            paddleRight.y = setPaddleToFieldBoundsY(paddleRight.y + rightPaddleSpeed);
    }

    FocusScope {
        focus: true
        Keys.onPressed: {
            switch(event.key){
            case Qt.Key_Up:     rightPaddleSpeed -= padleSpeedRate; break;
            case Qt.Key_Down:   rightPaddleSpeed += padleSpeedRate; break;
            case Qt.Key_W:      leftPaddleSpeed  -= padleSpeedRate; break;
            case Qt.Key_S:      leftPaddleSpeed  += padleSpeedRate; break;
            }
        }
        Keys.onReleased: {
            switch(event.key){
            case Qt.Key_Up:     rightPaddleSpeed += padleSpeedRate; break;
            case Qt.Key_Down:   rightPaddleSpeed -= padleSpeedRate; break;
            case Qt.Key_W:      leftPaddleSpeed  += padleSpeedRate; break;
            case Qt.Key_S:      leftPaddleSpeed  -= padleSpeedRate; break;
            case Qt.Key_Back:   event.accepted = true; console.log("Back button pressed."); Qt.quit();
            }
        }
    }
    /*
    MultiPointTouchArea {
        anchors.fill: parent
        touchPoints: [
            TouchPoint{id: leftTouchPoint},
            TouchPoint{id: rightTouchPoint}
        ]
    }
    */
    anchors.fill: parent

    Timer{
        id: timer
        interval: 20
        repeat : true;
        running : true;
        triggeredOnStart : true

        onTriggered: {
            updatePaddlesPosition()
            updateBallPosition()
        }
    }

    Timer{
        interval: 100
        repeat: false
        running: true
        triggeredOnStart: false
        onTriggered: startGame()
    }
}


