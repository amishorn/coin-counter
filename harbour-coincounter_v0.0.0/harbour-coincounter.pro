# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-coincounter

CONFIG += sailfishapp \
    C++11

SOURCES += src/harbour-coincounter.cpp \
    ccounter.cpp \
    build-harbour-coincounter-MerSDK_SailfishOS_i486-Debug/moc_ccounter.cpp \
    build-harbour-coincounter-MerSDK_SailfishOS_i486-Release/moc_ccounter.cpp

OTHER_FILES += qml/harbour-coincounter.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-coincounter.changes.in \
    rpm/harbour-coincounter.spec \
    rpm/harbour-coincounter.yaml \
    translations/*.ts \
    harbour-coincounter.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-coincounter-de.ts

HEADERS += \
    ccounter.h

DISTFILES += \
    qml/pages/CamPage.qml \
    qml/pages/CoinRecPage.qml

INCLUDEPATH += ocv-inst/include

#INCLUDEPATH += $$(OPENCV_MERSDK)\ocv_include

#LIBS += $$(OPENCV_MERSDK)\x86\mingw\lib\libopencv_core310.dll \
#        $$(OPENCV_MERSDK)\x86\mingw\bin\libopencv_imgproc310.dll \
#        $$(OPENCV_MERSDK)\x86\mingw\bin\libopencv_imgcodecs310.dll \
#        $$(OPENCV_MERSDK)\x86\mingw\bin\libopencv_highgui310.dll

#LIBS += -L$$PWD/ocv-inst/lib/ -lopencv_core

#INCLUDEPATH += $$PWD/ocv-inst/include

#CONFIG(release,debug|release){}
#lib.path = ocv-inst/lib
#lib.files += libopencv_calib3d.so \
#        libopencv_core.so \
#        libopencv_features2d.so \
#        libopencv_flann.so \
#        libopencv_highgui.so \
#        libopencv_imgcodecs.so \
#        libopencv_imgproc.so \
#        libopencv_ml.so \
#        libopencv_objdetect.so \
#        libopencv_photo.so \
#        libopencv_shape.so \
#        libopencv_stitching.so \
#        libopencv_superres.so \
#        libopencv_video.so \
#        libopencv_videoio.so \
#        libopencv_videostab.so
#
#INSTALLS += lib
