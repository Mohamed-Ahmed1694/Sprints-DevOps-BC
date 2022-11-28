#!/usr/bin/env    bash

#source /home/mohamed/task2/task2.sh

source ./copy_task2.sh


                echo "please choose number from the following:-"
                echo "1-root check "
                echo "2-new SSH port"
                echo "3-disable root login"
                echo "4-add user with sudo"
                echo "5-backup home directory for user"
                        read  answer
        case $answer in
                1)root_check;;
                2)new_port;;
                3)root_login;;
                4)add_user_sudo;;
                5)cron_backup;;
                *)not an answer;;
        esac


#bonus_marks

while [[ ! -f /usr/tmp/loop.txt ]];
do
        echo "looking for /usr/tmp/loot.txt "
        echo " will be found in 5 seconds."
        sleep 5
done

echo "the file is not exist"
~                           
