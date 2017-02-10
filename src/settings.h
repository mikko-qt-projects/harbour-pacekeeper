#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>
#include <QSettings>

class Settings : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int length READ length WRITE setLength NOTIFY lengthChanged)
    Q_PROPERTY(int speed READ speed WRITE setSpeed NOTIFY speedChanged)
    Q_PROPERTY(double freq READ freq WRITE setFreq NOTIFY freqChanged)
    Q_PROPERTY(bool isLimited READ isLimited WRITE setIsLimited NOTIFY isLimitedChanged)


public:
    explicit Settings(QObject *parent = 0);
    int length() const;
    int speed() const;
    double freq() const;    
    bool isLimited() const;

signals:
    void lengthChanged();
    void speedChanged();
    void freqChanged();   
    void isLimitedChanged();

public slots:
    void setLength(int length);
    void setSpeed(int speed);
    void setFreq(double freq);    
    void setIsLimited(bool isLimited);

private:
    QSettings *m_settings;
};

#endif // SETTINGS_H
