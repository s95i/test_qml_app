#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QProcess>



int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    //QProcess *proc_ovpn = new QProcess();

    QProcess *proc_ovpn = new QProcess(&app);

    //proc_ovpn->start("sh",QStringList() << "-c" << "iw dev wlan0 scan | grep \"SSID:\\|signal\"");
    proc_ovpn->start("sh",QStringList() << "-c" << "ifconfig");
    //proc_ovpn->waitForFinished();
    if(!proc_ovpn->waitForStarted()) //default wait time 30 sec
        qWarning(" cannot start process ");

    int waitTime = 60000 ; //60 sec
    if (!proc_ovpn->waitForFinished(waitTime))
        qWarning("timeout .. ");

    QString stdout = proc_ovpn->readAllStandardOutput();


    //QString testStr = "iw dev wlan0 scan | grep \"SSID:\\|signal\"";
    //qDebug() << stdout ;


    return app.exec();
}
