#ifndef RUNNING_H
#define RUNNING_H

#include <QObject>
#include <QGeoPositionInfoSource>
#include <QTimer>
#include <QMediaPlayer>
#include <QMediaPlaylist>
#include "settings.h"

class Running : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isAccuracy READ isAccuracy WRITE setIsAccuracy NOTIFY isAccuracyChanged)
    Q_PROPERTY(bool isRunning READ isRunning WRITE setIsRunning NOTIFY isRunningChanged)


public:
    explicit Running(QObject *parent = 0);   
    Q_INVOKABLE void startRunning();
    Q_INVOKABLE void stopRunning();
    void goRunning();
    void calcDistance(qreal dist);
    bool isAccuracy() const;
    bool isRunning() const;

signals:
    void isAccuracyChanged();
    void isRunningChanged();


public slots:
    void positionUpdated(const QGeoPositionInfo &updatePos);
    void timeOut();
    void readyTimeOut();
    void setIsAccuracy(bool isAccuracy);
    void setIsRunning(bool isRunning);



private:
    QGeoPositionInfoSource *m_source;
    QList<QGeoPositionInfo> m_points;
    QTimer *timer;
    QTimer *readytimer;
    QMediaPlayer *player;
    QMediaPlaylist *playlist;
    bool m_isAccuracy;
    bool m_isRunning;
    qreal m_accuracy;
    qreal m_distance;
    int lengthinmeters;
    int speedinsec;
    double freqinmeters;
    int freq;
    int sec;
    int readysec;
    int pacesec;
    Settings settings;
};

#endif // RUNNING_H
