import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.platform//FileDialog
import Qt.labs.settings//Settings


ColumnLayout {
    Layout.fillWidth: true
    anchors.fill: parent
    Rectangle {
        width: parent.width
        height: 50
        color: "#00000000"
        //color: "black"
        Text {
            x:10
            y:0
            verticalAlignment: Text.AlignTop
            horizontalAlignment: Text.AlignLeft
            text:qsTr("历史记录")
            font.family:appWindow.vFONT_YAHEI
            font.pointSize: 25
        }
    }




    RowLayout{
        height:80

        Item{
            width: 5
        }

        MusicTextButton{
            btnText: "刷新记录"
            btnHeight: 50
            btnWidth: 120
            onClicked: {
                getHistory()
            }
        }
        MusicTextButton{
            btnText: "清空记录"
            btnHeight: 50
            btnWidth: 120
            onClicked: {
                clearHistory()
            }
        }
    }

    MusicListView{
        id:historyListView

    }

    Component.onCompleted: {
        getHistory()

    }

    function getHistory(){
        console.log("getHistory()")
        historyListView.musicList = historySettings.value("history",[])
    }

    function clearHistory(){
        historySettings.setValue("history",[])
        getHistory()
    }
}
