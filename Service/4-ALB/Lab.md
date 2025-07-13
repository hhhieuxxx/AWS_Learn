### Lab cơ bản

1. Tạo 2 EC2 Instance: A và B (dùng userdata khác nhau để dễ phân biệt)
2. Tạo **Target Group tg-01**, add A & B
3. Tạo **ALB**, cấu hình Listener port 80 (http) trỏ vào tg-01 (EC2-Load Balancing)
   - Mapping : Chọn nhiều nhất số zone có thể
4. Security Group
5. Truy cập ALB thông qua DNS link

```bash
#!/bin/bash
yum install httpd -y
service httpd start
chconfig httpd on

cd /var/www/html
echo "<html>" > index.html

echo "<h1 style='color:blue;'>Welcome to Udemy instance - A</h1>" >> index.html
echo "<h4 style='color:red;'>You are running instance from this IP (For debug only!!!!Do not public this to user):</h4>" >> index.html

export TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`

echo "<br>Private IP: " >> index.html
curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/local-ipv4 >> index.html

echo "<br>Public IP: " >> index.html
curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/public-ipv4 >> index.html
echo "</html>" >> index.html
```

```bash
#!/bin/bash
yum install httpd -y
service httpd start
chconfig httpd on

cd /var/www/html
echo "<html>" > index.html

echo "<h1 style='color:green;'>Welcome to Udemy instance - B</h1>" >> index.html
echo "<h4 style='color:red;'>You are running instance from this IP (For debug only!!!!Do not public this to user):</h4>" >> index.html

export TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`

echo "<br>Private IP: " >> index.html
curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/local-ipv4 >> index.html

echo "<br>Public IP: " >> index.html
curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/public-ipv4 >> index.html
echo "</html>" >> index.html
```

### Multi Target Group

5. Remove B khỏi tg-01, tạo **tg-02** và add B vào đó
6. Tạo thêm Listener port **8080**, trỏ tới tg-02
7. Truy cập ALB qua DNS:
   - `http://<alb-dns>:80` → instance A
   - `http://<alb-dns>:8080` → instance B
8. [Optional] Thiết lập tỷ lệ 1:3 cho traffic đến 2 eet group tg-01 và tg-02 trên cùng 1 listener port 80, thử truy cập xem ALB có điều hướng tới 2 targets theo đúng tỷ lệ không?
   - Xoá Listener 8080
   - Listener 80 - Add forward to target group - weight

---
