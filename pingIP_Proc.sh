#!/bin/bash

export ip_start=$1
export ip_end=$2

RED_COLOR='\E[1;31m'    #红
GREEN_COLOR='\E[1;32m'  #绿
YELOW_COLOR='\E[1;33m'  #黄
BLUE_COLOR='\E[1;34m'   #蓝
PINK='\E[1;35m'         #粉红
RES='\E[0m'

function echo_color(){
    colorType=$1
    echoContext=$2

    if [ $colorType -eq  0  ];then
        echo -e  "${GREEN_COLOR}$echoContext ${RES}"
    elif [ $colorType -eq  1  ];then
        echo -e  "${RED_COLOR}$echoContext ${RES}"
    elif [ $colorType -eq  2  ];then
        echo $echoContext
    else
        echo -e  "${BLUE_COLOR}$echoContext ${RES}"
    fi
}

function pingFunc(){
    for ((i=${1};i<=${2};i++)) 
    do
    timeStart=$(date "+ %H:%M:%S")
    ip_dst=172.16.16.${i}
    echo_color 3 "ping ${ip_dst} start on ${timeStart}"
    ping=`ping -c 1 $ip_dst|grep loss`
    pingRslt=`ping -c 1 $ip_dst|grep loss|awk '{print $6}'|awk -F "%" '{print $1}'`
    if [ $pingRslt -eq 100  ];then
        echo_color 1 "ping ${ip_dst} fail"
    else
        echo_color 0 "ping ${ip_dst} OK"
    fi
    #echo ping $ip_dst end
    done
}

timeStart_init=$(date "+%Y-%m-%d %H:%M:%S")
echo $timeStart_init

pingFunc $ip_start $ip_end

timeEnd=$(date "+%Y-%m-%d %H:%M:%S")
echo Start: $timeStart_init  End: $timeEnd

