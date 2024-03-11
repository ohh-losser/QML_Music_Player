import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

Rectangle {

    property var playList: []
    property int current: -1

    property int sliderValue: 0
    property int sliderFrom: 0
    property int sliderTo: 100

    property int currentPlayMode: 0
    property var playModeList: [
        {icon:"single-repeat",name:"单曲循环"},
        {icon:"repeat",name:"顺序播放"},
        {icon:"random",name:"随机播放"}
    ]

    property string musicName: "Loser"
    property string musicArtist: ""
    property string musicCover: "qrc:/Images/player"

    property int playingState: 0

    property  bool playbackStateChangeCallbackEnable : false

    Layout.fillWidth:true
    height:60
    color: "#00AAAA"

    RowLayout {
        anchors.fill: parent

        Item {//占位
            Layout.preferredWidth: parent.width/10
            Layout.fillWidth:true
        }

        MusicIconButton {
            icon.source: "qrc:/Images/previous"
            toolTip: qsTr("上一曲")
            iconWidth:32
            iconHeight:32

            onClicked: {
                playPrevious()
            }
        }
        MusicIconButton {
            icon.source: playingState===0?"qrc:/Images/stop":"qrc:/Images/pause"
            toolTip: qsTr("暂停/播放")
            iconWidth:32
            iconHeight:32
            onClicked: {
                if(!mediaPlayer.source)return
                if(mediaPlayer.playbackState === MediaPlayer.PlayingState){
                    mediaPlayer.pause()
//                    iconSource = "qrc:/Images/pause"
                    playingState = 0
                } else if (mediaPlayer.playbackState === MediaPlayer.PausedState) {
                    mediaPlayer.play()
//                    iconSource = "qrc:/Images/stop"
                    playingState = 1
                }else {

                }
            }

        }
        MusicIconButton {
            icon.source: "qrc:/Images/next"
            toolTip: qsTr("下一曲 ")
            iconWidth:32
            iconHeight:32
            onClicked: {
                playNext()
            }
        }

        Item {
            Layout.preferredWidth: parent.width/2
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.topMargin: 25

            Text {
                id:nameText
                anchors.left:slider.left
                anchors.bottom: slider.top
                anchors.leftMargin: 5
                text:musicName+"-"+musicArtist
                font.family: "Microsoft YaHei"
                color: "#ffffff"
            }

            Text {
                id:timeText
                anchors.right:slider.right
                anchors.bottom: slider.top
                anchors.rightMargin: 5
                text:"00:00/05:30"
                font.family: "Microsoft YaHei"
                color: "#ffffff"
            }

            Slider {
                id:slider
                width:parent.width
                Layout.fillWidth: true
                height: 25
                to:sliderTo
                from:sliderFrom
                value:sliderValue

                onMoved:{
                    //mediaPlayer.playbackState === MediaPlayer.PlayingState
                    mediaPlayer.setPosition(value)
                }

                background: Rectangle{
                    //padding代表自身边框到自身内部另一个容器边框之间的距离，属于容器内距离。
                    // x y 相对于主界面偏移
                    x:slider.leftPadding
                    y:slider.topPadding+(slider.availableHeight-height) / 2
                    height: 4
                    width: slider.availableWidth
                    radius: 2
                    color:"#e9f4ff"

                    Rectangle {
                        width: slider.visualPosition * parent.width
                        height:parent.height
                        radius: 2
                        color:"#73a7ab"
                    }
                }

                handle:Rectangle {
                    //availableWidth 此属性保存从控件宽度中减去水平填充后内容项的可用宽度。
                    //visualPosition 滑块的视觉位置。范围为 0.0 - 1.0
                    x:/*slider.leftPadding + */(slider.availableWidth-width)*slider.visualPosition
                    y:/*slider.topPadding + */(slider.availableHeight-height) / 2
                    width:15
                    height:15
                    radius:5
                    color:"#f0f0f0"
                    border.color: "#73a7ab"
                    border.width: 0.5

                    onXChanged: {
                        //console.log(slider.availableWidth);
                        //console.log(width)
                        //console.log(slider.visualPosition)
                        //console.log(x)
                        //console.log(slider.leftPadding)
                    }
                }
            }
        }

        MusicBorderImage{
            //id:musicCover
            width: 50
            height: 45
            broderImageSrc: musicCover
            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                //hoverEnabled: true

                onPressed:{
                    musicCover.scale=0.85
                }
                onReleased: {
                    musicCover.scale=1.0
                }

                onClicked: {
                    pageDetailView.visible = !pageDetailView.visible
                    pageHomeView.visible = !pageHomeView.visible
                }
            }
        }

        MusicIconButton {
            Layout.preferredWidth: 50
            icon.source: "qrc:/Images/favorite"
            toolTip: qsTr("我喜欢")
            iconWidth:32
            iconHeight:32
            onClicked: saveFavorite( playList[current])
        }

        MusicIconButton {
            id:playMode
            Layout.preferredWidth: 50
            icon.source: "qrc:/Images/"+playModeList[currentPlayMode].icon
            toolTip: playModeList[currentPlayMode].name
            iconWidth:32
            iconHeight:32
            onClicked: {
                changePlayMode()
            }
        }

        Item {
            Layout.preferredWidth: parent.width/10
            Layout.fillWidth:true
        }
    }

    Component.onCompleted: {
        //console.log("setting.value...", settings.value("currentPlayMode", 0));
        var currentPlayMode = settings.value("currentPlayMode", 0)
    }

    onCurrentChanged: {
        if(current === -1)return
        playbackStateChangeCallbackEnable = false
        playMusic(current)
    }

    function playPrevious() {
        if(playList.length<1) return
        switch(currentPlayMode){
        case 0:
        case 1:
            current = (current+1)%playList.length
            break
        case 2:{
            current = -1
            var random = parseInt(Math.random()*playList.length)
            current = current === random? random+1:random
            break
        }
    }
    }

    function playNext(type='natural') {
        if(playList.length<1) return

        switch(currentPlayMode){
        case 0:
            if(type==="natural") {
                mediaPlayer.play()
                break
            }
        case 1:
            current = (current+1)%playList.length
            break
        case 2:{
            current = -1
            var random = parseInt(Math.random()*playList.length)
            current = current === random? random+1:random
            break
        }
        }
    }

    function changePlayMode() {
        currentPlayMode = (currentPlayMode+1)%playModeList.length
        settings.setValue("currentPlayMode", currentPlayMode)
    }

    function playMusic() {
        if(current < 0)return
        if(playList.length<current+1)return
        if(playList[current].type==="1")
            playLocalMusic()
        else{
            playWebMusic()
        }

        saveHistory(current)

        //console.log("播放id...", current)
        //getUrl(current)
    }

    function playLocalMusic() {
        var currentItem = playList[current]
        mediaPlayer.source = currentItem.url
        mediaPlayer.play()
        musicName = currentItem.name
        musicArtist = currentItem.artist
    }

    //获取播放连接
    function playWebMusic() {
        if(playList.length<current+1) return
        var id = playList[current].id
        if(!id)return

        musicName = playList[current].name
        musicArtist = playList[current].artist
        function onReply(reply){
            recommendHttp.onReplySignal.disconnect(onReply)
            //console.log(reply)
            var data = JSON.parse(reply).data[0]
            var url = data.url
            if(!url)return
            var time = data.time
            setSlider(0,time,0)
            var cover = playList[current].cover
            if(!cover) {
                //请求Cover
                getCover(id)
            }else {
                musicCover = cover
            }

            mediaPlayer.source = url
            mediaPlayer.play()
            //console.log("mediaPlayer...playing")
            playbackStateChangeCallbackEnable = true
        }

        recommendHttp.onReplySignal.connect(onReply)
        //console.log("song/url?id="+id)
        recommendHttp.getUrlRequest("song/url?id="+id)

    }

    function setSlider(from=0,to=100,value=0){
        sliderFrom = from
        sliderTo = to
        sliderValue = value

        var va_mm = parseInt(value/1000/60)+""
        va_mm = va_mm.length<2?"0"+va_mm:va_mm
        var va_ss = parseInt(value/1000%60)+""
        va_ss = va_ss.length<2?"0"+va_ss:va_ss

        var to_mm = parseInt(to/1000/60)+""
        to_mm = to_mm.length<2?"0"+to_mm:to_mm
        var to_ss = parseInt(to/1000%60)+""
        to_ss = to_ss.length<2?"0"+to_ss:to_ss

        timeText.text = va_mm+":"+va_ss+"/"+to_mm+":"+to_ss
    }

    function getCover(id) {

        function onReply(reply){
            recommendHttp.onReplySignal.disconnect(onReply)
            getLyric(id)
            var song = JSON.parse(reply).songs[0]
            var cover = song.al.picUrl
            if(cover.length>=1) {
                musicCover = cover
            }
            if(musicName.length<1) {
               musicName = song.name
            }
            if(musicArtist.length<1) {
               musicArtist = song.ar[0].name
            }


        }

        recommendHttp.onReplySignal.connect(onReply)
        recommendHttp.getUrlRequest("song/detail?ids="+id)
    }

    function getLyric(id){
        function onReply(reply){
            recommendHttp.onReplySignal.disconnect(onReply)
            var lyric = JSON.parse(reply).lrc.lyric
            console.log(lyric)
            if(lyric.length<1) return
            var lyrics = (lyric.replace(/\[.*\]/gi,"")).split("\n")

            if(lyrics.length>0) pageDetailView.lyrics = lyrics

            var times = []
            lyric.replace(/\[.*\]/gi,function(match,index){
                //match : [00:00.00]
                if(match.length>2){
                    var time  = match.substr(1,match.length-2)
                    var arr = time.split(":")
                    var timeValue = arr.length>0? parseInt(arr[0])*60*1000:0//转时间戳
                    arr = arr.length>1?arr[1].split("."):[0,0]
                    timeValue += arr.length>0?parseInt(arr[0])*1000:0
                    timeValue += arr.length>1?parseInt(arr[1])*10:0

                    times.push(timeValue)
                }
            })
            mediaPlayer.times = times
        }
        recommendHttp.onReplySignal.connect(onReply)
        recommendHttp.getUrlRequest("lyric?id="+id)
    }

    function saveHistory(index = 0){
        if(playList.length<index+1) return
        var item  = playList[index]
        if(!item||!item.id)return
        var history =  historySettings.value("history",[])
        var i =  history.findIndex(value=>value.id===item.id)
        if(i>=0){
            history.slice(i,1)
        }
        history.unshift({
                            id:item.id+"",
                            name:item.name+"",
                            artist:item.artist+"",
                            url:item.url?item.url:"",
                            type:item.type?item.type:"",
                            album:item.album?item.album:"本地音乐"
                        })
        if(history.length>500){
            //限制五百条数据
            history.pop()
        }
        historySettings.setValue("history",history)
    }

    function saveFavorite(value={}){
        console.log("saveFavorite()")
        if(!value||!value.id)return
        var favorite =  favoriteSettings.value("favorite",[])
        var i =  favorite.findIndex(item=>value.id===item.id)
        if(i>=0) favorite.splice(i,1)
        favorite.unshift({
                            id:value.id+"",
                            name:value.name+"",
                            artist:value.artist+"",
                            url:value.url?value.url:"",
                            type:value.type?value.type:"",
                            album:value.album?value.album:"本地音乐"
                        })
        if(favorite.length>500){
            //限制五百条数据
            favorite.pop()
        }
        console.log("favorite= " + favorite)
        favoriteSettings.setValue("favorite",favorite)
    }
}
