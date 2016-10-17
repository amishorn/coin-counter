#include "ccounter.h"
#include <QDir>
#include <QImage>
#include <opencv2/opencv.hpp>
#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>

#include <QStandardPaths>
#include <QDebug>

#define M_PI 3.14159265358979323846
#define MIN_AREA 100.00     // needs to be high enough to get rid of things that aren't coins
#define MAX_TOL  100.00      // max tolerance between estimated and actual ellipse area

CCounter::CCounter(QObject *parent) : QObject(parent) {

}

//QString CCounter::imgURI() {
//    return _imgURI;
//}

//QString CCounter::getNewImgURI() {
//    QString sDTime;
//    QString imgPath =  QStandardPaths::writableLocation(QStandardPaths::DataLocation);

//    QDir().mkpath(imgPath);
//    sDTime = QDateTime::currentDateTime().toString(Qt::ISODate);
//    _imgURI = imgPath + "/CCImg_" + sDTime.replace(QChar('T'),QChar('_')).remove(QChar(':'), Qt::CaseInsensitive);
//    return _imgURI;
//}

void CCounter::findCircles(QString imgPath) {

    // load image
//    cv::Mat cimg = cv::imread(imgPath.toLocal8Bit().constData(), CV_LOAD_IMAGE_COLOR);
    cv::Mat editImg;
    cv::Mat tM(2,2, CV_8UC3, cv::Scalar(0,0,255));
    cv::cvtColor(tM, editImg, CV_RGB2GRAY);

    std::vector<cv::Vec4i> hirarchy;
    std::vector<std::vector<cv::Point> > contour;
//    cv::threshold(editImg, editImg, 1, 255, CV_THRESH_OTSU);

    // Ensure that foreground (coins) is white and background is black
//    cv::bitwise_xor(editImg, cv::Scalar(255,0,0), editImg);
//    cv::dilate(editImg, editImg, cv::Mat(), cv::Point(-1,-1), 2);

    qDebug() << "find contours...";
//    cv::findContours(editImg, contour, hirarchy, CV_RETR_CCOMP, CV_CHAIN_APPROX_SIMPLE);

    qDebug() << "enter forloop and draw found contours";
//    for(std::vector<std::vector<cv::Point> >::iterator it = contour.begin(); it != contour.end(); it++)
//    {
//        if ((*it).size() < 6)
//            continue;

//        cv::RotatedRect rotRec = cv::fitEllipse(*it);

//        if(rotRec.size.area() < MIN_AREA)
//            continue;

//        qDebug() << "\nx: " << rotRec.center.x  << "\ty: " << rotRec.center.y;
//        qDebug() << "set color and draw contour \n";
//        cv::Scalar color(std::rand() % 255, std::rand() % 255, std::rand() % 255);
//        ellipse(cimg, rotRec, color, 2, cv::LINE_AA);
//    }

    // save image with found circles
    qDebug() << "save image with found circles";
//    cv::imwrite(imgPath.toLocal8Bit().constData(), cimg);

    emit imgProcessed();
}

void CCounter::deleteImg(QString imgPath) {
    QFile::remove(imgPath);
}
