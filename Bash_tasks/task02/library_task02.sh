#! /usr/bin/env   bash

function root_check {

        if
                [[ $EUID -ne 0 ]]; then
                echo " this is not a root user "

        elif
                 [[ $EUID -eq 0 ]]; then
                echo " this is a root user "
                exit 1
        fi
}

#root_check


function new_port {

echo ""
echo -n "Please enter the port you would like SSH to run on: "
while read SSHPORT; do
        if [[ "$SSHPORT" =~ ^[0-9]{2,5}$ || "$SSHPORT" = 22 ]]; then
                if [[ "$SSHPORT" -ge 1024 && "$SSHPORT" -le 65535 || "$SSHPORT" = 22 ]]; then
                        # Create backup of current SSH config
                        NOW=$(date +"%m_%d_%Y-%H_%M_%S")
                        cp /etc/ssh/sshd_config /etc/ssh/sshd_config.inst.bckup.$NOW
                        # Apply changes to sshd_config
                        sed -i -e "/Port /c\Port $SSHPORT" /etc/ssh/sshd_config
                        echo -e "Restarting SSH in 3 seconds. Please wait.\n"
                        sleep 3
                        # Restart SSH service
                        $sudo $systemctl $restart sshd
                        echo ""
                        echo -e "The SSH port has been changed to $SSHPORT. Please login using that port to test BEFORE ending this session.\n"
                        exit 0
                else
                        echo -e "Invalid port: must be 22, or between 1024 and 65535."
                        echo -n "Please enter the port you would like SSH to run on > "
                fi
        else
                echo -e "Invalid port: must be numeric!"
                echo -n "Please enter the port you would like SSH to run on > "
        fi
done

echo ""
}


#new_port

function root_login {

sed -i '/^#PermitRootLogin[ \t]\+\w\+$/{ s//PermitRootLogin yes/g; }' /etc/ssh/sshd_config


}

#root_login


function add_user_sudo {

if [ $(id -u) -eq 0 ]; then
        read -p "Enter username : " username
        read -s -p "Enter password : " password
        egrep "^$username" /etc/passwd >/dev/null
        if [ $? -eq 0 ]; then
                echo "$username exists!"
                exit 1
        else
                pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
                useradd -m -p "$pass" "$username"
                [ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
        fi
else
        echo "Only root may add a user to the system."
        exit 2
fi


echo "Add $username to sudoers? [Y,n]"
read input
if [[ $input == "Y" || $input == "y" ]]; then
        echo " $username  ALL=(ALL:ALL) ALL" >> /etc/sudoers&& echo " the $username has been add to sudoers"
else
        echo "the user is not sudo"
fi
}


#add_user_sudo

        if       [[ $EUID == 0 ]];then

                echo "Do you want make backup for directroy reports ? (Y/N)"
                read answer
        if      [[ $answer == "Y" || $answer == "y" ]]; then
                echo "what user do you  want to creat crontab to him ?"
                read  username
                 if  getent passwd "$username" > /dev/null 2>&1 ;then
                        mkdir /cron_backup/$username
                 echo "yes the user '$username' exists";
                 echo -e "crontab backup will be ready  in 3 seconds. Please wait.\n"
                        sleep 3
                 echo "* 12 * * * tar -zcf /cron_backup.tgz $home" >  "/cron_backup,txt"
                        sudo crontab "/cron_backup,txt"
            else
                               echo "No, the user '$username' does not exist"

        fi

            elif

                         [[ $answer == 'N' || $answer == 'n' ]]; then
                echo "bye,see you later"
                else
                echo "invalid option try again later."
        fi
                else
                echo " you should use a root user."
        fi
}


#cron_backup


