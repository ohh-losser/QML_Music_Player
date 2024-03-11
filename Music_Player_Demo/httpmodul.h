#ifndef HTTPMODUL_H
#define HTTPMODUL_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>

class HttpModul : public QObject
{
    Q_OBJECT
public:
    explicit HttpModul(QObject *parent = nullptr);
    ~HttpModul();

    Q_INVOKABLE void getUrlRequest(QString url);
    Q_INVOKABLE void replyFinished(QNetworkReply* reply);
signals:
    void replySignal(QString reply);
private:
    QNetworkAccessManager * _manager;
    QString _baseUrl="http://localhost:3000/";
};

#endif // HTTPMODUL_H
