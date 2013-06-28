#!/bin/bash
#By zhiguo
#Create:2011-1103
#Modify:2013-0617

# get network interface rates 

function usage
{

        echo "Usage: $0  "

        echo "     $0  interface interval  count \n"
        echo "    e.g. $0 eth0 1 10 \n"
     

        exit 65

}


if [ $# -lt 3 ];then
usage
fi
typeset in in_old dif_in
typeset out out_old dif_out
typeset timer
typeset eth

eth=$1
timer=$2
inv=$3

in_old=$(cat /proc/net/dev | grep $eth | sed -e "s/\(.*\)\:\(.*\)/\2/g" | awk ' { print $1 }' )
out_old=$(cat /proc/net/dev | grep $eth | sed -e "s/\(.*\)\:\(.*\)/\2/g" | awk ' { print $9 }' )

for i in $(seq $inv)
do 
    while true
    do
    sleep ${timer}
    in=$(cat /proc/net/dev | grep $eth | sed -e "s/\(.*\)\:\(.*\)/\2/g" | awk ' { print $1 }' )
    out=$(cat /proc/net/dev | grep $eth | sed -e "s/\(.*\)\:\(.*\)/\2/g" | awk ' { print $9 }' )
    dif_in=$(((in-in_old)/timer))
    dif_out=$(((out-out_old)/timer))
    echo "IN: ${dif_in} Byte/s OUT: ${dif_out} Byte/s"
    in_old=${in}
    out_old=${out}
    break
    done
done
exit 0
