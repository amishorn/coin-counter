#ifndef CCOUNTER_H
#define CCOUNTER_H

#include <QAbstractItemModel>
#include <QDateTime>
#include <QStandardPaths>


class CCounter : public QObject
{
    Q_OBJECT
//    Q_PROPERTY(QString imgURI READ imgURI)

public:
    CCounter(QObject *parent = 0);

//    QString imgURI();
//    Q_INVOKABLE QString getNewImgURI();
    Q_INVOKABLE void findCircles(QString imgPath);
    Q_INVOKABLE void deleteImg(QString imgPath);

private:
//    QString _imgURI;

signals:
    void imgProcessed();

public slots:
};

#endif // CCOUNTER_H
