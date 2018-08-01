#ifndef DDQMLOBEJCT_H
#define DDQMLOBEJCT_H

#include <QObject>

class DDQmlObejct : public QObject
{
    Q_OBJECT
public:
    explicit DDQmlObejct(QObject *parent = nullptr);
    Q_INVOKABLE QString getFileContents(const QString  &filepath);
signals:

    void signalSendToQml(const QString &message);
public slots:
    void slotShowMessage(const QString &message);
};

#endif // DDQMLOBEJCT_H
