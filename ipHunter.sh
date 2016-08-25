#!/bin/bash
# author: nullPoint3r

# Regional Internet Registry URL 
AFRINIC=http://ftp.afrinic.net/stats/afrinic/delegated-afrinic-latest     #Africa Region
APNIC=http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest       #Asia/Pacific Region
ARIN=http://ftp.arin.net/pub/stats/arin/delegated-arin-extended-latest    #Canada, USA, and some Caribbean Islands
LACNIC=http://ftp.lacnic.net/pub/stats/lacnic/delegated-lacnic-latest     #Latin America and some Caribbean Islands
RIPENCC=http://ftp.ripe.net/pub/stats/ripencc/delegated-ripencc-latest    #Europe, the Middle East, and Central Asia

#
CURRENT_DIR=`dirname $0`
REGISTRY=Apnic
CC=CN

# Get file
wget http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest
FILE=delegated-apnic-latest

# filter CN ips
grep "apnic|CN|ipv4" $FILE | awk -F "|" '{print $4,$5}' > IP.txt

count=`cat IP.txt | wc -l`
line=1
while(($line<=$count));do
        IP=`sed -n ${line}p IP.txt | awk '{print $1}'`
        HOST=`sed -n ${line}p IP.txt | awk '{print $2}'`
        NETMASK=0
        case $HOST in
                256 ) NETMASK=24 ;;
                512 ) NETMASK=23 ;;
                1024 ) NETMASK=22 ;;
                2048 ) NETMASK=21 ;;
                4096 ) NETMASK=20 ;;
                8192 ) NETMASK=19 ;;
                16384 ) NETMASK=18 ;;
                32768 ) NETMASK=17 ;;
                65536 ) NETMASK=16 ;;
                131072 ) NETMASK=15 ;;
                262144 ) NETMASK=14 ;;
                524288 ) NETMASK=13 ;;
                1048576 ) NETMASK=12 ;;
                2097152 ) NETMASK=11 ;;
                4194304 ) NETMASK=10 ;;
                * ) echo "INVALID NUMBER" ;;
        esac
        echo $IP/$NETMASK
        echo $IP/$NETMASK >> IP.SH
        let line++
done
rm -rf IP.txt $FILE


updateData() {
        wget AFRINIC -O CURRENT_DIR/data/AFRINIC_latest.txt.tmp
        mv CURRENT_DIR/data/AFRINIC_latest.txt.tmp CURRENT_DIR/data/AFRINIC_latest.txt
        wget APNIC -O CURRENT_DIR/data/APNIC_latest.txt.tmp
        mv CURRENT_DIR/data/APNIC_latest.txt.tmp CURRENT_DIR/data/APNIC_latest.txt
        wget ARIN -O CURRENT_DIR/data/ARIN_latest.txt.tmp
        mv CURRENT_DIR/data/ARIN_latest.txt.tmp CURRENT_DIR/data/ARIN_latest.txt
        wget LACNIC -O CURRENT_DIR/data/LACNIC_latest.txt.tpm
        mv CURRENT_DIR/data/LACNIC_latest.txt.tpm CURRENT_DIR/data/LACNIC_latest.txt
        wget RIPENCC -O CURRENT_DIR/data/RIPENCC_latest.txt.tmp
        mv CURRENT_DIR/data/RIPENCC_latest.txt.tmp CURRENT_DIR/data/RIPENCC_latest.txt
}