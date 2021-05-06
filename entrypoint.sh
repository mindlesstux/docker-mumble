#!/bin/bash -x

FILE=/murmur/cfglog/murmur.ini
if [ ! -f $FILE ]; then
    cp -v /murmur/binary/murmur-static_x86/murmur.ini /murmur/cfglog/murmur.ini
    sed -i 's/database=/database=\/murmur\/cfglog\/murmur.sqlite/g' /murmur/cfglog/murmur.ini
    sed -i 's/;logfile=murmur.log/logfile=\/murmur\/cfglog\/murmur.log/g' /murmur/cfglog/murmur.ini
    sed -i 's/;pidfile=/pidfile=\/murmur\/cfglog\/murmur.pid/g' /murmur/cfglog/murmur.ini
fi 

cd /murmur/binary/murmur-static_x86
./murmur.x86 -fg -v -ini /murmur/cfglog/murmur.ini