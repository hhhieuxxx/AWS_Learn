## Lab 3

1. Yêu cầu chuẩn bị một file text có nội dung bất kỳ
2. Bật tính năng versioning của Bucket lên.
3. Upload file lên S3.
4. Chỉnh sửa nội dung, upload file với cùng tên. Confirm xem có một version mới được tạo ra? I
5. Tiến hành xoá file. Kiểm tra versioning với Delete flag.
6. Phục hồi file đã bị xoá bằng cách xoá Delete flag.
7. Tắt versioning.
8. Chỉnh sửa nội dung, upload file với cùng tên. Confirm xem file có bị ghi đè? Các version trước khi tắt versioning có còn không?

## Lab 4

1. Yêu cầu đã cài sẵn AWS CLI và thiết lập profile tại máy local
2. Upload 1 file bất kì lên S3
3. Tham khảo câu lệnh sau để phát hành 1 presign url cho object trên s3
   https://docs.aws.amazon.com/cli/latest/reference/s3/presign.html
4. Sử dụng URL để download file trên trình duyệt.
5. Đợi hết thời gian hiệu lực của url, thử lại => expired.

## Lab 5

Test Storage Class

1. Upload 1 file và chọn storage class là Standard IA
2. Upload 1 file và chọn storage class là OneZone IA
3. Upload 1 file và chọn storage class là Glacier Instant Retrieval
4. Upload 1 file và chọn storage class là Glacier Flexible Retrival
5. Access 1 file được lưu trữ dưới class Glacier
6. Xoá các file đã upload

## Lab 6 - Lyfe Cycle

1. Tạo 1 life cycle rule move object trong 1 folder vd /log xuống Glacier sau 90 ngày.
2. Tạo 1 life cycle rule xoá hoàn toàn object sau 270 ngày.

## Lab 7 - S3 Static Website Hosting

1. Chuẩn bị 1 bộ source HTML tĩnh (có thể là static files build ra từ Angular/NodeJS...).
2. Upload source lên s3 (lưu ý file index.html phải ở level gốc)
3. Bật s3 static web hosting
4. Cấu hình open public access bucket
5. Cấu hình bucket policy cho phep mọi người access.

```bash
{
   "Version": "2012-10-17",
   "Statement": [
      {
      "Sid": "Statement1",
      "Effect": "Allow",
      "Principal":"*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3::::udemy-aws-cloud-linh/*"
      }
   ]
}

```

7. Test truy cập từ trình duyệt.

## Lab 8 - Combine S3 event with Lambda

1. Tạo 1 lambda function đơn giản với chức năng in ra event nhận được từ S3 bao gồm tên bucket, object key (code python)
2. Thiết lập s3 trigger sang lambda khi có ai đó upload file.
3. Test upload 1 file bất kì.
4. Check xem lambda có được kích hoạt và chạy thành công không.
