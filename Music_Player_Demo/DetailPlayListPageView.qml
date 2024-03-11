import QtQuick
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.3

ColumnLayout {

    property string targetId : ""
    property string targetType : "10"//album, playList/detail
    property string name : "-"
    onTargetIdChanged: {
        if(targetType=="10")loadAlbum()
        else if (targetType=="1000")loadPlayList()
    }

    Rectangle {
        Layout.fillWidth: true
        width: parent.width
        height: 60
        color: "#00000000"
        //color: "black"
        Text {
            x:10
            verticalAlignment: Text.AlignBottom
            text:qsTr(targetType=="10"?"专辑":"歌单")+name
            font.family:appWindow.vFONT_YAHEI
            font.pointSize: 25
        }
    }
    RowLayout{
        height:200
        width:parent
        MusicRoundImage{
            id:playListCover
            width:180
            height:180
            Layout.leftMargin: 10
            //roundImageSrc:"https://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg"
        }

        Item{
            Layout.fillWidth: true
            height:parent.height
            //text占位不太好
            Text{
                id:playListDesc
                width:parent.width*0.95
                anchors.centerIn: parent
                wrapMode: Text.WrapAnywhere
                font.family:appWindow.vFONT_YAHEI
                font.pointSize: 14
                maximumLineCount: 4
                elide: Text.ElideRight
                lineHeight: 1.5
                //text: "https://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpghttps://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpghttps://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg"
            }
        }
    }

    MusicListView {
        id:palyListview
        //deletable: false
    }

    function loadAlbum(){

        var url = "album?id="+(targetId.length<1?"32311":targetId)
        //console.log(url)
        function onReply(reply){
            recommendHttp.onReplySignal.disconnect(onReply)

            try{
                var album = JSON.parse(reply).album
                var songs = JSON.parse(reply).songs
                playListCover.roundImageSrc = album.blurPicUrl
                playListDesc.text = album.description
                name = "-"+album.name
                //console.log(reply)
                palyListview.musicList= songs.map(item=>{
                                                          return {
                                                              id:item.id,
                                                              name:item.name,
                                                              artist:item.ar[0].name,
                                                              album:item.al.name,
                                                              cover:""
                                                          }
                                                      })
            }catch(err) {
                console.log("获取专辑错误")
            }
        }
        recommendHttp.onReplySignal.connect(onReply)
        recommendHttp.getUrlRequest(url)
    }

    function loadPlayList(){

        var url = "playlist/detail?id="+(targetId.length<1?"32311":targetId)


        function onSongDetailReply(reply){
            recommendHttp.onReplySignal.disconnect(onSongDetailReply)

            var songs = JSON.parse(reply).songs
            //console.log(reply)
            palyListview.musicList= songs.map(item=>{
                                                      return {
                                                          id:item.id,
                                                          name:item.name,
                                                          artist:item.ar[0].name,
                                                          album:item.al.name,
                                                          cover:item.al.picUrl,
                                                      }
                                                  })
        }

        function onReply(reply){
            recommendHttp.onReplySignal.disconnect(onReply)
            var playlist = JSON.parse(reply).playlist
            playListCover.roundImageSrc = playlist.coverImgUrl
            playListDesc.text = playlist.description
            name = "-"+playlist.name
            var ids = playlist.trackIds.map(item=>item.id).join(",")
            //console.log(ids)
            recommendHttp.onReplySignal.connect(onSongDetailReply)
            recommendHttp.getUrlRequest("song/detail?ids="+ids)

        }
        recommendHttp.onReplySignal.connect(onReply)
        recommendHttp.getUrlRequest(url)
    }
}
