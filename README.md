# LAMP Stack Setup Script

This repository contains a Bash script that automates the installation and configuration of a complete LAMP (Linux, Apache, MariaDB, PHP) stack. It also includes optional tools such as phpMyAdmin and Composer. Designed for Debian-based systems (like Ubuntu), this script ensures a fast, reliable setup for web development environments.

## Features

* **Apache Installation:** Installs Apache2, starts the service, and enables it to run on boot.
* **PHP Installation:** Installs PHP and common extensions required by popular frameworks and CMS platforms.
* **MariaDB Installation:** Installs MariaDB (MySQL-compatible) and runs a secure installation process.
* **phpMyAdmin Installation:** Automatically installs and configures phpMyAdmin with Apache. Post-install configuration advice is provided for MariaDB users who encounter access issues.
* **Composer Installation:** Installs Composer globally, the PHP dependency manager.
* **Graceful Cancellation:** Handles script interruption (e.g., Ctrl+C) gracefully, exiting cleanly with partial cleanup if necessary.
* **Error Handling:** Script checks for errors at critical stages, aborting with informative messages if something goes wrong.
* **Service Management:** Verifies and enables each installed service to start on system boot.

## Prerequisites

* Debian-based Linux distribution (Ubuntu, etc.)
* Sudo privileges
* Active internet connection

## Installation and Usage

### 1. Clone the Repository

```bash
git clone https://github.com/giftbalogun/vpsLAMPsetup.git
cd vpsLAMPsetup
```

### 2. Make the Script Executable

```bash
chmod +x setup.sh
```

### 3. Run the Script

Execute the script with superuser privileges:

```bash
sudo ./setup.sh
```

Follow on-screen prompts. During the MariaDB setup, you'll be prompted to secure your installation.

> **Note:** On systems using MariaDB, phpMyAdmin may return an "Access denied for user 'root'@'localhost'" error. This happens when MariaDB uses `unix_socket` authentication. To fix this:
>
> 1. Login with sudo:
>
>    ```bash
>    sudo mariadb
>    ```
> 2. Then run:
>
>    ```sql
>    UPDATE mysql.user SET plugin = 'mysql_native_password' WHERE user = 'root';
>    SET PASSWORD FOR 'root'@'localhost' = PASSWORD('your_password');
>    FLUSH PRIVILEGES;
>    ```
> 3. Restart MariaDB:
>
>    ```bash
>    sudo systemctl restart mariadb
>    ```
> 4. Use your password in phpMyAdmin.

## How It Works

* **Signal Handling:** Uses trap to catch `SIGINT` (Ctrl+C) and exit cleanly.
* **Error Handling:** Aborts on any failed step with helpful error messages.
* **Service Checks:** Ensures Apache, MariaDB, and PHP are properly running and enabled.

## License

MIT License. See `LICENSE` file for more details.

## Author

Gift Balogun

For feedback, contributions, or issues, please visit the [GitHub repository](https://github.com/giftbalogun/vpsLAMPsetup).
