#!/bin/bash

apt update
apt upgrade -y

apt install -y nala

nala install -y neofetch kitty curl ufw micro htop 