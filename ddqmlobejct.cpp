#include "ddqmlobejct.h"
#include <QFile>
#include <QDebug>

DDQmlObejct::DDQmlObejct(QObject *parent) : QObject(parent)
{

}

QString DDQmlObejct::getFileContents(const QString &filepath)
{
    if(filepath.isEmpty())return "filepath is empty";
    if(!QFile::exists(filepath))return "filepath is not exists";
    QFile file(filepath);
    QString dt;
    if(file.open(QIODevice::ReadOnly)){
        dt = file.readAll();
    }
    file.close();
    return dt;
}

void DDQmlObejct::slotShowMessage(const QString &message)
{
    qDebug()<<Q_FUNC_INFO<<message.size();
    emit signalSendToQml(message);
}
