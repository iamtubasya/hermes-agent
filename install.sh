#!/data/data/com.termux/files/usr/bin/bash

apt update && apt upgrade -y
apt install curl git nano -y
apt install nodejs npm python3 -y

curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
