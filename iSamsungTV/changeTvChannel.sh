#!/bin/bash
/usr/local/bin/iSamsungTV $1 -KEY KEY_$2
sleep 0.1
/usr/local/bin/iSamsungTV $1 -KEY KEY_$3
sleep 0.1
/usr/local/bin/iSamsungTV $1 -KEY KEY_ENTER
