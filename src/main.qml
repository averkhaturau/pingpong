import QtQuick 2.4
import QtQuick.Window 2.2

Window {
    visible: true

    width: 830
    height: 530

    MainForm {
        id: battlefield
        anchors.fill: parent
    }

    PongLogic{
        battlefield: battlefield
        paddleLeft: battlefield.paddleLeft
        paddleRight: battlefield.paddleRight
        ball: battlefield.ball
        countL: battlefield.countLeft
        countR: battlefield.countRight
    }
}
