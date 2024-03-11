import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Button{
    property alias btnText: self.text


    property alias isCheckable:self.checkable
    property alias isChecked:self.checked

    property alias btnWidth: self.width
    property alias btnHeight: self.height

    id:self

    text: "Button"

    font.family: appWindow.vFONT_YAHEI
    font.pointSize: 14

    background: Rectangle{
        implicitHeight: self.height
        implicitWidth: self.width
        color: self.down||(self.checkable&&self.checked)?"#e2f0f8":"#66e9f4ff"
        radius: 3
    }
    width: 50
    height: 50
    checkable: false
    checked: false
}

