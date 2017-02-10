#include "settings.h"

Settings::Settings(QObject *parent) : QObject(parent)
{
    m_settings = new QSettings("mikm", "pacekeeper");
}

int Settings::length() const
{
    return m_settings->value("setups/length", 6000).toInt();
}

int Settings::speed() const
{
    return m_settings->value("setups/speed", 300).toInt();
}

double Settings::freq() const
{
    return m_settings->value("setups/freq", 200).toDouble();
}

bool Settings::isLimited() const
{
    return m_settings->value("setups/limited", true).toBool();
}

void Settings::setLength(int length)
{
    m_settings->setValue("setups/length", length);
    emit lengthChanged();
}

void Settings::setSpeed(int speed)
{
    m_settings->setValue("setups/speed", speed);
    emit speedChanged();
}

void Settings::setFreq(double freq)
{
    m_settings->setValue("setups/freq", freq);
    emit freqChanged();
}

void Settings::setIsLimited(bool isLimited)
{
    m_settings->setValue("setups/limited", isLimited);
    emit isLimitedChanged();
}

