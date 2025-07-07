## Lab 1

1. Tạo 1 EC2 instance từ AMI Amazon Linux 2
   - Launch Instance
   - AMI
   - Type
   - Key pair(SSH key)
   - Network settings (Security group: default)
   - Configure storage (disk size)
2. Cấu hình security group (default) mở 2 rule là SSH:22 và HTTP:80 từ địa chỉ IP của nhà bạn.

   - Security Group / Edit inbound rules

     | Type |      Source      |
     | :--- | :--------------: |
     | SSH  |      My IP       |
     | HTTP | My IP / Anywhere |

   need set My IP when modern change

3. Login vào server
   - Instance / Connect / SSH Client
   - File key pair - Sercurity/ Advanced / Disable inheritance - Add User (Local)
   - Connect
4. Cài httpd, cấu hình website cơ bản.

```bash
#Update OS
sudo yum update -y
#Instal HTTPD
sudo yum install httpd-y
I
#Modify below file:
/var/www/html/index.html
#Add some html code:
<h1>Welcome to Udemy</h1>
<h2>AWS Cloud for beginner. Please like, subscribe and share !!!!</h2>
#Enable httpd
sudo systemctl enable httpd
service httpd start

```

5. Truy cập website.
6. Tạo snapshot cho volume root.
7. Tạo AMI từ EC2 đang chạy.
8. Tạo 1 con EC2 instance mới từ AMI vừa tạo.
9. Truy cập vào EC2 vừa tạo xem website có được cài sẵn ko?

## Lab 2

1. Tạo EC2 Instance AMI : Window Server 2022 base
2. Config security group (default) rule RDP:3389
3. Login vao server (Remote Desktop connection)
   - RDP Client - Get Password (up key pair) - Download file/ use IP to connect

## Lab 3

Create Instance (have script to install software)

- Advanced Detail - User Data

```bash
#!/bin/bash
yum install httpd -y
service httpd start
chconfig httpd on

cd /var/www/html
echo "<html>" > index.html

echo "<h1>Welcome to Udemy</h1>" >> index.html
echo "<h4>You are running instance from this IP (For debug only!!!!Do not public this to user):</h4>" >> index.html

export TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`

echo "<br>Private IP: " >> index.html
curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/local-ipv4 >> index.html

echo "<br>Public IP: " >> index.html
curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/public-ipv4 >> index.html
echo "</html>" >> index.html
```

## Lab 4

1. Tạo thêm một volume và gán vào EC2 (Windows)
   - Volumes / Create Volume (need same zone)
   - Action / Attach Volume - Select Instance
2. Login vào Windows Server.
3. Enable và mount volume (Disk Management)
4. Thao tác thêm 1 vài file text.
5. Trên AWS console thực hiện điều chỉnh size volume.
   - Action / Modify Volume
6. Login vào windows server, thực hiện extend volume sử dụng disk manager

## Lab 5

1. Tạo thêm một volume và gán vào EC2 (Linux)
2. Login vào Linux Server.
3. Tạo partition và mount partit thành ổ /data
4. Thao tác thêm 1 vài file text.
5. Trên AWS console thực hiện điều chỉnh size volume.
6. Login vào Linux server, thực hiện extend volume sử dụng command growpart

```bash
######################## Mount and extend EBS volume #################
#list all partition and mountpoint
lsblk
#display all volume and free space
df -h
#Using fdisk to create partition.
sudo fdisk /dev/xvdb
Nhan: 'n', default ... enter
Nhan: 'w' để save lại.
#Kiểm tra bằng lệnh sau, nếu thấy partiion tạo ra ngay dưới level disk là OK
lsblk

#format partition
sudo mkfs -t xfs /dev/xvdb1
#Tạo folder để mount
sudo mkdir /data
#Mount
sudo mount /dev/xvdb1 /data

#Test write data to /data
sudo vi /data/test.txt

#Make volume auto mount after restart EC2
sudo blkid
sudo lsblk -o +UUID

#Modify fstab file, then add 1 line for /data volume
sudo vi /etc/fstab
#Test auto mount
sudo umount /data
sudo mount -a
df -h

#Extend volume in AWS Console.
#Login to Linux server, check disk and partition.
lsblk
#Grow Volume after extend EBS volume on AWS Console.
sudo growpart /dev/xvdb 1
#Grow part after extend volume
sudo xfs_growfs -d /data
#Kiem tra lai:
df -h
```

## Lab 9

Add ssh key của project member vào Server Linux

- SD Câu lệnh ssh key gen để tạo 1 cặp public + private key.
- Login vào server với ec2-user
- Edit file ssh của user developer1.
- Restart service ssh
- Logout và login lại với user develo sử dụng private key.

```bash
#SD Câu lệnh ssh key gen để tạo 1 cặp public +private key.
ssh-keygen -t rsa -b 4096 -C "dev01"

#Login vào server với ec2-user

#Tạo user dev01
sudo useradd dev01
#Không set password cho user.

#Switch sang user dev01
sudo su - dev01
#Kiểm tra thư mục đang đứng:
pwd
id

#Tạo thu mục .ssh
mkdir .ssh
chmod 700 .ssh
#Tạo file authorized_keys
touch .ssh/authorized_keys
chmod 600 .ssh/authorized_keys

#Edit file .ssh/authorized_keys
vim .ssh/authorized_keys
#Copy nội dung file dev01.pub vào file authorized_keys

#Thoat khoi user dev01
exit
#Restart service ssh
sudo service sshd restart
#Logout và login lại với user developer1 sử dụng private key. (Nhớ thay domain của ec2 server).
ssh -i "dev01" dev01@ec2-3-0-176-43.ap-southeast-1.compute.amazonaws.com
```

## Lab: Clear resources

1. Terminate EC2 instance
2. Xóa EBS Volume (nếu còn sót lại)
3. Kiểm Elastic IP nêu có thì xóa.
4. Kiểm tra Snapshot, nếu có thì xóa.
