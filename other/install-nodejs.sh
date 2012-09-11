#!/bin/sh

set -x

CUR_DIR=$(pwd)

NODE_URL="http://nodejs.org/dist/v0.8.8/node-v0.8.8.tar.gz"
NODE_FILE=$(basename "$NODE_URL")
NODE_DIR=$(echo $NODE_FILE |sed "s/.tar.gz//" )


if [ $( id -u ) -ne 0 ]; then 
    echo >&2 "ERROR: must execute as root"
    exit 1
fi


# install required packages
apt-get install gzip git-core curl python libssl-dev pkg-config build-essential checkinstall

# install node js if not available
apt-get remove nodejs

echo "Downloading $NODE_FILE"

cd $CUR_DIR
wget -c $NODE_URL -O $NODE_FILE
tar xavf $NODE_FILE
echo "Installing $NODE_DIR"
cd $NODE_DIR
./configure && make && make install

if [ ! -e /usr/bin/node ]; then
	echo >&2 "ERROR: nodejs not installed"
	exit 1
fi
echo >&2 "SUCCESS: nodejs installed successfully"
exit 0

