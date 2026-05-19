#!/usr/bin/env bash

clear

echo "========================================"
echo "      Hermes Agent Installer"
echo "         Ubuntu Termux"
echo "       BY : @I'AM TUBASYA"
echo "========================================"

sleep 2

# Root check
if [ "$(id -u)" != "0" ]; then
    echo "[!] Please run as root inside Ubuntu proot"
    echo ""
    echo "Example:"
    echo "proot-distro login ubuntu"
    exit 1
fi

echo "[*] Updating Ubuntu packages..."

apt update -y && apt upgrade -y

echo "[*] Installing required dependencies..."

apt install -y \
git \
python3 \
python3-pip \
python3-venv \
build-essential \
clang \
rustc \
cargo \
pkg-config \
libffi-dev \
libssl-dev \
curl \
wget \
nodejs \
npm \
ripgrep \
ffmpeg \
jq \
sqlite3 \
libjpeg-dev \
libpng-dev \
zlib1g-dev \
unzip \
tar \
nano \
vim \
openssh-client \
procps \
ca-certificates \
software-properties-common

echo "[*] Upgrading Python build tools..."

pip3 install -U \
pip \
setuptools \
wheel \
virtualenv \
maturin \
--break-system-packages

echo "[*] Preparing Hermes directory..."

mkdir -p ~/.hermes
cd ~/.hermes || exit

# Clone Hermes Agent
if [ ! -d "hermes-agent" ]; then
    echo "[*] Cloning Hermes Agent..."
    
    git clone --recurse-submodules \
    https://github.com/NousResearch/hermes-agent.git
    
else
    echo "[*] Hermes Agent already exists"
fi

cd hermes-agent || exit

echo "[*] Updating submodules..."

git submodule update --init --recursive

# Create virtual environment
if [ ! -d "venv" ]; then
    echo "[*] Creating Python virtual environment..."
    python3 -m venv venv
fi

echo "[*] Activating virtual environment..."

source venv/bin/activate

# Android API level
if command -v getprop >/dev/null 2>&1; then
    export ANDROID_API_LEVEL="$(getprop ro.build.version.sdk)"
    echo "[*] Android API Level: $ANDROID_API_LEVEL"
fi

# Compiler flags for Termux/Proot
export CFLAGS="-I/data/data/com.termux/files/usr/include"
export LDFLAGS="-L/data/data/com.termux/files/usr/lib"

echo "[*] Installing Hermes Agent..."

pip install -e '.[termux]' \
-c constraints-termux.txt \
--break-system-packages

echo ""
echo "========================================"
echo "      Hermes Agent Installed!"
echo "========================================"
echo ""

echo "[*] Hermes location:"
echo "~/.hermes/hermes-agent"
echo ""

echo "[*] Activate environment:"
echo "cd ~/.hermes/hermes-agent"
echo "source venv/bin/activate"
echo ""

echo "[*] Run Hermes:"
echo "hermes"
echo ""

echo "[*] Optional:"
echo "Install Chromium for browser tools"
echo ""

echo "apt install chromium-browser -y"
echo ""

echo "========================================"
