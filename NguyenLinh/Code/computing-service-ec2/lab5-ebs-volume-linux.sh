######################## Mount and extend EBS volume #################
#list all partition and mountpoint
lsblk
#display all volume and free space
df -h
#Using fdisk to create partition from /dev/svdf disk
sudo fdisk /dev/xvdf

#format partition
sudo mkfs -t xfs /dev/xvdf1
#Mount
sudo mkdir /data
sudo mount /dev/xvdf1 /data

#Make volume auto mount after restart
sudo blkid
sudo lsblk -o +UUID

#Modify fstab file, then add 1 line for /data volume
sudo vi /etc/fstab
#Add line below, UUID take in  sudo lsblk -o +UUID command
#UUID=e273abc7-b32a-4444-bee3-1e12ff2e75b9     /data       xfs    defaults,noatime  0   2
#Test auto mount
sudo umount /data
sudo mount -a

#Grow part after extend EBS volume on AWS Console.
# 1 is number of partition in /dev/xvdf disk
sudo growpart /dev/xvdf 1
