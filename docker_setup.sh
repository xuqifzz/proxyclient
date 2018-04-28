#!/bin/bash
python get-pip.py \
&& pip install shadowsocks
\cp -f ./shadowsocks.json /etc/shadowsocks.json
rpm -i make-3.82-23.el7.x86_64.rpm
tar -zxf privoxy.tar.gz
useradd privoxy
cd privoxy-3.0.26-stable
make install
cd ..
\cp -f ./config /usr/local/etc/privoxy/config










