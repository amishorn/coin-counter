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
OCV_PATH = ocv-inst-486
}
CONFIG(release,debug|release){
OCV_PATH = ocv-inst-arm
}

INCLUDEPATH += $$OCV_PATH/include

# Note: -lbla -> libbla.a/so is standard linker behaviour
#       you're not specifying the exact file to link, you're
#       saying "resolve this name as a library please",
#       you can influence where it looks with -L
LIBS += -L$$PWD/$$OCV_PATH/lib/ -lopencv_core \
-lopencv_imgproc \
-lopencv_highgui \
-lopencv_imgcodecs \
-lopencv_videoio

lib.files += $$OCV_PATH/lib/libopencv_core.so.3.1 \
$$OCV_PATH/lib/libopencv_imgproc.so.3.1 \
$$OCV_PATH/lib/libopencv_highgui.so.3.1 \
$$OCV_PATH/lib/libopencv_imgcodecs.so.3.1 \
$$OCV_PATH/lib/libopencv_videoio.so.3.1

lib.path = /usr/share/harbour-coincounter/lib
INSTALLS += lib
