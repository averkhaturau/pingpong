import QtQuick 2.4
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

Window {
    visible: true

    width: 830
    height: 530

    MainForm {
        id: battlefield
        anchors.fill: parent
    }

    PongLogic{
        id: gameLogic
        battlefield: battlefield
        paddleLeft: battlefield.paddleLeft
        paddleRight: battlefield.paddleRight
        ball: battlefield.ball
        countL: battlefield.countLeft
        countR: battlefield.countRight
    }

    MouseArea{
        anchors.fill: parent
        onPressAndHold: settingsMenu.popup()
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked:{
            if (mouse.button == Qt.RightButton)
                settingsMenu.popup()
        }
    }

    Menu{
        id: settingsMenu
        MenuItem{
            text: "Autoplay left"
            checkable: true
            checked: gameLogic.isLeftPaddleAutoMode
            onCheckedChanged: gameLogic.isLeftPaddleAutoMode = checked
        }
        MenuItem{
            text: "Autoplay right"
            checkable: true
            checked: gameLogic.isRightPaddleAutoMode
            onCheckedChanged: gameLogic.isRightPaddleAutoMode = checked
        }
        MenuSeparator{}
        MenuItem{
            text: "Exit"
            onTriggered: Qt.quit()
        }
    }
    Connections{
        target: settingsMenu
        onAboutToShow: gameLogic.pause()
        onAboutToHide: gameLogic.resume()
    }
}
