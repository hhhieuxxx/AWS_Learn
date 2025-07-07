## Lab 1

1. Tạo 1 Group "developer-group" có quyền AdministratorAccess (managed policy)
2. Create 1 user "developer-01" Add 1 user vào "developer-group"
3. Login vào console, thử thực hiện 1 vài thao tác Launch Instance, create S3 bucket, upload, download.
4. Tạo thêm group "tester-group" có quyền "Readonly Access" (managed policy)
5. Thêm custom policy "deny-delete-object-s3" vào group "tester-group"
6. Add user "developer-01" vào "tester-group"
7. Thử dùng "developer-01" xóa 1 object trên s3 => expect deny

## Lab 2

1. Remove "developer-01" from "tester-group"
2. Operation S3
3. Create Resource Policy Deny All S3
4. Try Upload to S3

## Lab 3

1. Phát hành access key/secret key cho user đã tạo ở Lab1
2. Thiết lập access key/ secret key cho AWS CLI
3. Tương tác với 1 vài service bằng CLI.
4. Tạo policy enforce-mfa-policy và gắn vào "developer-group"
5. Thử gõ lại CLI xem còn xài dc ko?
6. Cài MFA cho user "developer-01"
7. Thiết lập sesssion_token sử dụng MFA code.
8. Gõ lệnh CLI sử dụng profile đã có MFA

## Lab 4

Create a role with full access to a specified S3 bucket.
Create an EC2 instance and attach it to the created role.
Log in to the EC2 instance.
Operate files using the CLI (Amazon Linux includes the CLI).

## Lab 5

1. Gỡ toàn bộ quyền/policy của user đã được tạo ở lab1. Remove user ra khỏi group.
2. Attach 1 policy cho phép user có thể PassRole.
3. Tạo 1 role có quyền PowerUser, thiết lập trust policy cho phép user ở trên có thể assume role.
4. Thử thực hiện 1 action (vd list s3) sửaccess/secret key của user => bị deny không thể access.
5. Assume role sang Role vừa tạo ở step 3 (Sử dụng CLI).
6. Sử dụng access/secret key lấy được trong quá trình assume role để thao tác với resource (vd list s3, download, upload file) => có thể access
