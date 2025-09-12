## Lab 1 – Sử dụng CloudFront để host static web

\*Yêu cầu đã học qua bài S3, biết cách host một website tĩnh lên S3 bucket.

1. Chuẩn bị 1 website tĩnh, nếu có vài hình size lớn (>5mb) thì càng tốt.
2. Thực hiện host website tĩnh sử dụng S3.
3. Tạo CloudFront distribution, đăng ký S3 làm origin.
4. Thử truy cập thông qua CloudFront, so sánh tốc độ khi truy cập trực tiếp S3.
5. Disable public access cho S3, tạo OAI cho CloudFront, thiết lập policy chỉ cho phép truy cập resource thông qua CloudFront.
6. [Optional] phát hành SSL certificate và sử dụng CloudFront custom domain. Mua 1 tên miền và trỏ sang CloudFront, truy cập thông qua domain đã setting.
   \*Phần này bài Route53 sẽ được trình bày rõ hơn.

## Lab 2 - CloudFront + API Gateway + S3

*Yêu cầu đã học qua bài S3, biết cách host một website tĩnh lên S3 bucket.
*Yêu cầu đã học qua bài API Gateway, biết cách deploy một API đơn giản.

1. Chuẩn bị 1 website tĩnh deploy lên S3.
2. Tạo một API Gateway đơn giản, deploy thành một stage.
3. Tạo CloudFront distribution, đăng ký S3 làm origin (hoặc tái sử dụng lại bài lab 1)
4. Add thêm origin cho API Gateway.
5. Cấu hình behavior phù hợp cho API Gateway và S3.
6. Cấu hình Caching Behavior No-Cache cho API Gateway.
7. Modify code backend thử in ra request header (cần enable Proxy trên API GW)
8. Cấu hình forward một header vd "Source" = "CloudFront"

## Lab 3 – Sử dụng CloudFront cho single-page

\*Yêu cầu đã xem qua bài S3, biết cách host một website tĩnh lên S3 bucket.

1. Upload source lên S3, enable static website, liên kết với CloudFront, test truy cập thông qua cloudfront (nhớ thêm /index.html phía sau).
2. Cấu hình Lambda@Edge cho origin Website, nhiệm vụ của Lambda@Edge này là thêm index.html vào mỗi request rồi forward tiếp. \*Đặc trưng của single page là luôn luôn phải có index.html, nếu client không được redirect tới 1 file có trên origin, CloudFront sẽ trả về lỗi 403.
3. Thử truy cập website mà không cần có index.html ở phía sau.
