dd if=/dev/zero of=test.img bs=1G count=1
# mkfs.vfat -F 32 -s8 -S512 -v test.img 
sudo losetup loop6 test.img
sudo -H gparted /dev/loop6
sudo mkdir /mnt/loopmnt
sudo mount /dev/loop6 /mnt/loopmnt
sudo bash -c 'echo hello > /mnt/loopmnt/test.txt'
sudo umount /mnt/loopmnt
sudo losetup -d /dev/loop6
# 接下来要找根目录区
xxd -a0 -g1 test.img