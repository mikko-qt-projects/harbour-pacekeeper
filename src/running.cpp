#include "running.h"
#include <QtMath>

Running::Running(QObject *parent) : QObject(parent)
{
    timer = new QTimer(this);
    readytimer = new QTimer(this);

    playlist = new QMediaPlaylist;
    player = new QMediaPlayer;

    m_isAccuracy = false;
    m_isRunning = false;

    m_distance = 0;
    freq = 1;
    sec = 0;
    readysec = 6;

    lengthinmeters = settings.length();
    speedinsec = settings.speed();
    freqinmeters = settings.freq();

    pacesec = (freqinmeters / 1000) * speedinsec; //for ex. (200m / 1000) * 300s = 60s


    connect(timer, SIGNAL(timeout()),
          this, SLOT(timeOut()));

    connect(readytimer, SIGNAL(timeout()),
          this, SLOT(readyTimeOut()));

    m_source = QGeoPositionInfoSource::createDefaultSource(0);
    if (m_source) {
        m_source->setUpdateInterval(1000);
        connect(m_source, SIGNAL(positionUpdated(QGeoPositionInfo)),
                this, SLOT(positionUpdated(QGeoPositionInfo)));
        m_source->startUpdates();
    }
}

void Running::positionUpdated(const QGeoPositionInfo &updatePos)
{
    if (m_isAccuracy) {
        if (m_isRunning) {
            m_points.append(updatePos);
            if (m_points.size() > 1) {
                m_distance += m_points.at(m_points.size()-2).coordinate().distanceTo(m_points.at(m_points.size()-1).coordinate());
                calcDistance(m_distance);
            }
        }

    } else {
       if (updatePos.hasAttribute(QGeoPositionInfo::HorizontalAccuracy) &&
               (updatePos.attribute(QGeoPositionInfo::HorizontalAccuracy) <= 15)) {
           m_isAccuracy = true;
           emit isAccuracyChanged();
       }
    }
}

void Running::timeOut()
{
    sec++;
}

void Running::readyTimeOut()
{
    readysec--;
    if (readysec == 1) {
        playlist->clear();
        playlist->addMedia(QUrl("qrc:/sounds/go.mp3"));
        player->setPlaylist(playlist);
        player->play();
    }

    if (readysec == 0) {
        goRunning();
    }
}

void Running::startRunning()
{
    readytimer->start(1000);
    playlist->clear();
    playlist->addMedia(QUrl("qrc:/sounds/ready.mp3"));
    playlist->addMedia(QUrl("qrc:/sounds/5.mp3"));
    playlist->addMedia(QUrl("qrc:/sounds/seconds.mp3"));
    player->setPlaylist(playlist);
    player->play();
}

void Running::stopRunning()
{
    m_isRunning = false;
    emit isRunningChanged();
    timer->stop();
    sec = 0;
    m_points.clear();
}

void Running::goRunning()
{
    m_isRunning = true;
    emit isRunningChanged();
    timer->start(1000);
    readytimer->stop();
    readysec = 6;
}

void Running::calcDistance(qreal dist)
{
    if (dist >= freq * freqinmeters) {
        playlist->clear();
        int split = qFloor(sec - (pacesec * freq));
        QString splitStr = QString::number(split);
        freq++;
        if (split >= 0) {
            playlist->addMedia(QUrl("qrc:/sounds/plus.mp3"));
            for (int i = 0; i < splitStr.size(); i++) {
                QString vocnumber = splitStr.data()[i];
                playlist->addMedia(QUrl("qrc:/sounds/" + vocnumber + ".mp3"));
            }
        } else {
            playlist->addMedia(QUrl("qrc:/sounds/minus.mp3"));
            for (int i = 1; i < splitStr.size(); i++) {
                QString vocnumber = splitStr.data()[i];
                playlist->addMedia(QUrl("qrc:/sounds/" + vocnumber + ".mp3"));
            }
        }
        playlist->addMedia(QUrl("qrc:/sounds/seconds.mp3"));
    }
    if (settings.isLimited()) {
        if (dist >= lengthinmeters) {
            playlist->addMedia(QUrl("qrc:/sounds/running.mp3"));
            playlist->addMedia(QUrl("qrc:/sounds/finished.mp3"));
            stopRunning();
        }
    }

    player->setPlaylist(playlist);
    player->play();
}

bool Running::isAccuracy() const
{
    return m_isAccuracy;
}

bool Running::isRunning() const
{
    return m_isRunning;
}

void Running::setIsAccuracy(bool isAccuracy)
{
    if (m_isAccuracy == isAccuracy)
        return;

    m_isAccuracy = isAccuracy;
    emit isAccuracyChanged();
}

void Running::setIsRunning(bool isRunning)
{
    if (m_isRunning == isRunning)
        return;

    m_isRunning = isRunning;
    emit isRunningChanged();
}


