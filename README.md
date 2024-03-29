# AnuBituxVM
This script transforms a Debian12 standard installed operating system in an AnuBItux environment. It is only intended for training and test purposes, use the live version for real use cases.

## How to use this script
Install a [Debian 12](https://cdimage.debian.org/debian-cd/current-live/amd64/iso-hybrid/) operating system with English language. We suggest the standard version so that there will not be any previous desktop environment.
Prefearably do not set a root password to be able to use commands with `sudo`.
If you prefer to use a root password, remember to add your user to the sudoers with `usermod -aG sudo $USER`.
Then follow this steps:
- install git to clone this repository
```
sudo apt -y install git
```
- clone this repository:
```
git clone https://github.com/AnuBitux-project/AnuBituxVM
```
- move to the downloaded folder
```
cd AnuBituxVM
```
- give execution rights to the script
```
chmod +x anubitux_vm.sh
```
- run the script
```
./anubitux_vm.sh
```
- wait for the script to finish and reboot
```
sudo reboot 0
```
Now you can enjoy your version of AnuBitux.
