#!/data/data/com.termux/files/usr/bin/bash

clear

echo "========================================"
echo "      Hermes Agent Installer"
echo "          For Termux-Ubuntu"
echo "          BY : I'AM TUBASYA"
echo "========================================"

sleep 2

# Update system
echo "[*] Updating packages..."
pkg update -y && pkg upgrade -y

# Install required packages
echo "[*] Installing dependencies..."

pkg install -y \
git \
python \
python-pip \
clang \
rust \
make \
pkg-config \
libffi \
openssl \
ca-certificates \
curl \
wget \
nodejs \
nodejs-lts \
ripgrep \
ffmpeg \
jq \
sqlite \
binutils \
libjpeg-turbo \
libpng \
zlib \
tar \
unzip \
termux-tools \
nano \
vim \
openssh \
procps \
which \
findutils \
sed \
grep \
coreutils

# Upgrade pip tools
echo "[*] Upgrading pip tools..."

pip install -U \
pip \
setuptools \
wheel \
virtualenv \
maturin

# Prepare Hermes directory
echo "[*] Preparing Hermes directory..."

mkdir -p ~/.hermes
cd ~/.hermes || exit

# Clone Hermes Agent
if [ ! -d "hermes-agent" ]; then
    echo "[*] Cloning Hermes Agent..."
    git clone --recurse-submodules https://github.com/NousResearch/hermes-agent.git
else
    echo "[*] Hermes Agent already exists"
fi

cd hermes-agent || exit

# Update submodules
echo "[*] Updating submodules..."
git submodule update --init --recursive

# Create virtual environment
if [ ! -d "venv" ]; then
    echo "[*] Creating Python virtual environment..."
    python -m venv venv
fi

# Activate venv
echo "[*] Activating virtual environment..."
source venv/bin/activate

# Android API
export ANDROID_API_LEVEL="$(getprop ro.build.version.sdk)"

echo "[*] Android API Level: $ANDROID_API_LEVEL"

# Fix compiler flags for Termux
export CFLAGS="-I/data/data/com.termux/files/usr/include"
export LDFLAGS="-L/data/data/com.termux/files/usr/lib"

# Install Hermes
echo "[*] Installing Hermes Agent..."

pip install -e '.[termux]' -c constraints-termux.txt

echo ""
echo "========================================"
echo "      Hermes Agent Installed!"
echo "========================================"
echo ""
echo "Location:"
echo "~/.hermes/hermes-agent"
echo ""
echo "Activate environment:"
echo "cd ~/.hermes/hermes-agent"
echo "source venv/bin/activate"
echo ""
echo "Run Hermes:"
echo "hermes"
echo ""
