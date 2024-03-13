import QtQuick
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.3
import QtQml 2.15

import Qt5Compat.GraphicalEffects

RowLayout {

    property var qmlList: [
        {icon:"recommend-white", value:"推荐内容", qml:"DetailRecommmendPageView", menu:true},
        {icon:"cloud-white", value:"搜索音乐", qml:"DetailSearchPageView", menu:true},
        {icon:"local-white", value:"本地音乐", qml:"DetailLocalPageView", menu:true},
        {icon:"history-white", value:"播放历史", qml:"DetailHistoryPageView", menu:true},
        {icon:"favorite-big-white", value:"我喜欢的", qml:"DetailFavoritePageView", menu:true},
        {icon:"", value:"专辑歌单", qml:"DetailPlayListPageView", menu:false},//单独写一个方法展示页面
    ]

    property int debugIndex: 0

    spacing: 0

    Frame {
        Layout.rightMargin: 0
        Layout.preferredWidth:200
        Layout.fillHeight: true
        background: Rectangle {
            color: "#1000AAAA"
        }

        leftPadding: 0
        topPadding: 0

        ColumnLayout {
            Layout.rightMargin: 0
            anchors.fill: parent

            Rectangle {
                //Layout.alignment: Qt.AlignLeft
                Layout.preferredHeight: 120
                Layout.preferredWidth: 200
                color: "transparent"
                //color: "black"
                Text {
                    id: text
                    anchors.fill: parent
                    text: qsTr("QML_Music_Player")
                    font.bold: true
                    font.pixelSize: 20
                    color:"white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                Glow {
                    anchors.fill: text
                    radius:9
                    samples: 13
                    color: "#ddd"
                    source: text
                    spread: 0.5
                    opacity: 0.8
                    NumberAnimation on opacity {
                        id:an1
                        to:0.8
                        duration: 2000
                        running: true
                        onStopped: {
                            an2.start()
                        }
                    }
                    NumberAnimation on opacity {
                        id:an2
                        to:0.2
                        duration: 2000
                    }
                }
            }

/*
            Item{
                Layout.fillWidth: true
                Layout.preferredHeight: 150
                MusicRoundImage{
                    anchors.centerIn:parent
                    height: 100
                    width:100
                    borderRadius: 100
                }
            }
*/
            ListView {
                id:menuView
                height: parent.height//填充
                Layout.fillHeight: true
                Layout.fillWidth: true

                //model 控制了所有数据
                model:ListModel{
                    id:menuViewMode
                }

                //delegate 控制了每一项元素如何绘制
                delegate:menuViewDelegate
                highlight: Rectangle{
                    color:"#3073a7ab"
                }
            }
        }


        Component {
            id:menuViewDelegate
            Rectangle{
                id:mmenuViewDelegateItem
                height: 50
                width: 200

                color:"#10000000"
                RowLayout {
                    anchors.leftMargin: 50
                    anchors.fill: parent
                    anchors.centerIn: parent
                    spacing: 15
                    Image {
                        source: "qrc:/Images/" + icon
                        Layout.preferredHeight: 20
                        Layout.preferredWidth: 20
                    }
                    Text {
                        text:value
                        Layout.fillWidth: true
                        height:50
                        font.family: appWindow.vFONT_YAHEI
                        font.pointSize: 12
                        color: "#eeffffff"
                    }
                }

                MouseArea {
                    anchors.fill:parent
                    hoverEnabled: true
                    onEntered: {
                        color="#aa73a7db"
                    }
                    onExited: {
                        color="#00000000"
                    }

                    onClicked: {
                        hidePlayList()
                        //先让当前的元素隐藏起来
                        pageHomeViewRepeator.itemAt(mmenuViewDelegateItem.ListView.view.currentIndex).visible=false;
                        mmenuViewDelegateItem.ListView.view.currentIndex = index
                        var loader = pageHomeViewRepeator.itemAt(mmenuViewDelegateItem.ListView.view.currentIndex);
                        loader.visible=true
                        loader.source = qmlList[index].qml + ".qml";
                        console.log(qmlList[index].qml)
                    }
                }
            }
        }

        Component.onCompleted: {
            //添加数据项
            menuViewMode.append(qmlList.filter(item=>item.menu))
            //第一次加载组件成功的时候带入音乐推荐
            var loader = pageHomeViewRepeator.itemAt(debugIndex);
            loader.visible=true
            loader.source = qmlList[debugIndex].qml + ".qml";
            menuView.currentIndex = debugIndex
            //showPlayList()
        }
    }

    Repeater {
        id:pageHomeViewRepeator
        //过滤

        model:qmlList.length
        width:parent.width
        Loader {
            //visible: false
            Layout.fillWidth: true
            Layout.fillHeight: true
            //anchors.fill: parent
        }
    }

    function showPlayList(targetId="",targetType="10") {
        pageHomeViewRepeator.itemAt(menuView.currentIndex).visible = false
        var loader = pageHomeViewRepeator.itemAt(5)
        loader.visible = true
        loader.source = qmlList[5].qml + ".qml"
        loader.item.targetType=targetType
        loader.item.targetId=targetId
        //console.log(targetId, targetType)
    }

    function hidePlayList() {
        pageHomeViewRepeator.itemAt(menuView.currentIndex).visible = false
        var loader = pageHomeViewRepeator.itemAt(5)
        loader.visible = false
        //loader.source = qmlList[index].qml + ".qml"
    }
}


