#include "httpmodul.h"

HttpModul::HttpModul(QObject *parent)
    : QObject{parent}
{
    _manager = new QNetworkAccessManager(this);
    //建立信号和槽连接
    QObject::connect(_manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(replyFinished(QNetworkReply*)));
}

void HttpModul::getUrlRequest(QString url)
{
    QNetworkRequest request;
    request.setUrl(QUrl(_baseUrl + url));
    _manager->get(request);
}

void HttpModul::replyFinished(QNetworkReply *reply)
{
    qint64 dataSize = reply->bytesAvailable();
    qDebug() << "Data size received: " << dataSize << " bytes";
    emit replySignal(reply->readAll());
}

HttpModul::~HttpModul(){
    delete _manager;
}
