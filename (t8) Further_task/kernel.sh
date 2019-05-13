
#!/bin/sh

wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.20.12.tar.xz
unxz -v linux-4.20.12.tar.xz
wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.20.12.tar.sign
gpg --verify linux-4.20.12.tar.sign 
gpg --recv-keys 647F28654894E3BD457199BE38DBBDC86092693E
gpg --verify linux-4.20.12.tar.sign
tar xvf linux-4.20.12.tar
cd linux-4.20.12
cp -v /boot/config-4.18.0-17-generic .config
sudo apt-get install build-essential libncurses-dev bison flex libssl-dev libelf-dev
make menuconfig
make -j 4
sudo make modules_install
sudo make install
sudo update-initramfs -c -k 4.20.12
sudo update-grub
uname -mrs
