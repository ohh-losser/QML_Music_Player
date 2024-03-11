#include "mysetting.h"

MySetting::MySetting(QObject *parent)
    : QObject{parent}
{

}

void MySetting::setFileNmae(QString filename)
{
    if(filename != _filename) {
        _filename = filename;
        emit filenameChanged();
        QSettings _setting(_filename, QSettings::IniFormat);
    }
    qDebug() << "setFilename() " << _filename;
}

QVariant MySetting::value(QString name, QVariant defaultValue)
{

    QSettings _setting(_filename, QSettings::IniFormat);
    auto ret = _setting.value(name, defaultValue);
    qDebug() << "value() " << name << " " << defaultValue << " " << ret;
    return ret;
}

void MySetting::setValue(QString name, QJSValue vec)
{
    qDebug() << "setValue() " << name << " " << vec.toVariant();
    QSettings _setting(_filename, QSettings::IniFormat);
    _setting.setValue(name, vec.toVariant());
}
