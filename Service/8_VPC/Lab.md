## Lab 1

##### Thiết kế một VPC như sau (sử dụng drawio hoặc Powerpoint)

VPC CIDR: 10.0.0.0/16
Có 2 loại subnet Public, Private. Mỗi subnet chứa ít nhất 1000 IPs.
Mỗi loại subnets nằm ở ít nhất 2 AZ.
Có 1 Internet Gateway, cấu hình route table tới Internet Gateway.
Có 1 NAT Gateway, cấu hình route table tới NAT Gateway.

![dsd](/img/vpc_lab1_1.png)

##### Thiết kế security group cho 4 nhóm đối tượng:

Application Load Balancer (ALB): expose port HTTPS 443.
App Server cho phép port 80 từ ALB, 22 từ Bastion server.
Database Server sử dụng MySQL sd port: 3306. Elastic Search sd port: 9200.
Bastion Server: SSH port 22 từ IP công ty.
Thiết kế VPC Endpoint cho S3 service.

![dsd](/img/vpc_lab1_2.png)

## Lab 2 – Tạo VPC và các thành phần

Yêu cầu: Sử dụng AWS Console để tạo các resource đã thiết kế trong bài Lab 1

--> thực thế : tool aws, terraform, cloudformation, CDK
Thứ tự tạo resources;

1. VPC
2. Subnets
3. IGW
4. NAT GW
5. RouteTables (Public and Private).
6. VPC Endpoint for S3, Cấu hình route table private đi ra S3 End Point.
7. Security Groups.

![dsd](/img/vpc_lab3.png)
Yêu cầu sử dụng lại VPC của bài lab 2

1. Tạo 1 instance trong Public subnet, gán bastion-sg, thử kết nối.
2. Gán Elastic IP cho Instance, thử kết nối qua Elastic IP.
3. Tạo 1 instance trong Private subnet, gán app-sg, thử kết nối từ bastion.
4. Ping từ private instance ra internet (vd google.com).
5. Thử gỡ bỏ route đi ra NAT từ private subnet, thử thao tác với S3 từ private instance để check xem S3 Endpoint có hoạt động không. \*Chú ý gán Role cho EC2 instance.

### Trouble shoot lỗi connect

Khi các bạn bị lỗi không kết nối được tới EC2, có thể trouble shoot theo các step sau:

1. Check xem VPC có Internet Gateway chưa?
2. Check xem Security Group gán với instance có mở cho SSH từ ip của mình vô chưa?
3. Check xem Route Table gán vô subnet chưa EC2 có rule đi ra Internet Gateway chưa?
4. Check xem EC2 có Public IP hoặc Elastic IP chưa?
5. Check xem Network ACL gán với subnet chứa EC2 có allow cả 2 chiều Inbound/Outbound chưa?
6. Nếu check hết các issue trên vẫn OK có thể do OS treo -> Restart EC2.

### Clear

1. Xoá VPC
2. Xoá Elastic IP (nếu còn lại)
3. Xoá NAT Gateway (nếu còn lại)
4. Terminate instance (nếu có)
5. Xoá snapshot (nếu còn lại)
6. Xoá volume (nếu còn lại)

## Lab 2 - Bonus: Tạo VPC all-in-one-step.

Yêu cầu:

1. Tạo VPC và các resource liên quan bằng cách sử dụng giao diện VPC mới của AWS.
2. Số lượng public subnet: 2
3. Số lượng private subnet: 4
4. Có gắn NAT, số lượng NAT: 1
5. Có gắn VPC Endpoint cho S3.
6. Riêng security group các bạn phải tự tạo (tương tự bài lap trước nên không cần thực hiện lại).
7. Confirm các resource được tạo ra.
8. Xoá VPC đã tạo để tránh phát sinh chi phí.

## Lab 3 – VPC Peering

Steps:

1. Tạo nhanh 2 VPC có CIDR không overlap (vd 10.0.0.0/16 và 10.1.0.0/16). Không cần tạo Nat Gateway. Mỗi VPC có 2 subnet public. \*hai VPC có thể khác account.
2. Tạo 2 security group đơn giản vd: vpc-01-sg, vpc-02-sg
3. Tạo và accept VPC Peering cho 2 VPC.
4. Modify route table cho cả 2 VPC để nhận biết CIDR của nhau.
5. Modify security group của VPC-02, allow traffic từ CIDR của VPC-01
6. Tạo 2 EC2 instance nằm trong 2 VPCs, thử ping từ Instance trong VPC-01 sang instance trong VPC-02 bằng private IP.
7. Clear các resource đã tạo để tránh phát sinh chi phí.
   ![dsd](/img/vpc_lab_peer.png)
