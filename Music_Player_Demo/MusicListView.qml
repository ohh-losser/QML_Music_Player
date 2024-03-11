//MusicListView.qml
import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Shapes 1.15
import QtQml 2.3


Frame {

    //    id:item.id,//    name:item.name,//    artist:item.ar[0].name,//    album:item.al.name
    property var musicList: []
    property int all:0
    property int pageSize: 60
    property int currentPage: 0

    signal loadMore(int offset, int index)

    onMusicListChanged:{
        listViewModel.clear()
        listViewModel.append(musicList)
    }

    background: Rectangle{
        border.width: 0
        color: "#20f0f0f0"
        //color: "black"
    }
    Layout.fillWidth: true
    Layout.fillHeight: true
    rightPadding: 0
    leftPadding: 0

    clip:true

    ListView {
        id:listView
        anchors.fill:parent
        anchors.bottomMargin: 60
        model: ListModel{
            id:listViewModel
        }

        delegate: listViewDelegate

        ScrollBar.vertical: ScrollBar {
            anchors.right: parent.right
        }

        highlight: Rectangle {
            color:"black"
        }
        //highlightFollowsCurrentItem: false
        highlightMoveDuration: 0
        highlightResizeDuration: 0
        header:listViewHeader
    }

    Component {
        id:listViewDelegate

        Rectangle {
            id:listViewDelegateItem
            Layout.fillWidth: true
            color: "#00000000"
            height: 45
            width: listView.width

            Shape{
                anchors.fill: parent
                ShapePath{
                    id:shapepath
                    strokeWidth: 0
                    strokeColor: "black"
                    strokeStyle: ShapePath.SolidLine
                    startX:0
                    startY:45
                    PathLine{
                        x:0
                        y:45
                    }
                    PathLine{
                        x:listViewDelegateItem.width
                        y:45
                    }
                }
            }

            MouseArea {
                RowLayout {
                    width: parent.width
                    height: parent.height
                    spacing: 15
                    x:5
                    Text {
                        text: index+1+pageSize*currentPage
                        horizontalAlignment: Qt.AlignCenter
                        Layout.preferredWidth: parent.width*0.05
                        font.family: appWindow.vFONT_YAHEI
                        font.pointSize: 13
                        color: "blue"
                        elide:Qt.ElideRight
                    }

                    Text {
                        text: name
                        horizontalAlignment: Qt.AlignCenter
                        Layout.preferredWidth: parent.width*0.4
                        font.family: appWindow.vFONT_YAHEI
                        font.pointSize: 13
                        color: "blue"
                        elide:Qt.ElideRight
                    }

                    Text {
                        text: artist
                        horizontalAlignment: Qt.AlignCenter
                        Layout.preferredWidth: parent.width*0.15
                        font.family: appWindow.vFONT_YAHEI
                        font.pointSize: 13
                        color: "blue"
                        elide:Qt.ElideRight
                    }

                    Text {
                        text: album
                        horizontalAlignment: Qt.AlignCenter
                        Layout.preferredWidth: parent.width*0.15
                        font.family: appWindow.vFONT_YAHEI
                        font.pointSize: 13
                        color: "blue"
                        elide:Qt.ElideRight
                    }

                    Item {
                        Layout.preferredWidth: parent.width*0.15
                        RowLayout{
                            anchors.centerIn: parent
                            MusicIconButton {
                                iconSource: "qrc:/Images/play-list"
                                iconHeight:16
                                iconWidth: 16
                                toolTip: "播放"
                                onClicked: {
                                    layoutBottomView.current = -1
                                    layoutBottomView.playList = musicList
                                    layoutBottomView.current = index
                                }
                            }
                            MusicIconButton {
                                iconSource: "qrc:/Images/favorite"
                                iconHeight:16
                                iconWidth: 16
                                toolTip: "喜欢"
                                onClicked: {

                                }
                            }
                            MusicIconButton {
                                iconSource: "qrc:/Images/clear"
                                iconHeight:16
                                iconWidth: 16
                                toolTip: "删除"
                                onClicked: {

                                }
                            }
                        }
                    }
                }

                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: {
                    color="black"
                }
                onExited: {
                    color="#00000000"
                }
                propagateComposedEvents: true

                onClicked: {
                    listView.currentIndex = index
                    //console.log("clicked")
                }
            }


        }

    }

    Component {
        id:listViewHeader
        Rectangle {
            Layout.fillWidth: true
            color:"#00AAAA"
            height: 45
            width: listView.width
            RowLayout {
                width: parent.width
                height: parent.height
                spacing: 15
                x:5
                Text {
                    text: "序号"
                    horizontalAlignment: Qt.AlignCenter
                    Layout.preferredWidth: parent.width*0.05
                    font.family: appWindow.vFONT_YAHEI
                    font.pointSize: 13
                    color: "white"
                    elide:Qt.ElideRight
                }

                Text {
                    text: "标题"
                    horizontalAlignment: Qt.AlignLeft
                    Layout.preferredWidth: parent.width*0.4
                    font.family: appWindow.vFONT_YAHEI
                    font.pointSize: 13
                    color: "white"
                    elide:Qt.ElideRight
                }

                Text {
                    text: "歌手"
                    horizontalAlignment: Qt.AlignLeft
                    Layout.preferredWidth: parent.width*0.15
                    font.family: appWindow.vFONT_YAHEI
                    font.pointSize: 13
                    color: "white"
                    elide:Qt.ElideRight
                }

                Text {
                    text: "专辑"
                    horizontalAlignment: Qt.AlignLeft
                    Layout.preferredWidth: parent.width*0.15
                    font.family: appWindow.vFONT_YAHEI
                    font.pointSize: 13
                    color: "white"
                    elide:Qt.ElideRight
                }

                Text {
                    text: "操作"
                    horizontalAlignment: Qt.AlignCenter
                    Layout.preferredWidth: parent.width*0.15
                    font.family: appWindow.vFONT_YAHEI
                    font.pointSize: 13
                    color: "white"
                    elide:Qt.ElideRight
                }
            }
        }
    }

    Item {
        id: pageButtons
        visible: musicList.length!==0&&all!==0
        width:parent.width
        //anchors.bottomMargin: 50
        anchors.top: listView.bottom
        anchors.topMargin: 50
        ButtonGroup {
            buttons:buttons.children
        }

        RowLayout{
            id:buttons
            anchors.centerIn:parent
            Repeater{
                id:repeater
                model:all/pageSize>9?9:all/pageSize+1
                Button {
                    Text {
                        anchors.centerIn: parent
                        text:modelData + 1
                        font.family: appWindow.vFONT_YAHEI
                        font.pointSize: 14
                        color: checked?"#497563":"balck"
                    }
                    background: Rectangle{
                        implicitWidth: 30
                        implicitHeight: 30
                        color: checked ? "#e2f0f8":"#20e9f4ff"
                        radius: 3
                    }
                    checkable: true
                    checked: modelData === currentPage
                    onClicked: {
                        if(currentPage===index)return
                        currentPage = index
                        loadMore(currentPage*pageSize, index)
                    }
                }
            }
        }
    }

}
