import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

ColumnLayout{

    Layout.fillWidth: true
    Layout.fillHeight: true
    spacing: 10

    property int offset: 0

    Rectangle{
        width: parent.width
        height: 70
        color: "#00000000"

        Text {
            x:10
            verticalAlignment: Text.AlignBottom//垂直居中
            height: parent.height-10
            text: qsTr("搜索音乐")
            font.family: appWindow.vFONT_YAHEI
            font.pointSize: 25
            color: "#ffffff"
        }
    }

    //搜索框
    RowLayout{
        Layout.fillWidth: true
        TextField{
            id:searchInput
            font.pixelSize: 16
            font.family: appWindow.vFONT_YAHEI
            selectByMouse: true //是否可以选择文本
            selectionColor: "#999999"//选中背景颜色
            placeholderText: qsTr("请输入搜索关键词")
            color: "#ffffff"
            background: Rectangle {
                radius: 4;
                color: "#00000000"
                opacity: 0.05
                implicitHeight: 40
                implicitWidth: 400
            }
            focus: true
            Keys.onPressed:function(event) {
                if(event.key===Qt.Key_Enter||event.key===Qt.Key_Return) {
                    doSearch()
                }
            }

        }
        MusicIconButton{
            iconSource: "qrc:/Images/search"
            toolTip: "搜索"
            onClicked: doSearch()
        }
    }

    MusicListView{
        id:musicListView
        Layout.topMargin: 10
        onLoadMore: function(offset, index) {
            doSearch(offset, index)
        }
    }

    function doSearch(offset = 0, currentPage = 0) {
        var keywords = searchInput.text
        if(keywords.length < 1) {
            return
        }
        function onReplay(reply) {

            recommendHttp.onReplySignal.disconnect(onReplay)
            var result = JSON.parse(reply).result
            musicListView.all = result.songCount
            musicListView.currentPage = currentPage
            musicListView.musicList = result.songs.map(item=>{
                return {
                    id:item.id,
                    name:item.name,
                    artist:item.artists[0].name,
                    album:item.album.name,
                    cover:""
                }
            })
            //console.log(musicListView.all)
        }
        recommendHttp.onReplySignal.connect(onReplay)
        recommendHttp.getUrlRequest("search?keywords="+keywords+"&offset="+offset+"&limit=60")
    }
}
