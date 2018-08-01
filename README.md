# 基于QtQuick的C++,qml,Html三者的Bridge交互

![bridge](http://qtddui.b0.upaiyun.com/gitdir/bridge.png)

## 主要功能

* 自定义C++对象并注册到QML

* 可以在QML中继续扩展C++对象的属性和方法 信号等

* 将C++对象注入到WebChannel

* Html中引入C++对象

* JavaScript与C++直接交互

# 示例代码说明

```
 main.cpp:
//该实例必须直接继承自Object的 QWidget的忽略
	qmlRegisterType<DDQmlObejct>("DDuiObejct",1,0,"DDQmlObejct");

 qml:
 
 //需要将这个对象注册到channel里面
    DDQmlObejct{
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
        //扩展属性
        property string hello: "world"
    }
	===========以下为webengineview的实例和WebChannel的实例===============
    //需要注册一个WebChannel对象
    WebChannel{
        id:changedId
        registeredObjects:[myObject]//可以将多个对象注册到这里
    }
    //主web界面
    WebEngineView {
        id:webview
        anchors.left: parent.left
        anchors.top: parent.top
        width: parent.width/2
        anchors.bottom: parent.bottom
        url: "qrc:/chatRecord.html"
        webChannel:changedId//指定该对象的沟通桥梁WebChannel
    }
    
```

## 有问题反馈

在使用中有任何问题，欢迎反馈给我，可以用以下联系方式跟我交流

* 邮件(373955953@qq.com)
* QQ: 373955953
* QQ群:312125701
* github: [@寒山-居士](https://github.com/toby20130333)
* [源码于github](https://github.com/toby20130333/QtQuickExample)

## 关于作者

```
  var duoduozhijiao = {
    nickName  : "寒山-居士",
    site : "http://www.heilqt.com",
    blog : "http://blog.heilqt.com"
  }

```

