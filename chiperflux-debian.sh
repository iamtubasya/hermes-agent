#!/bin/bash
pkg install openssl-tool -y
openssl enc -d -aes-256-cbc -pbkdf2 -in chiper-debian.enc | bash
