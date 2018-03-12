#!/bin/bash
if test -d /etc/apache2/sites-available && test -d /etc/apache2/sites-enabled  ; then
        echo "-----------------------------------------------"
else
        mkdir /etc/apache2/sites-available
        mkdir /etc/apache2/sites-enabled
fi


enabled=/etc/apache2/sites-enabled/
site=`ls /etc/apache2/sites-available/`

for file in /etc/apache2/sites-available/*.conf;
  do
    avail="/etc/apache2/sites-available/$(basename $file)"
    enabled="/etc/apache2/sites-enabled/$(basename $file)"
    if test -e $avail; then
            ln -s $avail $enabled
    else
            echo -e "$avail virtual host does not exist! Please create one!\n"
            exit 0
    fi
    if test -e $enabled; then

            echo "Success!! Now restart Apache server: sudo service apache2 restart"
            service apache2 restart
    else
            echo  -e "Virtual host $avail does not exist!\nPlease see available virtual hosts:\n"
            exit 0
    fi
  done
