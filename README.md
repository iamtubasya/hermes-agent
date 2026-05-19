Hermes Agent for Termux (Ubuntu)

Simple installer and setup for running Hermes Agent on Ubuntu inside Termux Android.

Features

- Auto install dependencies
- Ubuntu compatible
- Termux friendly
- No sudo required
- Virtual environment setup
- Hermes Agent ready to use

---

Requirements

- Android device
- Termux
- Ubuntu (Proot)
- Internet connection
- Minimum 6GB RAM recommended

---

Install Ubuntu on Termux

Install required packages:

pkg update -y && pkg upgrade -y
pkg install proot-distro -y

Install Ubuntu:

proot-distro install ubuntu

Login Ubuntu:

proot-distro login ubuntu

---

Download Installer

apt update && apt upgrade -y

apt install git curl wget -y

git clone https://github.com/USERNAME/hermes-termux-installer.git

cd hermes-termux-installer

---

Run Installer

chmod +x install.sh

./install.sh

Installer will automatically:

- Install Python
- Install NodeJS
- Install Rust
- Install FFmpeg
- Install Hermes Agent
- Create virtual environment
- Configure Android compatibility

---

Activate Hermes

cd ~/.hermes/hermes-agent

source venv/bin/activate

Run Hermes:

hermes

---

Update Hermes

cd ~/.hermes/hermes-agent

git pull

source venv/bin/activate

pip install -e '.[termux]' -c constraints-termux.txt

---

Common Issues

sudo: command not found

Ubuntu inside Termux usually already runs as root.

Remove "sudo" from commands.

---

Rust build error

Install Rust:

apt install rustc cargo -y

---

Playwright / Chromium error

Browser automation on Android is experimental.

Optional install:

apt install chromium-browser -y

---

Recommended Device

- Snapdragon chipset
- UFS storage
- 6GB+ RAM
- Lightweight ROM

---

Credits

- Nous Research
- Hermes Agent
- Termux Community

---

Official Hermes Agent

https://github.com/NousResearch/hermes-agent
