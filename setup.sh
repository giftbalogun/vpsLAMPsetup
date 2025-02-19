#!/bin/bash
# ---------------------------------------------------------
# LAMP Stack Setup Script
# Author: Gift Balogun
# Portfolio: https://giftbalogun.name.ng
# GitHub: https://github.com/giftbalogun
# Description: This script automates the installation of 
# Apache, PHP, MariaDB, phpMyAdmin, and Composer on a 
# Debian-based Linux system.
# License: MIT
# ---------------------------------------------------------

# Function to handle cancellation
cancel_installation() {
  echo -e "\nInstallation canceled by the user. Cleaning up..."
  exit 1
}

# Set trap for SIGINT (Ctrl+C)
trap cancel_installation SIGINT

# Update package list
echo "Updating package list..."
sudo apt update -y || cancel_installation
sudo apt upgrade -y || cancel_installation

# Install Apache
echo "Installing Apache..."
if ! sudo apt install apache2 -y; then
  echo "Failed to install Apache. Exiting..."
  exit 1
fi
sudo systemctl start apache2 || cancel_installation
sudo systemctl enable apache2 || cancel_installation

# Install PHP and necessary extensions
echo "Installing PHP and required extensions..."
if ! sudo apt install php libapache2-mod-php php-cli php-common php-redis php-mysql php-cgi php-curl php-json php-mbstring php-xml php-zip php-pdo php-phar php-iconv -y; then
  echo "Failed to install PHP. Exiting..."
  exit 1
fi

# Install MariaDB (replacing MySQL)
echo "Installing MariaDB..."
if ! sudo apt install mariadb-server -y; then
  echo "Failed to install MariaDB. Exiting..."
  exit 1
fi
sudo systemctl start mariadb || cancel_installation
sudo systemctl enable mariadb || cancel_installation

# Secure MariaDB installation
echo "Securing MariaDB..."
sudo mysql_secure_installation || cancel_installation

# Install phpMyAdmin
echo "Installing phpMyAdmin..."
if ! sudo apt install phpmyadmin -y; then
  echo "Failed to install phpMyAdmin. Exiting..."
  exit 1
fi

# Enable phpMyAdmin in Apache
echo "Enabling phpMyAdmin in Apache..."
sudo ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin || cancel_installation

# Restart Apache
echo "Restarting Apache..."
sudo systemctl restart apache2 || cancel_installation

# Install Composer
echo "Installing Composer..."
if ! curl -sS https://getcomposer.org/installer | php; then
  echo "Failed to download Composer. Exiting..."
  exit 1
fi
sudo mv composer.phar /usr/local/bin/composer
composer --version || cancel_installation

# Final Summary
echo "Installation complete!"
echo "---------------------------------------------------------"
echo "Apache is installed and running."
echo "PHP and necessary extensions are installed."
echo "MariaDB is installed and running."
echo "phpMyAdmin is accessible at http://$(hostname -I | awk '{print $1}')/phpmyadmin"
echo "Composer is installed and ready to use."
echo "---------------------------------------------------------"
