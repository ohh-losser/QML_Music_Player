import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    Layout.fillHeight: true
    Layout.fillWidth: true

    //Layout.rightMargin: -5

    property alias lyricsList : lyricView.lyrics
    property alias current : lyricView.current
    RowLayout {
        anchors.fill: parent
        Frame{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredWidth: parent.width*0.45

            background: Rectangle{
                color: "#00000000"
            }

            Text {
                id: name
                text: layoutBottomView.musicName
                anchors{
                    bottom: artist.top
                    bottomMargin: 20
                    horizontalCenter: parent.horizontalCenter
                }
                font{
                    family:appWindow.vFONT_YAHEI
                    pointSize: 16
                }
                color: "#eeffffff"
            }

            Text {
                id: artist
                text: layoutBottomView.musicArtist
                anchors{
                    bottom: cover.top
                    bottomMargin: 50
                    topMargin: 20
                    horizontalCenter: parent.horizontalCenter
                }
                font{
                    family:appWindow.vFONT_YAHEI
                    pointSize: 14
                }
                color: "#aaffffff"
            }

            MusicBorderImage{
                id:cover
                anchors.centerIn: parent
                width: parent.width*0.6
                height: width
                borderRadius: width
                broderImageSrc:layoutBottomView.musicCover
                isRotating: layoutBottomView.playingState === 1
            }

            Text {
                id: lyric
                text: lyricView.lyrics[current]?lyricView.lyrics[lyricView.current]:"暂无歌词"
                anchors{
                    top: cover.bottom
                    //bottomMargin: 50
                    topMargin: 60
                    horizontalCenter: parent.horizontalCenter
                }
                font{
                    family:appWindow.vFONT_YAHEI
                    pointSize: 12
                }
                color: "#aaffffff"
            }
        }

        Frame {
            visible: !layoutHeaderView.isSmallWindow
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width*0.55
            background: Rectangle{
                color: "#000000AA"
            }

            MusicLyricView{
                id:lyricView
                anchors.fill: parent
            }
        }
    }
}
