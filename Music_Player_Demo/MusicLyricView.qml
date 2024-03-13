import QtQuick
import QtQuick.Layouts
import QtQml
Rectangle {
    id:lyricView
    Layout.preferredHeight: parent.height*0.85
    Layout.alignment: Qt.AlignHCenter

    property alias lyrics: lyricListView.model
    property alias current: lyricListView.currentIndex

    color: "#00000000"

    clip: true

    ListView{
        id:lyricListView
        anchors.fill: parent
        model:["暂无歌词","LOSER","LOSER"]
        delegate:lyricListViewDalegate
//        highlight: Rectangle{
//            color: "#2073a7db"
//        }

        highlightMoveDuration: 0
        highlightResizeDuration: 0
        currentIndex: 0
        preferredHighlightBegin: parent.height/2-50
        preferredHighlightEnd: parent.height/2
        //这意味着，当高亮项在ListView的上半部分时，它不会移动ListView，而当它在下半部分时，它会导致ListView向上推，使得高亮项回到中心
        highlightRangeMode: ListView.StrictlyEnforceRange
    }

    Component {
        id:lyricListViewDalegate
        Item {
            id: lyricDalegateItem
            width: lyricListView.width
            height: 50
            Text{
                text:modelData
                anchors.centerIn: parent
                color:index===lyricListView.currentIndex?"eeffffff":"#aaffffff"
                font.family: appWindow.vFONT_YAHEI
                font.pointSize: 12
            }
            states:State{
                when:lyricDalegateItem.ListView.isCurrentItem
                PropertyChanges {
                    target: lyricDalegateItem
                    scale:1.2
                }
            }

            MouseArea{
                anchors.fill: parent
                onClicked: lyricListView.currentIndex = index
            }
        }
    }
}
