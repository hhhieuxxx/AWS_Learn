# CloudTrail

CloudTrail là dịch vụ ghi lại và giám sát các hoạt động (events) của người dùng, tài khoản, dịch vụ và tài nguyên trong AWS.  
Khác với CloudWatch (giám sát trạng thái resource), CloudTrail tập trung vào việc ghi lại "ai đã làm gì" trong môi trường AWS (who did what?).

---

## Chức năng chính

- **Ghi log sự kiện:** Ghi lại các thao tác như tạo, sửa, xóa resource, truy cập tài nguyên, thay đổi IAM roles, v.v.
- **Kiểm tra tuân thủ:** Hỗ trợ kiểm tra, audit và đảm bảo tuân thủ các quy định, chính sách bảo mật.
- **Phân tích & bảo mật:** Log CloudTrail giúp phát hiện sự cố bảo mật, điều tra và phản ứng với các sự kiện bất thường.
- **Tích hợp:** CloudTrail tích hợp với IAM, AWS Config, CloudWatch để quản lý và theo dõi toàn diện.
- **Lưu trữ log:** Log được lưu trữ trên S3, dễ dàng truy cập và phân tích.

---

## Lab CloudTrail – Bật trail và output log ra S3

1. Tạo Trail, cấu hình output log ra S3.
2. Thực hiện một số thao tác thay đổi resource (VD: tạo/xóa EC2, EBS).
3. Kiểm tra log CloudTrail trên S3.
4. Download và phân tích
