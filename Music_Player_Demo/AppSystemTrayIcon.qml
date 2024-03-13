import Qt.labs.platform

SystemTrayIcon {
    id:systemTray
    visible: true
    icon.source: "qrc:/Images/music"
    onActivated: {
        appWindow.show()
        appWindow.raise()
        appWindow.requestActivate()
    }
    menu: Menu{
        id:menu
        MenuItem{
            text: "上一曲"
            onTriggered: layoutBottomView.playPrevious()
        }
        MenuItem{
            text: layoutBottomView.playingState===0?"播放":"暂停"
            onTriggered: layoutBottomView.playOrPause()
        }
        MenuItem{
            text: "下一曲"
            onTriggered: layoutBottomView.playNext()
        }
        MenuSeparator{}
        MenuItem{
            text: "显示"
            onTriggered: appWindow.show()
        }
        MenuItem{
            text: "退出"
            onTriggered: Qt.quit()
        }
    }
}
