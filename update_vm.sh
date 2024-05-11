#!/bin/bash

# Version 3.3 01-May-2024

# VARIABLES
SPARROW="1.9.0"
EXODUS="24.19.4"
ATOMIC="2.76.14"
# https://get.atomicwallet.io/download/latest-debian.txt
ZEC="1.8.8"
VERACRYPT="1.26.7"
BITBOX="4.42.0"
BITBOX2="4.42.0_amd64"
ELECTRUM="4.5.4"
ELECTRON="4.4.1"
ELECTRUM_LTC="4.2.2.1"
GREEN="2.0.5"
FEATHER="2.6.7"
MYMONERO="1.3.2"
MYCRYPTO="1.7.17"
MYCRYPTO2="1.7.17_MyCrypto"
TREZOR="24.4.3"
KEEPKEY="3.0.13"
COINOMI="1.3.0"
TORBROWSER="13.0.14"
TORBROWSER2="13.0.14_ALL"
BITWARDEN="2024.4.3"
BCVAULT="setup_2.2.0"
MONEROCLI="0.18.3.3"
FIRO="4.1.5.3"
TONKEEPER="3.12.1"
TONKEEPER2="_3.12.1_amd64"
GUARDA="1.0.20"
GUARDA2="1.0.20_amd64"

# COLORS
RED='\033[0;31m'
NC='\033[0m'

echo -e ${RED}Remember to update the versions of the tools in the variables at the beginning of the script${NC}

# Updating debian tools
sudo apt update
sudo apt -y upgrade

# Downloading and installing debs
# Sparrow
wget --user-agent="Mozilla" https://github.com/sparrowwallet/sparrow/releases/download/$SPARROW/sparrow_$SPARROW-1_amd64.deb
sudo dpkg -i sparrow*
rm -rf sparrow*

# BitBox
wget --user-agent="Mozilla" https://github.com/digitalbitbox/bitbox-wallet-app/releases/download/v$BITBOX/bitbox_$BITBOX2.deb
sudo dpkg -i bitbox*
rm -rf bitbox*

# Kalitorify
systemctl enable ufw
git clone https://github.com/brainfucksec/kalitorify
cd kalitorify
sudo make install
cd ..
rm -rf kalitorify

# exodus
wget --user-agent="Mozilla" https://downloads.exodus.com/releases/exodus-linux-x64-$EXODUS.deb
sudo dpkg -i exodus*
rm -rf exodus*

# BitWarden
wget --user-agent="Mozilla" https://github.com/bitwarden/clients/releases/download/desktop-v$BITWARDEN/Bitwarden-$BITWARDEN-amd64.deb
sudo dpkg -i Bitwarden*
rm -rf Bitwarden*

# Atomic
wget --user-agent="Mozilla" https://get.atomicwallet.io/download/atomicwallet-$ATOMIC.deb
sudo dpkg -i atomic*
rm -rf atomic*

# VeraCrypt
sudo apt -y install libwxgtk3.2-1
wget --user-agent="Mozilla" https://launchpad.net/veracrypt/trunk/$VERACRYPT/+download/veracrypt-$VERACRYPT-Debian-12-amd64.deb
wget https://launchpad.net/veracrypt/trunk/1.26.7/+download/veracrypt-1.26.7-Debian-12-amd64.deb
sudo dpkg -i veracrypt*
rm -rf veracrypt*

# TonKeeper
wget --user-agent="Mozilla" https://github.com/tonkeeper/tonkeeper-web/releases/download/v$TONKEEPER/tonkeeper$TONKEEPER2.deb
dpkg -i tonkeeper*
rm -rf tonkeeper*

wget --user-agent="Mozilla" https://github.com/guardaco/guarda-desktop-releases/releases/download/v$GUARDA/Guarda_$GUARDA2.deb
dpkg -i Guarda*
rm -rf Guarda*

# Just in case something went wrong
sudo apt --fix-broken install

sudo chmod -R 777 /opt/*

#VeraDecrypt
cd /opt/Tools/Recovery/VeraDecrypt
git pull

# SeedCheck
cd /opt/Tools/WalletTools/SeedCheck
git pull

# DiceTracker
cd /opt/Tools/WalletGen/DiceTracker
git pull

# Dice2Seed
cd /opt/Tools/WalletGen/Dice2Seed
git pull

# LastWord
cd /opt/Tools/WalletGen/LastWord
git pull

# Mic2Paper
cd /opt/Tools/WalletGen/Mic2Paper
git pull

# Mic2Seed
cd /opt/Tools/WalletGen/Mic2Seed
git pull

# MicCheck
cd /opt/Tools/WalletGen/MicCheck
git pull

# btcrecover
cd /opt/Tools/Recovery/btcrecover
git pull

# SeedSearch
cd /opt/Tools/Recovery/SeedSearch
git pull

# BtcKeySearch
cd /opt/Tools/Recovery/BTCKeySearch
git pull

# SeedBF
cd /opt/Tools/Recovery/SeedBF
git pull

cd $HOME

# Hardware wallets setup
wget --user-agent="Mozilla" -q -O - https://raw.githubusercontent.com/LedgerHQ/udev-rules/master/add_udev_rules.sh | sudo bash
python3 -m pip install trezor[hidapi]
python3 -m pip install hidapi btchip-python ecdsa ledger-bitcoin
python3 -m pip install keepkey
python3 -m pip install hidapi
python3 -m pip install bitbox02
python3 -m pip install safet
python3 -m pip install ckcc-protocol
python3 -m pip install pyserial cbor
cd /opt/Tools/Wallets/HW/
git clone https://github.com/AnuBitux/udev
cp /opt/Tools/Wallets/HW/udev/*.rules /etc/udev/rules.d
groupadd plugdev
usermod -aG plugdev $(whoami)
udevadm control --reload-rules && udevadm trigger

# Appimages
#DOWNLOAD
cd /opt/Tools/Wallets
wget --user-agent="Mozilla" https://download.electrum.org/$ELECTRUM/electrum-$ELECTRUM-x86_64.AppImage
mv electrum-4* electrum-btc.AppImage
wget --user-agent="Mozilla" https://electroncash.org/downloads/$ELECTRON/win-linux/Electron-Cash-$ELECTRON-x86_64.AppImage
mv Electron-Cash-* Electron-Cash.AppImage
wget --user-agent="Mozilla" https://electrum-ltc.org/download/electrum-ltc-$ELECTRUM_LTC-x86_64.AppImage
mv electrum-ltc* electrum-ltc.AppImage
wget --user-agent="Mozilla" https://greenupdate.blockstream.com/desktop/latest/$GREEN/BlockstreamGreen-x86_64.AppImage
wget --user-agent="Mozilla" https://featherwallet.org/files/releases/linux-appimage/feather-$FEATHER.AppImage
mv feather-* feather.AppImage
wget --user-agent="Mozilla" https://github.com/mymonero/mymonero-app-js/releases/download/v$MYMONERO/MyMonero-$MYMONERO.AppImage
mv MyMonero-* MyMonero.AppImage
wget --user-agent="Mozilla" https://github.com/MyCryptoHQ/MyCrypto/releases/download/$MYCRYPTO/linux-x86-64_$MYCRYPTO2.AppImage
mv linux-x86-64* MyCrypto.AppImage
wget --user-agent="Mozilla" https://github.com/adityapk00/zecwallet-lite/releases/download/v$ZEC/Zecwallet.Lite-$ZEC.AppImage
mv Zecwallet* Zecwallet.Lite.AppImage
wget --user-agent="Mozilla" https://storage.coinomi.com/binaries/desktop/coinomi-wallet-$COINOMI-linux64.tar.gz
tar -xf coinomi*
rm -rf coinomi-wallet-$COINOMI-linux64.tar.gz
wget --user-agent="Mozilla" https://github.com/firoorg/electrum-firo/releases/download/$FIRO/Firo-Electrum-$FIRO-x86_64.AppImage
mv Firo-* electrum-firo.AppImage
sudo chmod -R +x *

# hardware wallets clients
cd HW
wget --user-agent="Mozilla" https://download.live.ledger.com/latest/linux
mv ledger* ledger-live.AppImage
mv linux ledger-live.AppImage
wget --user-agent="Mozilla" https://github.com/trezor/trezor-suite/releases/download/v$TREZOR/Trezor-Suite-$TREZOR-linux-x86_64.AppImage
mv Trezor-Suite* Trezor-Suite.AppImage
wget --user-agent="Mozilla" https://github.com/keepkey/keepkey-desktop/releases/download/v$KEEPKEY/KeepKey-Desktop-$KEEPKEY.AppImage
mv KeepKey-D* KeepKey.AppImage
wget --user-agent="Mozilla" https://data.trezor.io/udev/trezor-udev_2_all.deb
wget --user-agent="Mozilla" https://dl.update.bc-vault.com/downloads/$BCVAULT.tar.gz
tar -xf setup*
./setup*
rm -rf setup*
sudo chmod -R +x *

# Tor-browser
cd $HOME
wget --user-agent="Mozilla" https://www.torproject.org/dist/torbrowser/$TORBROWSER/tor-browser-linux64-$TORBROWSER2.tar.xz
tar -xf tor-browser-linux*
rm -rf tor-browser-linux*
#mv tor-browser tor-browser_en-US

# Other tools
cd /opt/Tools/WalletGen/
git clone https://github.com/bccaddress/bccaddress.org
git clone https://github.com/pointbiz/bitaddress.org
git clone https://github.com/litecoin-project/liteaddress.org
git clone https://github.com/JollyMort/monero-wallet-generator
wget --user-agent="Mozilla" https://downloads.getmonero.org/cli/monero-linux-x64-v$MONEROCLI.tar.bz2
tar -xf monero-linux*
rm -rf monero-linux
mv monero-x86_64* monero-cli
git clone https://github.com/dashpay/paper.dash.org
cd /opt/Tools/Privacy/
git clone https://github.com/ASeriousMister/passgen.py
cd /opt/Tools/WalletTools
wget --user-agent="Mozilla" https://github.com/iancoleman/bip39/releases/download/0.5.6/bip39-standalone.html
git clone https://github.com/jlopp/xpub-converter
git clone https://github.com/BitcoinQnA/seedtool
git clone https://github.com/luigi1111/xmr.llcoins.net
git clone https://github.com/OutCast3k/coinbin/

# Getting uSeful AnuBitux scripts
sudo chmod 777 /opt/
cd /opt/scripts
git pull
cd $HOME

echo -e ${RED}Anubitux has been updated${NC}
figlet AnuBitux

# Making tools working properly
sudo chmod -R 777 /opt/*

figlet AnuBitux
