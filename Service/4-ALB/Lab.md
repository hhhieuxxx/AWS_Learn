### Lab cơ bản

1. Tạo 2 EC2 Instance: A và B (dùng userdata khác nhau để dễ phân biệt)
2. Tạo **Target Group tg-01**, add A & B
3. Tạo **ALB**, cấu hình Listener port 80 trỏ vào tg-01
4. Truy cập ALB thông qua DNS link

### Multi Target Group

5. Remove B khỏi tg-01, tạo **tg-02** và add B vào đó
6. Tạo thêm Listener port **8080**, trỏ tới tg-02
7. Truy cập ALB qua DNS:
   - `http://<alb-dns>:80` → instance A
   - `http://<alb-dns>:8080` → instance B

### Traffic Ratio (Optional)

8. Cấu hình **weight routing**: tg-01 (A) nhận 25%, tg-02 (B) nhận 75%
9. Truy cập và kiểm tra tỉ lệ load thực tế

---

## Tổng kết

- Load Balancer giúp hệ thống có tính **sẵn sàng cao** và dễ **mở rộng**
- Tránh SPOF bằng cách triển khai multi-AZ và sử dụng ELB
- AWS ELB hỗ trợ nhiều loại khác nhau phù hợp với từng use case
