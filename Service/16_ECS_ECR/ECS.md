# Amazon Elastic Container Service (ECS)

## 1. Khái niệm cơ bản

- **ECS** là dịch vụ **orchestration** (điều phối container) của AWS, hỗ trợ chạy và quản lý các container Docker trên quy mô lớn.
- Tích hợp sẵn với các dịch vụ AWS khác như **EC2, Fargate, ECR, CloudWatch, IAM**, giúp xây dựng kiến trúc microservices linh hoạt.

## 2. Các thành phần chính

- **Task Definition**: File JSON mô tả cách chạy container (image, CPU/RAM, port, volume, env variables).
- **Task**: Một instance của Task Definition (có thể chạy một hoặc nhiều container).
- **Service**: Giúp duy trì số lượng Task luôn chạy (auto-scaling, load balancing).
- **Cluster**: Nhóm các tài nguyên (EC2 instances hoặc Fargate) để chạy Task.
- **Container Agent**: Phần mềm chạy trên EC2 instances để giao tiếp với ECS.

## 3. Hai chế độ triển khai

### EC2 Launch Type

- Bạn tự quản lý máy chủ EC2 để chạy container.
- Kiểm soát nhiều hơn nhưng phải tự scale và patch OS.

### Fargate Launch Type

- Serverless, không cần quản lý EC2.
- AWS tự động cấp phát tài nguyên (CPU/RAM) cho container.
- Chỉ trả tiền cho tài nguyên sử dụng.

## 4. Tính năng nổi bật

- **Tích hợp với ALB/NLB**: Cân bằng tải cho container.
- **Auto Scaling**: Tự động mở rộng dựa trên CloudWatch metrics.
- **Security**: Hỗ trợ IAM roles, security groups, và mã hóa dữ liệu.
- **Logging & Monitoring**: Logs đẩy về CloudWatch, tích hợp AWS X-Ray để theo dõi hiệu năng.
- **Service Discovery**: Tự động đăng ký và phát hiện dịch vụ qua AWS Cloud Map.

## 5. So sánh với các dịch vụ khác

| Tính năng       | ECS                    | EKS                          |
| --------------- | ---------------------- | ---------------------------- |
| Độ phức tạp     | Đơn giản, native AWS   | Phức tạp (dùng Kubernetes)   |
| Di động         | Gắn với AWS            | Đa nền tảng (multi-cloud)    |
| Quản lý hạ tầng | Tùy chọn (EC2/Fargate) | Tự quản lý hoặc dùng Managed |

## 7. Ví dụ triển khai đơn giản

1. **Tạo Task Definition**: Khai báo container từ image Docker (lưu ở ECR).
2. **Tạo Cluster**: Chọn EC2 hoặc Fargate.
3. **Chạy Task/Service**: Khởi chạy container và gắn vào Load Balancer (nếu cần).

## 8. Giá cả

- **EC2 Launch Type**: Trả tiền cho EC2 instances + EBS volumes.
- **Fargate**: Trả theo vCPU và RAM sử dụng (tính theo giây).

ECS là lựa chọn tốt nếu bạn cần một dịch vụ container đơn giản, tích hợp sâu với AWS. Nếu cần hỗ trợ đa nền tảng, có thể xem xét **EKS** (Kubernetes). Fargate phù hợp cho workload không thường xuyên hoặc không muốn quản lý server.
