//MusicBorderImage.qml

import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Rectangle {
    property string broderImageSrc: "qrc:/Images/player"
    property int borderRadius: 5
    property bool isRotating: false
    property real rotationAngel: 0.0

    radius:borderRadius

    gradient: Gradient{
        GradientStop{
            position: 0.0
            color: "#101010"
        }
        GradientStop{
            position: 0.5
            color: "#a0a0a0"
        }
        GradientStop{
            position: 1.0
            color: "#505050"
        }
    }

    Image{
        id:image
        anchors.centerIn: parent
        source:broderImageSrc
        smooth: true
        visible: false
        width: parent.width*0.9
        height: parent.height*0.9
        fillMode: Image.PreserveAspectCrop
        antialiasing: true
    }

    Rectangle{
        id:mask
        color: "black"
        anchors.fill: parent
        radius: borderRadius
        visible: false
        smooth: true
        antialiasing: true
    }

    OpacityMask{
        id:maskImage
        anchors.fill:image
        source: image
        maskSource: mask
        visible: true
        antialiasing: true
    }

    NumberAnimation{
        running: isRotating
        loops: Animation.Infinite
        target: maskImage
        from:rotationAngel
        to:360+rotationAngel
        property: "rotation"
        duration: 100000
        onStopped: {
            rotationAngel = maskImage.rotation
        }
    }
}


