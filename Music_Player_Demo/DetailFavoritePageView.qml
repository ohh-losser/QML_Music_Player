import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.platform//FileDialog
import Qt.labs.settings//Settings


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
            text:qsTr("我喜欢的")
            font.family:appWindow.vFONT_YAHEI
            font.pointSize: 25
            color: "#eeffffff"
        }
    }




    RowLayout{
        height:80

        Item{
            width: 5
        }

        MusicTextButton{
            btnText: "刷新记录"
            btnHeight: 50
            btnWidth: 120
            onClicked: {
                getFavorite()
            }
        }
        MusicTextButton{
            btnText: "清空记录"
            btnHeight: 50
            btnWidth: 120
            onClicked: {
                clearFavorite()
            }
        }
    }

    MusicListView{
        id:favoriteListView
        favoritable: false
        onDeleteItem: function(index) {
            deleteFavorite(index)
        }

    }

    Component.onCompleted: {
        getFavorite()

    }

    function getFavorite(){
        console.log("getFavorite()")
        var tmp = favoriteSettings.value("favorite",[])
        if(tmp) {
            favoriteListView.musicList = tmp
        }else {
            favoriteListView.musicList = []
        }
    }

    function clearFavorite(){
        favoriteSettings.setValue("favorite",[])
        getFavorite()
    }

    function deleteFavorite(index){
        var list =favoriteSettings.value("favorite",[])
        if(list.length<index+1)return
        list.splice(index,1)
        favoriteSettings.setValue("favorite",list)
        getFavorite()
    }
}
