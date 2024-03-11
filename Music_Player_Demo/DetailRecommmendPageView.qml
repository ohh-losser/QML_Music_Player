import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQml 2.12

ScrollView {
    clip:true

    ColumnLayout {
        Rectangle {
            Layout.fillWidth: true
            width: parent.width
            height: 60
            color: "#00000000"
            Text {
                x:10
                verticalAlignment: Text.AlignBottom
                text:qsTr("推荐音乐")
                font.family:appWindow.vFONT_YAHEI
                font.pointSize: 25
                color: "#eeffffff"
            }
        }

        MusicBannerView{
            id:bannerView
            Layout.preferredWidth:appWindow.width - 200
            Layout.preferredHeight:(appWindow.width-200)*0.3
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        Rectangle {
            Layout.fillWidth: true
            width: parent.width
            height: 60
            color: "#00000000"
            Text {
                x:10
                verticalAlignment: Text.AlignBottom
                text:qsTr("热门歌单")
                font.family:appWindow.vFONT_YAHEI
                font.pointSize: 25
                color: "#eeffffff"
            }
        }


        MusicGridHotView{
            id:hotView
            Layout.preferredHeight:(appWindow.width-250)*0.2*4+30*4+20
            Layout.bottomMargin: 20
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        Rectangle{
            Layout.fillWidth: true
            width: parent.width
            height: 60
            color: "#00000000"
            Text {
                x:10
                verticalAlignment: Text.AlignBottom
                text: qsTr("新歌推荐")
                font.family: appWindow.vFONT_YAHEI
                font.pointSize: 25
            }
        }

        MusicGridLatestView{
            id:latestView
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: (appWindow.width-230)*0.1*10+20
            Layout.bottomMargin: 20
        }

        Component.onCompleted: {
            getbannerList()
            //getHotList()

        }

        function getbannerList() {
            function onReplay(reply) {
                //console.log(reply)
                recommendHttp.onReplySignal.disconnect(onReplay)
                var banners = JSON.parse(reply).banners
                bannerView.bannerList= banners
                getHotList()
            }
            recommendHttp.onReplySignal.connect(onReplay)
            recommendHttp.getUrlRequest("banner")
        }

        function getHotList() {
            function onReplay(reply) {
                //console.log(reply)
                recommendHttp.onReplySignal.disconnect(onReplay)
                var list = JSON.parse(reply).playlists
                hotView.list = list
                getLatestList()
            }
            recommendHttp.onReplySignal.connect(onReplay)
            recommendHttp.getUrlRequest("top/playlist/highquality?limit=20")
        }

        function getLatestList(){

            function onReply(reply){
                recommendHttp.onReplySignal.disconnect(onReply)
                var latestList = JSON.parse(reply).data
                latestView.list =latestList.slice(0,30)
            }

            recommendHttp.onReplySignal.connect(onReply)
            recommendHttp.getUrlRequest("top/song")
        }
    }
}
