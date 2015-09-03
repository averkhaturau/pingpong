TEMPLATE = app

CONFIG += c++11

QT += qml quick

SOURCES += main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

win32:RC_ICONS += "../assets/images/logo.ico"
VERSION = "0.0.0.0"
QMAKE_TARGET_COMPANY="Aliaksei Verkhaturau"
QMAKE_TARGET_DESCRIPTION="Clasical PingPong game rewtitter on QML"
QMAKE_TARGET_COPYRIGHT="Copyright 2015 (C) Aliaksei Verkhaturau"
QMAKE_TARGET_PRODUCT="PingPong"
