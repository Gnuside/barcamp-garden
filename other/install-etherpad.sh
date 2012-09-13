#!/bin/sh

set -x

DESTDIR=/usr/share

CUR_DIR=$(pwd)
ETHERPAD_URL="https://github.com/Pita/etherpad-lite.git"
ETHERPAD_DIR=${DESTDIR}/etherpad-lite



if [ $( id -u ) -ne 0 ]; then 
    echo >&2 "ERROR: must execute as root"
    exit 1
fi

if ! which node ; then
	echo >&2 "ERROR: nodejs not installed"
	exit 1
fi

apt-get install gzip git-core curl python libssl-dev pkg-config build-essential

cd "$CUR_DIR"
git clone "$ETHERPAD_URL" "$ETHERPAD_DIR"

addgroup --system etherpad-lite
adduser --system --home "$ETHERPAD_DIR" --no-create-home --ingroup etherpad-lite etherpad-lite
chown -R etherpad-lite:etherpad-lite "$ETHERPAD_DIR"

mkdir -p /var/log/etherpad-lite
chown -R etherpad-lite:etherpad-lite /var/log/etherpad-lite

mkdir -p /var/run/etherpad-lite
chown -R etherpad-lite:etherpad-lite /var/run/etherpad-lite

cd "$ETHERPAD_DIR"
# FIXME: install as user in local dir
# ./bin/installDeps.sh

install -m 0755 -o root -g root "$CUR_DIR/etherpad.init" "/etc/init.d/etherpad-lite"
update-rc.d etherpad-lite defaults

# FIXME: install as user  in local dir
# npm install zeparser
# npm install sqlite3

#FIXME: test that etherpad is installed in DESTDIR & INIT dir
exit 0
