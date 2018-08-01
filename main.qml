import QtQuick 2.10
import QtQuick.Window 2.10
import QtWebEngine 1.5
import QtWebChannel 1.0
import DDuiObejct 1.0

Window {
    visible: true
    width: 740
    height: 480
    title: qsTr("测试qml中html-多多指教-QQ群:312125701")

    //需要注册一个WebChannel对象
    WebChannel{
        id:changedId
        registeredObjects:[myObject]
    }
    //主web界面
    WebEngineView {
        id:webview
        anchors.left: parent.left
        anchors.top: parent.top
        width: parent.width*2/3
        anchors.bottom: parent.bottom
        url: "qrc:/chatRecord.html"
        webChannel:changedId
    }
    Rectangle{
        anchors.right: parent.right
        anchors.top: parent.top
        width: parent.width/3
        color: Qt.rgba(Math.random(255),Math.random(255),Math.random(255),1.0)
        border.color: Qt.rgba(Math.random(255),Math.random(255),Math.random(255),1.0)
        anchors.bottom: parent.bottom
        Flickable {
             id: flick
             anchors.fill: parent
             contentWidth: parent.width
             contentHeight: messageId.paintedHeight
             clip: true
             function ensureVisible(r)
             {
                 if (contentX >= r.x)
                     contentX = r.x;
                 else if (contentX+width <= r.x+r.width)
                     contentX = r.x+r.width-width;
                 if (contentY >= r.y)
                     contentY = r.y;
                 else if (contentY+height <= r.y+r.height)
                     contentY = r.y+r.height-height;
             }
             TextEdit {
                 id: messageId
                 width: flick.width
                 anchors.fill: parent
                 anchors.margins: 20
                 font.family:"微软雅黑"
                 focus: true
                 wrapMode: TextEdit.Wrap
                 onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
             }
         }
    }

    //需要将这个对象注册到channel里面
    DDQmlObejct {
        id: myObject
        // the identifier under which this object
        // will be known on the JavaScript side
        // signals, methods and properties are
        // accessible to JavaScript code
        WebChannel.id: "DDCore" //这个id可在html中使用
        //qml中继续扩展信号
        signal someSignal(string message);
        //监听C++的信号
        onSignalSendToQml: {
            messageId.append(message);
        }
        //自定义函数
        function someMethod(message) {
            console.log(message);
            someSignal(message);
            slotShowMessage(message)
            return "someMethod:"+message;
        }
        //扩展的函数 可以定义很多函数
        function getThisFilePath(filepath){
            var d = getFileContents(filepath);
            someMethod(d);
            return d
        }
        function clearText(){
            messageId.clear();
        }

        //扩展属性
        property string hello: "world"
    }
}
