    curl -o latest -L https://securedownloads.cpanel.net/latest
    wget -O directadmin.sh https://www.directadmin.com/setup.sh
    sudo su - -c "sh <(curl https://cyberpanel.net/install.sh || wget -O - https://cyberpanel.net/install.sh)"
    curl -fsSL https://installer.plesk.com/one-click-installer | sh
