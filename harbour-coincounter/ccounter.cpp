#include "ccounter.h"
#include <QDir>
#include <QImage>
#include <opencv2/opencv.hpp>
#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>

#define M_PI 3.14159265358979323846
#define MIN_AREA 100.00     // needs to be high enough to get rid of things that aren't coins
#define MAX_TOL 100.00      // max tolerance between estimated and actual ellipse area

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
    cv::Mat img = cv::imread(imgPath.toLocal8Bit().constData(), CV_LOAD_IMAGE_GRAYSCALE);
    cv::Mat editImg = img;
    std::vector<cv::Vec4i> hirarchy;
    std::vector<std::vector<cv::Point> > contour;
    cv::threshold(editImg, editImg, 1, 255, cv::THRESH_OTSU);

    // Ensure that foreground (coins) is white and background is black
    cv::bitwise_xor(editImg, cv::Scalar(255,0,0,0), editImg);
    cv::dilate(editImg, editImg, NULL, cv::Point(-1,-1), 2);

    cv::findContours(editImg, contour, hirarchy, CV_RETR_CCOMP, CV_CHAIN_APPROX_SIMPLE, cv::Point(0,0));

    for(std::vector<std::vector<cv::Point> >::iterator it = contour.begin(); it != contour.end(); ++it)
    {
        double act_area = fabs(cv::contourArea(contour));
        if(act_area < MIN_AREA)
            continue;

        cv::Rect rect = ((CvContour*)&(*it))->rect;
        int A = rect.width / 2;
        int B = rect.height / 2;
        double est_area = M_PI * A * B;
        double error = fabs(act_area - est_area);
        if (error > MAX_TOL)
            continue;

        cv::Scalar color(255, 255, 255);
        cv::drawContours(editImg, contour, -1, color, cv::FILLED);
    }

    // save image with found circles
    cv::imwrite(imgPath.toLocal8Bit().constData(), editImg);

    emit imgProcessed();
}

