#!/bin/sh

TP=0;
for disk in $(fdisk -l |awk '{print $1}' | grep '/dev' |  awk '{print $1}')
    do
        echo  $disk | `awk '{printf "%s : ", $1}'>>/var/log/swift/diskerror.log`
        `/usr/sbin/smartctl -A $disk | grep Raw_Read_Error_Rate |
              awk -F " ",  '{if ($10 > 0) {
                                printf "%d ERROR \n", $10;
                                TP=1
                           } else {
                               printf "%d \n",  $10;
                           }}' >>/var/log/swift/diskerror.log`
    done;

return $TP
