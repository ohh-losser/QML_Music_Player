import QtQuick
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0 //screen

ToolBar{

    property point point: Qt.point(x, y)
    property bool isSmallWindow: false

    background:Rectangle {
        //透明
        color: "#00000000"
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
                pageHomeView.visible = false
                pageDetailView.visible = true
                isSmallWindow = true
                appBackground.showDefaultBackground = pageHomeView.visible
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
                isSmallWindow = false
                appBackground.showDefaultBackground = pageHomeView.visible
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

            MouseArea{
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton
                onPressed:  setPoint(mouseX,mouseY)
                onMouseXChanged: moveX(mouseX)
                onMouseYChanged: moveY(mouseY)
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

    function setPoint(mouseX =0 ,mouseY = 0){
        point =Qt.point(mouseX,mouseY)//记录初始点
        console.log(mouseX,mouseY)
    }

    function moveX(mouseX = 0 ){
        var x = appWindow.x + mouseX-point.x//窗口x + 鼠标到窗口内的x - 记录的初始点x
        if(x<-(appWindow.width-70)) x = - (appWindow.width-70)//防止越界
        if(x>Screen.desktopAvailableWidth-70) x = Screen.desktopAvailableWidth-70
        appWindow.x = x
    }
    function moveY(mouseY = 0 ){
        var y = appWindow.y + mouseY-point.y
        if(y<=0) y = 0
        if(y>Screen.desktopAvailableHeight-70) y = Screen.desktopAvailableHeight-70
        appWindow.y = y
    }

}

