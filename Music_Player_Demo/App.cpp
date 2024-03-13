#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include <QImageReader>

#include "httpmodul.h"
#include "mysetting.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<HttpModul>("MyHttpModul",1,0,"HttpModul");
    qmlRegisterType<MySetting>("MySetting",1,0,"MySetting");
    QImageReader::setAllocationLimit(250);
    app.setWindowIcon(QIcon(":/Images/music.png"));

//    QJSValue jsvalue;
//    QJSEngine engine_;
//    engine_.globalObject().setProperty("vjson",engine_.newQObject(QJSValue));

    QCoreApplication::setAttribute(Qt::AA_UseSoftwareOpenGL);
    QCoreApplication::setAttribute(Qt::AA_UseOpenGLES);

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/Music_Player_Demo/App.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
