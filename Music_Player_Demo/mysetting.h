#ifndef MYSETTING_H
#define MYSETTING_H

#include <QObject>
#include <QSettings>
#include <QJSValue>
class MySetting : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString filename READ readFilename WRITE setFileNmae NOTIFY filenameChanged)
public:
    explicit MySetting(QObject *parent = nullptr);
    Q_INVOKABLE void setFileNmae(QString filename);
    Q_INVOKABLE QVariant value(QString name, QVariant defaultValue);
    Q_INVOKABLE void setValue(QString name, QJSValue vec);

    QString readFilename() const { return _filename; }
signals:
    void filenameChanged();

private:
    QString _filename = "conf/local.ini";
};

#endif // MYSETTING_H
