import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import MyHttpModul
import MySetting
import QtMultimedia
import Qt.labs.settings 1.1

ApplicationWindow {

    id:appWindow

    property int vWINDOW_WIDTH: 1200
    property int vWINDOW_HEIGHT: 800

    property string vFONT_YAHEI:"Microsoft YaHei"

    width: vWINDOW_WIDTH
    height: vWINDOW_HEIGHT
    visible: true
    title: qsTr("Music_Player_Demo")

    background: Background {
        id:appBackground
    }

    flags: Qt.Windown|Qt.FramelessWindowHint

    HttpModul {
        id:recommendHttp
    }

    MySetting{
        id:historySettings
        filename:"conf/history.ini"
    }

    MySetting{
        id:favoriteSettings
        filename:"conf/favorite.ini"
    }

    Settings {
        id:settings
        fileName:"conf/setting.ini"
    }



    //从上到下
    ColumnLayout {

        anchors.fill: parent
        spacing: 0
        LayoutHeaderView{
            id:layoutHeaderView
        }

        PageHomeView{
            id:pageHomeView
            //visible: false
        }

        PageDetailView{
            id:pageDetailView
            visible: false
        }

        LayoutBottomView{
            id:layoutBottomView
        }
    }

    MediaPlayer{
        id:mediaPlayer
        audioOutput: AudioOutput{}

        property var times: []

        onPositionChanged: function(position){
            layoutBottomView.setSlider(0, duration, position)
            if(times.length>0){
                            var count = times.filter(time=>time<position).length
                            pageDetailView.current  = (count===0)?0:count-1
                        }
        }

        onPlaybackStateChanged: function(palybackState) {

            layoutBottomView.playingState = palybackState===MediaPlayer.PlayingState? 1:0

            if(playbackState === MediaPlayer.StoppedState&&layoutBottomView.playbackStateChangeCallbackEnable) {
                layoutBottomView.playNext()
            }
        }
    }

    AppSystemTrayIcon{

    }
}
