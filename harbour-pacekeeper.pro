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
TARGET = harbour-pacekeeper

CONFIG += sailfishapp

QT += positioning multimedia

SOURCES += src/harbour-pacekeeper.cpp \
    src/running.cpp \
    src/settings.cpp

OTHER_FILES += qml/harbour-pacekeeper.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/harbour-pacekeeper.changes.in \
    rpm/harbour-pacekeeper.spec \
    rpm/harbour-pacekeeper.yaml \
    translations/*.ts \
    harbour-pacekeeper.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-pacekeeper-de.ts

HEADERS += \
    src/running.h \
    src/settings.h

RESOURCES += \
    data/res.qrc

DISTFILES += \
    qml/pages/Settings.qml \
    qml/pages/About.qml

