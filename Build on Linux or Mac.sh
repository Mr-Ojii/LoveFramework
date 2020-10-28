#!/bin/sh

if [ ! -d ./bin ]; then
mkdir bin
fi

cd src
zip -r LoveFramework.love *
mv -f LoveFramework.love ../bin/LoveFramework.love
