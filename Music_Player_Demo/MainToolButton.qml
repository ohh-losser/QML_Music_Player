import QtQuick
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.3


ToolButton {
    property bool isCheckable: false
    property bool isChecked: false

    property string toolTip: ""

    property string iconSource: ""
    id:self

    icon.source:iconSource
    ToolTip.visible: hovered
    ToolTip.text: toolTip

    background: Rectangle{
        color: self.down||(isCheckable&&self.checked)?"#eeeeee":"#00000000"

    }

    icon.color:self.down||(isCheckable&&self.checked)?"#00000000":"#eeeeee"

    checkable: isCheckable
    checked:isChecked
}
