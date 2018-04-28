#!/bin/bash
#外部参数
#docker run -it -v /root/proxy:/proxy --env SS_SERVER=xx --env SS_PORT=xx --env SS_PSW=xx centos /bin/bash


#内部参数
export SS_LOCAL_PORT=1080

declare -a envCheckList
envCheckList=(SS_LOCAL_PORT SS_SERVER SS_PORT SS_PSW)
for ((i=0;i<${#envCheckList[@]};i++)); do
    t1=${envCheckList[i]}
    t2=${!t1}
    if [ -z $t2 ]
    then
        echo error:没有配置环境变量${t1}的值
        exit 1
    fi
done


#yum install -y pip
python get-pip.py \
&& pip install shadowsocks
if [ $? -ne 0 ];then
    echo error:安装shadowsocks失败
    exit 1
fi
\cp -f ./shadowsocks.json /etc/shadowsocks.json
sed -i "s/SS_SERVER/${SS_SERVER}/g"  /etc/shadowsocks.json
sed -i "s/34567/${SS_PORT}/g"  /etc/shadowsocks.json
sed -i "s/SS_PSW/${SS_PSW}/g"  /etc/shadowsocks.json

nohup sslocal -c /etc/shadowsocks.json /dev/null 2>&1 &
sleep 5
curl --socks5 127.0.0.1:$SS_LOCAL_PORT http://httpbin.org/ip

if [ $? -ne 0 ];then
    echo error:代理访问失败
    exit 1
fi
rpm -i make-3.82-23.el7.x86_64.rpm

tar -zxf privoxy.tar.gz
useradd privoxy
cd privoxy-3.0.26-stable
make install
cd ..
\cp -f ./config /usr/local/etc/privoxy/config
privoxy --user privoxy /usr/local/etc/privoxy/config
export http_proxy=http://127.0.0.1:8118
sleep 5
curl  http://httpbin.org/ip









