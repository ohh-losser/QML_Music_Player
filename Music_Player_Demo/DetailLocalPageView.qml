import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.platform//FileDialog
import Qt.labs.settings//Settings
import MySetting
ColumnLayout {
    Layout.fillWidth: true
    anchors.fill: parent
    Rectangle {
        width: parent.width
        height: 50
        color: "#00000000"
        //color: "black"
        Text {
            x:10
            y:0
            verticalAlignment: Text.AlignTop
            horizontalAlignment: Text.AlignLeft
            text:qsTr("本地音乐")
            font.family:appWindow.vFONT_YAHEI
            font.pointSize: 25
            color: "#eeffffff"
        }
    }


    MySetting{
        id:mySetting
        filename:"conf/local.ini"
    }

    RowLayout{
        height:80

        Item{
            width: 5
        }

        MusicTextButton{
            btnText: "添加本地音乐"
            btnHeight: 50
            btnWidth: 200
            onClicked: {
                fileDialog.open()
            }
        }
        MusicTextButton{
            btnText: "刷新记录"
            btnHeight: 50
            btnWidth: 120
            onClicked: {
                getLocal()
            }
        }
        MusicTextButton{
            btnText: "清空记录"
            btnHeight: 50
            btnWidth: 120
            onClicked: {
                saveLocal()
            }
        }
    }

    MusicListView{
        id:localListView
        onDeleteItem: deleteLocal(index)
    }

    Component.onCompleted: {
        //mySetting.setFileNmae("conf/local.ini")
        getLocal()
    }

    function getLocal(){
        var list = mySetting.value("local", []);
        console.log("list: "+list)
        if(!list)return[]
        localListView.musicList = list
        return list
    }

    function saveLocal(list=[]){
        mySetting.setValue("local",list)
        getLocal()
    }

    function deleteLocal(index){
       var list =mySetting.value("local",[])
        if(list.length<index+1)return
        list.splice(index,1)
        saveLocal(list)
    }

    FileDialog{
            id:fileDialog
            fileMode: FileDialog.OpenFiles
            nameFilters: ["MP3 Music Files(*.mp3)","FLAC MUsic Files(*.flac)"]
            folder: StandardPaths.standardLocations(StandardPaths.MusicLocation)[0]
            acceptLabel: "确定"
            rejectLabel: "取消"

            onAccepted: {
                var list = getLocal()
                console.log("list2: "+list)
                for(var index in files){
                    console.log("files: " + files)
                    var path = files[index].toString()
                    console.log("path: " + path)
                    var arr = path.split("/")
                    var fileNameArr = arr[arr.length-1].split(".")
                    //去掉后缀
                    fileNameArr.pop()
                    var fileName = fileNameArr.join(".")
                    //歌手-名称.mp3
                    var nameArr = fileName.split("-")
                    var name = "Loser"
                    var artist = "Loser"
                    if(nameArr.length>1){
                        artist = nameArr[0]
                        nameArr.shift()
                    }
                    name = nameArr.join("-")
                    if(list.filter(item=>item.id === path).length<1)
                    list.push({
                                  id:path+"",
                                  name,artist,
                                  url:path+"",
                                  album:"本地音乐",
                                  type:"1"//1表示本地音乐，0表示网络
                              })
                    localListView.musicList  = list
                    saveLocal(list)
                }
            }
        }
}
