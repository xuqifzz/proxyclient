#!/bin/bash


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


sed -i "s/SS_SERVER/${SS_SERVER}/g"  /etc/shadowsocks.json
sed -i "s/34567/${SS_PORT}/g"  /etc/shadowsocks.json
sed -i "s/SS_PSW/${SS_PSW}/g"  /etc/shadowsocks.json
privoxy --user privoxy /usr/local/etc/privoxy/config
sslocal -c /etc/shadowsocks.json /dev/null 2>&1 









