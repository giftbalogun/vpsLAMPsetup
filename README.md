# LAMP Stack Setup Script

This repository contains a Bash script designed to quickly set up a LAMP (Linux, Apache, MySQL/MariaDB, PHP) stack along with additional tools such as phpMyAdmin and Composer. The script automates package updates, installations, and initial configurations to help you get your development environment up and running with minimal effort.

## Features

- **Apache Installation:** Installs Apache2 and ensures the service is started and enabled.
- **PHP Installation:** Installs PHP along with necessary extensions for typical web applications.
- **MariaDB Installation:** Installs MariaDB (as a drop-in replacement for MySQL) and secures the installation.
- **phpMyAdmin:** Installs phpMyAdmin and links it to your Apache server for easy database management.
- **Composer:** Downloads and installs Composer, the dependency manager for PHP.
- **Graceful Cancellation:** If the installation process is interrupted (e.g., via Ctrl+C), the script cancels the process and performs cleanup.

## Prerequisites

- A Debian-based Linux distribution (such as Ubuntu).
- Sudo privileges to install and manage packages.
- An active internet connection for package downloads.

## Installation and Usage

### 1. Clone the Repository

```bash
git clone https://github.com/giftbalogun/vpsLAMPsetup.git
cd vpsLAMPsetup
```

### 2. Make the Script Executable (if not already)

```bash
chmod +x setup.sh
```

### 3. Run the Script

Execute the script with sudo to allow it to install packages and manage system services.
```bash
sudo ./setup.sh
```
The script will update your package list, install and configure Apache, PHP, MariaDB, phpMyAdmin, and Composer. 
Follow any on-screen prompts (e.g., during the MariaDB secure installation process).

## How It Works
- Signal Handling: The script includes a trap for the SIGINT signal (Ctrl+C). If the user cancels the installation, the script will exit gracefully and clean up.
- Error Handling: At each critical step, the script checks for errors. If an installation fails, the script will exit and print an error message.
- Service Management: After installing each service, the script ensures the service is started and set to run on system boot.