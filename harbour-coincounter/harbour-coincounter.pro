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

CONFIG += sailfishapp

SOURCES += src/harbour-coincounter.cpp \
    ccounter.cpp

OTHER_FILES += qml/harbour-coincounter.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-coincounter.changes.in \
    rpm/harbour-coincounter.spec \
    rpm/harbour-coincounter.yaml \
    translations/*.ts \
    harbour-coincounter.desktop \

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
    qml/pages/CoinRecPage.qml \
    qml/pages/CamPage.qml

CONFIG(debug,debug|release){
OCV_PATH = ocv-inst-i486
}
CONFIG(release,debug|release){
OCV_PATH = ocv-inst-arm
}

CONFIG += no_lflags_merge

QMAKE_LFLAGS += -Wl,-lc -Wl,-lz# -Wl,-shared

INCLUDEPATH += $$OCV_PATH/include

# Note: -lbla -> libbla.a/so is standard linker behaviour
#       you dont specify the exact file to link, but you
#       just say "resolve this name as a library please",
#       you can influence where it looks with -L
# Note2: if you link statically the core needs to be behind
#       all depending libraries
LIBS += \
-L$$PWD/$$OCV_PATH/lib \
-lopencv_videostab \
-lopencv_superres \
-lopencv_stitching \
-lopencv_video \
-lopencv_objdetect \
-lopencv_ml \
-lopencv_calib3d \
-lopencv_features2d \
-lopencv_highgui \
-lopencv_flann \
-lopencv_imgcodecs \
-lopencv_imgproc \
-llibpng \
-lopencv_core \
-lopencv_photo \
-lopencv_shape \
-lopencv_videoio \
-L$$PWD/$$OCV_PATH/share/OpenCV/3rdparty/lib \
-ltegra_hal \
-llibwebp \
-lIlmImf \
-llibjasper \
-llibjpeg \
-llibtiff


lib.files += $$OCV_PATH/lib/libopencv_core.a \
$$OCV_PATH/lib/libopencv_imgproc.a \
$$OCV_PATH/lib/libopencv_highgui.a \
$$OCV_PATH/lib/libopencv_imgcodecs.a \
$$OCV_PATH/lib/libopencv_videoio.a \
$$OCV_PATH/lib/libopencv_calib3d.a \
$$OCV_PATH/lib/libopencv_features2d.a \
$$OCV_PATH/lib/libopencv_flann.a \
$$OCV_PATH/lib/libopencv_ml.a \
$$OCV_PATH/lib/libopencv_objdetect.a \
$$OCV_PATH/lib/libopencv_photo.a \
$$OCV_PATH/lib/libopencv_shape.a \
$$OCV_PATH/lib/libopencv_stitching.a \
$$OCV_PATH/lib/libopencv_superres.a \
$$OCV_PATH/lib/libopencv_video.a \
$$OCV_PATH/lib/libopencv_videostab.a \
$$OCV_PATH/share/OpenCV/3rdparty/lib/libtegra_hal.a \
$$OCV_PATH/share/OpenCV/3rdparty/lib/liblibpng.a \
$$OCV_PATH/share/OpenCV/3rdparty/lib/liblibjpeg.a \
$$OCV_PATH/share/OpenCV/3rdparty/lib/liblibjasper.a \
$$OCV_PATH/share/OpenCV/3rdparty/lib/libIlmImf.a \
$$OCV_PATH/share/OpenCV/3rdparty/lib/liblibtiff.a \
$$OCV_PATH/share/OpenCV/3rdparty/lib/liblibwebp.a


lib.path = /usr/share/harbour-coincounter/lib
INSTALLS += lib
