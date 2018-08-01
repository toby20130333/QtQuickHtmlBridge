#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QUrl>
#include "ddqmlobejct.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    qmlRegisterType<DDQmlObejct>("DDuiObejct",1,0,"DDQmlObejct");
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;
    return app.exec();
}
