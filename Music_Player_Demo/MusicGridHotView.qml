//MusicGridHotView.qml
import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQml 2.12
Item{

    property alias list: gridRepeater.model

    Grid{
        id:gridLayout
        anchors.fill:parent
        columns: 5
        Repeater{
            id:gridRepeater
            Frame{
                padding: 5
                width: parent.width*0.2
                height: parent.width*0.2+30
                background: Rectangle{
                    id:background
                    color: "#00000000"
                }
                clip: true

                MusicRoundImage{
                    id:img
                    width: parent.width
                    height: parent.width
                    roundImageSrc: modelData.coverImgUrl
                    onGetboolChanged: {
                        roundImageSrc = modelData.creator.backgroundUrl
                        console.log("MusicGridHotView error loading img src" + modelData.coverImgUrl)
                    }

                }

                Text{
                    anchors{
                        top:img.bottom
                        horizontalCenter: parent.horizontalCenter
                    }
                    text:modelData.name
                    font.family: appWindow.vFONT_YAHEI
                    height:30
                    elide: Qt.ElideMiddle
                    color: "white"
                }


                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: {
                        background.color = "#50000000"
                    }
                    onExited: {
                        background.color = "#00000000"
                    }
                    onClicked: {
                        var item = gridRepeater.model[index]
                        pageHomeView.showPlayList(item.id,1000)
                    }
                }
            }
        }
    }
}
