## Lab 1 – Xử lý file upload lên S3 tự động

**Yêu cầu:**  
Tạo Lambda xử lý hình ảnh (.jpg, .png) được upload lên S3, resize thành nhiều size, lưu output vào thư mục tương ứng.

**Các bước thực hiện:**

1. Tạo Lambda Layer từ zip file cung cấp (chứa thư viện xử lý ảnh).
2. Tạo Lambda function Python, add layer đã tạo ở bước 1.
3. Cấu hình IAM Role cho Lambda, thêm policy S3FullAccess.
4. Thiết lập trigger từ S3 cho thư mục `/images`.
5. Upload thử một file .jpg lên S3.
6. Kiểm tra log của Lambda.
7. Kiểm tra các file resized đã được tạo và lưu đúng thư mục.

---

## Lab 2 – Bật/tắt EC2 instance theo lịch

**Yêu cầu:**  
Tạo Lambda bật/tắt EC2 instance theo lịch. Lambda nhận 2 tham số: `instance_id` và `action` (START, STOP). Thiết lập schedule bằng EventBridge.

**Các bước thực hiện:**

1. Tạo EC2 instance Linux.
2. Tạo Lambda function Python với code mẫu.
3. Cấp quyền EC2StartInstance/EC2StopInstance cho Lambda.
4. Thiết lập EventBridge event với lịch gần thời gian hiện tại, truyền tham số `{action: STOP, instance_id: <instance id>}`.
5. Đợi đến thời gian đã set, kiểm tra Lambda có được trigger và EC2 có được stop.
6. Thực hiện tương tự với action START: `{action: START, instance_id: <instance id>}`.

---

## Lab 3 – Xử lý data CSV lưu vào DynamoDB

**Yêu cầu:**  
Tạo Lambda nhận notification từ S3 khi có file CSV upload, đọc file và lưu vào DynamoDB table.

**Các bước thực hiện:**

1. Tạo table `employee` trong DynamoDB theo mẫu.
2. Tạo file CSV theo mẫu.
3. Tạo Lambda sử dụng code mẫu.
4. Cấu hình Memory và timeout (ví dụ: 512 MB, 2 phút).
5. Cấp quyền S3FullAccess & DynamoDBFullAccess cho Lambda.
6. Thiết lập trigger từ S3 sang Lambda.
7. Test upload file CSV lên S3.
8. Kiểm tra log Lambda function.
9. Kiểm tra kết quả data lưu vào DynamoDB Table!
