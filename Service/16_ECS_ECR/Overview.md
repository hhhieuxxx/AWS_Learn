## Container

## Docker

## Sample

![sample](/img/ecr_ecs_sample.png)

## Lab 3 – Tạo và push image lên ECR

Yêu cầu: Build một custom image từ httpd, copy file index.html vào image. Tag và push image đó lên ECR.

1. Tạo một ECR repository vd: my-httpd
2. Tạo một Dockerfile theo mẫu cung cấp sẵn.
3. Build, tag image, push lên ECR theo chỉ dẫn.
4. Kiểm tra image đã được tạo ra tren ECR repository.

## Lab 3 – Tạo và push image lên ECR - Sử dụng cloud9

Cloud9: IDE chạy trên AWS, lập trình viên dùng để phát triển ứng dụng.

## Lab 4

![sample](/img/ecs_lab4.png)
Steps:

1. Tạo một ECS Cluster với mode Fargate
2. Tạo một task definition với các thông số cơ bản.
3. Truy cập vào Cluster, run một task với task definition đã tạo. Lưu ý enable public IP để có thể test truy cập.
4. Cấu hình security group nếu cần.
5. Thử truy cập tới public IP của Task (lưu ý số port).

## Lab 5

![sample](/img/ecs_lab5.png)
Steps:

1. Tạo task definition (có thể tái sử dụng ở bài lab trước).
2. Tạo một Target group với type là IP, không add bất cứ gì.
3. Tạo một Application Load Balancer có listener 80 trỏ tới Target Group
4. Tạo một service với task definition đã tạo, trong lúc tạo nhớ chọn ALB và Target Group tương ứng.
5. Đợi Service launch task thành công, test truy cập thông qua ALB.
6. Thử điều chỉnh số lượng task trong service (scale).
