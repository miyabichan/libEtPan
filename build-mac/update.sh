#!/bin/sh
OPENSSL_VERSION=1.0.0d

if test ! -d libetpan.xcodeproj ; then
	exit 1;
fi

ROOTDIR=`pwd`

cd ..
./autogen.sh
make stamp-prepare-target
make libetpan-config.h
cd build-mac
mkdir -p include/libetpan
cp -r ../include/libetpan/ include/libetpan/
cp ../config.h include
cp ../libetpan-config.h include
mkdir -p OpenSSL
cd OpenSSL
curl -O http://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz
tar xzvf openssl-$OPENSSL_VERSION.tar.gz
mv openssl-$OPENSSL_VERSION/* .
rm -rf openssl-$OPENSSL_VERSION
cd ${ROOTDIR}
sed -i.original 's/^#define HAVE_CURL 1$/\/\/#define HAVE_CURL 1/' ${ROOTDIR}/include/config.h
sed -i '' 's/^\#define HAVE_EXPAT 1/\/\/\#define HAVE_EXPAT 1/g' ${ROOTDIR}/include/config.h
