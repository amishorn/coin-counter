#include "ccounter.h"
#include <QDir>
#include <QImage>
#include <opencv2/opencv.hpp>
#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>

CCounter::CCounter(QObject *parent) : QObject(parent) {

}

QString CCounter::imgURI() {
    return _imgURI;
}

QString CCounter::getNewImgURI() {
    QString sDTime;
    QString imgPath =  QStandardPaths::writableLocation(QStandardPaths::DataLocation);

    QDir().mkpath(imgPath);
    sDTime = QDateTime::currentDateTime().toString(Qt::ISODate);
    _imgURI = imgPath + "/CCImg_" + sDTime.replace(QChar('T'),QChar('_')).remove(QChar(':'), Qt::CaseInsensitive);
    return _imgURI;
}

void CCounter::findCircles() {
    cv::Mat img = cv::imread("hallo"); // cv::imread(_imgURI.toLocal8Bit().constData(), CV_LOAD_IMAGE_GRAYSCALE);
    //cv::imwrite(_imgURI.toLocal8Bit().constData(), img);
    emit imgProcessed();
}

