#! /usr/bin/env  bash

if
    [[ -f "1".xls ]] &&  [[ -f "2".xls ]] &&  [[ -f "3".xls ]] &&  [[ -f "4".xls ]] &&  [[ -f "5".xls ]] &&  [[ -f "6".xls ]] &&  [[ -f "7".xls ]]
 &&  [[ -f "8".xls ]] &&  [[ -f "9".xls ]] &&  [[ -f "10".xls ]] &&  [[ -f "11".xls ]] &&  [[ -f "12".xls ]] ; then
    echo " the files exists"
elif
        touch 1.xls 2.xls 3.xls 4.xls 5.xls 6.xls 7.xls 8.xls 9.xls 10.xls 11.xls 12.xls ; then
        echo " the files have been created now"
 fi
 
 tar -cvf /root/Reports/2022.tar /root/Backup
 
