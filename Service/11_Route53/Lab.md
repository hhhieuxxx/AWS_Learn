## Lab 1 – Mua tên miền sử dụng Route 53

Yêu cầu chuẩn bị sẵn $3 trong thẻ liên kết với AWS
Steps:

1. Login vào AWS Console, vào dịch vụ Route 53
2. Kiểm tra một tên miền xem còn available không?
   \*Có thể chọn tên miền .click, giá khoảng $3/năm cho rẻ.
3. Sau khi kiểm tra tên miền available, tiến hành add to cart và thanh toán.
4. Đợi tên miền activate thành công.
5. Kiểm tra hosted zone được tạo ra với type là public.

## Lab 2 – Thực hành với A Record

Yêu cầu có sẵn một tên miền với public hosted zone (Lab 1)
Steps:

1. Login vào AWS Console, tạo một EC2 instance với website đơn giản (xem lại bài EC2).
2. Test access thành công bằng public IP.
3. Vào dịch vụ Route 53
4. Tạo một sub domain với type A-Record. Vd testserver.linhnguyen.click, value trỏ đến Public
   IP của Instance.
5. Test truy cập bằng sub-domain vừa tạo.

## Lab 3 – Thực hành với C-Name

*Yêu cầu có sẵn một tên miền với hosted zone (public)
*Yêu cầu có sẵn một CloudFront trỏ tới website đang hoạt động (Xem lại bài CloudFront)

Steps:

1. Login vào AWS Console, vào dịch vụ Route 53
2. Tạo một sub domain với type C-Name. Vd website.linhnguyen.click, value trỏ đến DNS của cloudfront.
3. Config Alternate domain names in CloudFont

   - Cần tạo cert ACM với domain website.linhnguyen.click or \*.linhnguyen.click -->
   - Create CName record for ACM
     - name (bỏ tên miền)
     - value
   - Add Alternate domain names in CloudFont
   - SSL cert

4. Test truy cập bằng sub-domain vừa tạo.

## Lab 4 – Thực hành với A Record

\*Yêu cầu sử dụng lại EC2 có website đã hoạt động (hoặc tạo lại nếu xoá rồi).
Steps:

1. Login vào AWS Console, vào dịch vụ Route 53
2. Tạo một Health Check trỏ tới Instance Public IP
3. Setting các thông số: protocol: HTTP, Interval: 5s, threshold: 3.
4. Setting CloudWatch alarm -> SNS -> Emall.
5. Login vào server, stop service httpd.
6. Kiểm tra Alarm status và Notification tới Email đã subscribe

## Lab 5 – Thực hành với Private Hosted zone

\*Lưu ý bài lab sẽ mất phí khoảng $0.5
Steps:

1. Tạo nhanh 2 EC2 instance (không cần cài web), login thành công. Đặt tên là Server A/B
2. Vào dịch vụ Route 53
3. Tạo một Private Hosted zone tương ứng với một VPC. Vd: udemy.local
4. Tạo một A-Record trên hosted zone trỏ tới Server A/B private tương ứng
   vd: server-a.udemy.local, server-b.udemy.local
5. Cấu hình security group cho phép 2 server ping nhau.
6. Thử ping lẫn nhau bằng Private IP
7. Thử ping lẫn nhau bằng sub-domain đã tạo ở bước trên.
