import QtQuick
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0 //screen

ToolBar{
    background:Rectangle {
        //透明
        color: "#00AAAA"
    }

    width:parent.width
    Layout.fillWidth: true
    RowLayout {
        anchors.fill: parent

        MusicIconButton {
            icon.source: "qrc:/Images/music"
            ToolTip.text: qsTr("主页")
            ToolTip.visible: down
            onClicked: {
               Qt.openUrlExternally("www.baidu.com")
            }
        }
        MusicIconButton {
            icon.source: "qrc:/Images/about"
            ToolTip.text: qsTr("关于")
            ToolTip.visible: down
            onClicked: {
                aboutPop.open()
            }

        }

        MusicIconButton {
            id:samllWindow
            icon.source: "qrc:/Images/small-window"
            ToolTip.text: qsTr("小窗播放")
            ToolTip.visible: down

            onClicked: {
                setWindowSize(330, 660)
                samllWindow.visible=false
                exitSmallWindow.visible=true
            }
        }

        MusicIconButton {
            id:exitSmallWindow
            icon.source: "qrc:/Images/exit-small-window"
            ToolTip.text: qsTr("退出小窗播放")
            ToolTip.visible: down
            visible: false
            onClicked: {
                setWindowSize()
                samllWindow.visible=true
                exitSmallWindow.visible=false
            }
        }
        Item {
            Layout.fillWidth: true
            height:32
            Text{
                anchors.centerIn:parent
                text: qsTr("LOSER")
                font.family: appWindow.vFONT_YAHEI
                font.pointSize: 15
                color:"#ffffff"
            }
        }

        MusicIconButton {
            icon.source: "qrc:/Images/minimize-screen"
            ToolTip.text: qsTr("最小化")
            ToolTip.visible: down
            onClicked: {
                appWindow.hide()
            }
        }

        MusicIconButton {
            id:resizeWindow
            icon.source: "qrc:/Images/small-screen"
            ToolTip.text: qsTr("退出全屏")
            ToolTip.visible: down
            visible:false
            onClicked: {
                setWindowSize()
                appWindow.visibility = Window.AutomaticVisibility
                maxWindow.visible = true
                resizeWindow.visible = false
            }
        }

        MusicIconButton {
            id:maxWindow
            icon.source: "qrc:/Images/full-screen"
            ToolTip.text: qsTr("全屏")
            ToolTip.visible: down
            onClicked: {
                appWindow.visibility = Window.Maximized
                maxWindow.visible = false
                resizeWindow.visible = true
            }
        }

        MusicIconButton {
            icon.source: "qrc:/Images/power"
            ToolTip.text: qsTr("退出")
            ToolTip.visible: down
            onClicked: {
                Qt.quit()
            }
        }
    }

    Popup {
        id:aboutPop

        width:250
        height:230

        //parent: Overlay.overlay
        x:(appWindow.width - width)/ 2
        y:(appWindow.height - height)/ 2

        background: Rectangle {
            color:"#e9f4ff"
            radius: 5
            border.color: "#2273a7ab"
        }

        contentItem: ColumnLayout {
            width:parent.width
            height: parent.width
            Layout.alignment: Qt.AlignHCenter

            Image {
                Layout.preferredHeight: 60
                Layout.fillWidth:true
                fillMode: Image.PreserveAspectFit
                source: "qrc:/Images/music"
            }

            Text {
                text: qsTr("Loser")
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 18
                color: "#8573a7ab"
                font.family: appWindow.vFONT_YAHEI
                font.bold: true
            }
            Text {
                text: qsTr("这是我的Cloud Music Player")
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 16
                color: "#8573a7ab"
                font.family:  appWindow.vFONT_YAHEI
                font.bold: true
            }
            Text {
                text: qsTr("www.baidu.com")
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 16
                color: "#8573a7ab"
                font.family:  appWindow.vFONT_YAHEI
                font.bold: true
            }
        }
    }
    function setWindowSize(width = appWindow.vWINDOW_WIDTH, height = appWindow.vWINDOW_HEIGHT) {
        appWindow.width = width
        appWindow.height = height
        appWindow.x=(Screen.desktopAvailableWidth-appWindow.width)/2
        appWindow.y=(Screen.desktopAvailableHeight-appWindow.height)/2
    }

}

