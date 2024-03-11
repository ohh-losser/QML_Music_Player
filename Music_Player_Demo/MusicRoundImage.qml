import QtQuick
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects

Item {

    property string roundImageSrc: "qrc:/Images/player"
    property int borderRadius: 5
    property bool getbool: true

    Image {
        id: roundImage
        anchors.centerIn: parent
        source: roundImageSrc
        smooth: true
        visible: false
        width:parent.width
        height:parent.height
        fillMode: Image.PreserveAspectCrop
        antialiasing: true
        asynchronous: true
        onStatusChanged: {
            if (roundImage.status === Image.Error) getbool=false
        }

    }

    Rectangle{
        id:mask
        color:"black"
        anchors.fill: parent
        radius: borderRadius
        visible: false
        smooth:true
        antialiasing:true
    }

    OpacityMask{
        anchors.fill:roundImage
        source:roundImage
        maskSource:mask
        visible:true
        antialiasing:true
    }
}
