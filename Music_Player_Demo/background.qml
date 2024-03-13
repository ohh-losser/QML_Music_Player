import QtQuick
import Qt5Compat.GraphicalEffects
Rectangle {
    property bool showDefaultBackground: true
    //property alias backgroundImageSrc: backgroundImage.source

    Image {
        id: backgroundImage
        source: showDefaultBackground?"qrc:/Images/player":layoutBottomView.musicCover
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }

    ColorOverlay{
        id:backgroundImaeOverlay
        anchors.fill: backgroundImage
        source: backgroundImage
        color: "#35000000"
    }

    FastBlur{
        visible: true
        anchors.fill: backgroundImaeOverlay
        source: backgroundImaeOverlay
        radius: 80
    }
}
