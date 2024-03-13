import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQml 2.12

Frame {
    property int currentInt: 0
    property alias bannerList: bannerPathView.model

    leftPadding: 10
    rightPadding: 10

    background: Rectangle {
        color: "#00000000"
    }

    PathView{
        id:bannerPathView
        width: parent.width
        height: parent.height

        clip: true

        delegate: Item {
            id: bannerDelegateItem
            width: bannerPathView.width*0.7
            height: bannerPathView.height
            z:PathView.z?PathView.z:0
            scale:PathView.scale?PathView.scale:1.0

            MusicRoundImage{
                id:pathImage
                roundImageSrc:modelData.imageUrl
                width: bannerDelegateItem.width
                height: bannerDelegateItem.height
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    if(bannerView.currentInt === index) {
                        var item = bannerPathView.model[index]
                        var targetId = item.targetId
                        var targetType = item.targetType//1.单曲，10:专辑，1000:歌单
                        //console.log(targetId, targetType)
                        switch(targetType) {
                        case 1:
                            layoutBottomView.current = -1
                            layoutBottomView.playList=
                                    [
                                        {id:targetId,name:"",artist:"",cover:"",album:""}
                                    ]
                            layoutBottomView.current = 0
                            break
                        case 10:{
                            //console.log(targetId, targetType)
                            pageHomeView.showPlayList(targetId,targetType)
                            break;
                        }

                        case 1000:{
                            //console.log(targetId, targetType)
                            pageHomeView.showPlayList(targetId,targetType)
                            break;
                        }
                        }
                    } else {
                        bannerView.currentInt = index
                    }
                }
            }
        }

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onEntered: {
                bannerTimer.stop()
            }
            onExited: {
                bannerTimer.start()
            }
        }

        pathItemCount: 3
        path:bannerPath
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
    }

    Path{
        id:bannerPath
        startX:0
        startY:bannerPathView.height/2 - 10

        PathAttribute{name:"z";value:0}
        PathAttribute{name:"scale";value:0.6}

        PathLine{
            x:bannerPathView.width/2
            y:bannerPathView.height/2 - 10
        }

        PathAttribute{name:"z";value:2}
        PathAttribute{name:"scale";value:0.85}


        PathLine{
            x:bannerPathView.width
            y:bannerPathView.height/2 - 10
        }

        PathAttribute{name:"z";value:0}
        PathAttribute{name:"scale";value:0.6}
    }

    PageIndicator{
            id:indicator
            anchors{
                top:bannerPathView.bottom
                horizontalCenter: parent.horizontalCenter
                topMargin: -10
            }
            count: bannerPathView.count
            currentIndex: bannerPathView.currentIndex
            spacing: 10
            delegate: Rectangle{
                width: 20
                height: 5
                radius: 5
                color: index===bannerPathView.currentIndex?"white":"#55ffffff"
                Behavior on color{
                    ColorAnimation {
                        duration: 200
                    }
                }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: {
                        bannerTimer.stop()
                        bannerPathView.currentIndex = index
                    }
                    onExited: {
                        bannerTimer.start()
                    }
                }
            }
        }

        Timer{
            id:bannerTimer
            running: true
            repeat: true
            interval: 3000
            onTriggered: {
                if(bannerPathView.count>0)
                    bannerPathView.currentIndex=(bannerPathView.currentIndex+1)%bannerPathView.count
            }
        }

    //model[] modelDate.src


    //第一种实现方式
/*
    MouseArea{
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onEntered: {
            bannerTimer.stop()
        }
        onExited: {
            bannerTimer.start()
        }
    }

    MusicRoundImage{
        id:leftImage
        width:parent.width*0.6
        height:parent.height*0.8
        anchors{
            left:parent.left
            bottom:parent.bottom
            bottomMargin: 20
        }

        roundImageSrc:getRoundImageSrc(1)

        onRoundImageSrcChanged: {
            leftImageAnim.start()
        }

        NumberAnimation {
            id:leftImageAnim
            target: leftImage
            property: "scale"
            from: 0.8
            to:1.0
            duration: 200
        }

        MouseArea{
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if(bannerList.length > 0) {
                    currentInt = currentInt==0?bannerList.length-1:currentInt-1
                }
            }
        }
    }
    MusicRoundImage{
        id:centerImage
        width:parent.width*0.6
        height:parent.height
        anchors.centerIn: parent
        roundImageSrc:getRoundImageSrc(2)
        z:2

        onRoundImageSrcChanged: {
            centerImageAnim.start()
        }

        NumberAnimation {
            id:centerImageAnim
            target: centerImage
            property: "scale"
            from: 0.8
            to:1.0
            duration: 200
        }

        MouseArea{
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
        }

    }

    MusicRoundImage{
        id:rightImage
        width:parent.width*0.6
        height:parent.height*0.8
        anchors{
            right:parent.right
            bottom:parent.bottom
            bottomMargin: 20
        }

        roundImageSrc:getRoundImageSrc(3)

        onRoundImageSrcChanged: {
            rightImageAnim.start()
        }

        NumberAnimation {
            id:rightImageAnim
            target: rightImage
            property: "scale"
            from: 0.8
            to:1.0
            duration: 200
        }

        MouseArea{
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if(bannerList.length > 0) {
                    currentInt = currentInt==bannerList.length-1?0:currentInt+1
                }
            }
        }
    }

    PageIndicator {
        anchors{
            top:centerImage.bottom
            horizontalCenter: parent.horizontalCenter
        }
        count: bannerList.length
        interactive: true
        onCurrentIndexChanged: {
            currentInt = currentIndex
        }

        delegate: Rectangle{
            width:20
            height: 5
            radius: 5
            color: currentInt===index?"black":"gray"
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onEntered: {
                    bannerTimer.stop()
                    currentInt = index
                }
                onExited: {
                    bannerTimer.start()
                }
            }
        }
    }

    Timer {
        id:bannerTimer
        running: true
        interval: 3000
        repeat: true
        onTriggered: {
            if(bannerList.length > 0) {
                currentInt = currentInt==bannerList.length-1?0:currentInt+1
            }
        }
    }

    function getRoundImageSrc(x) {

        if(x === 1) {
            return bannerList.length?bannerList[(currentInt-1+bannerList.length)%bannerList.length].imageUrl:""
        }else if (x === 2) {
            return bannerList.length?bannerList[currentInt].imageUrl:""
        }else if (x === 3) {
            return bannerList.length?bannerList[(currentInt+1+bannerList.length)%bannerList.length].imageUrl:""
        }
    }
*/
}
