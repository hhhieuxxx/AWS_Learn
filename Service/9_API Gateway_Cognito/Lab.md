## Lab 1 - API Gateway + lambda backend

Yêu cầu: Tạo 1 API Gateway có chức năng nhận request từ client, forward tới Lambda backend xử lý sau đó response.

## Lab-API Key & Usage plan

Yêu cầu: Sử dụng lại API đã tạo ở bài lab trước
Add Usage plan và API Key cho API
Gán Usage plan & API key vào API Gateway, deploy lại lên stage dev.
Bổ sung x-api-key vào request header trong postman.
Call API từ postman -> kiểm tra kết quả.

## Lab 2- Cognito basic operation

Yêu cầu
Login to AWS -> Cognito
Tạo một user pool với các thông tin cơ bản
Username, cho phép dùng email đã verify làm usernam
Cho phép tuỳ chọn username (user có thể change)
Tạo thử một user
Tạo thử một group, gán user vào group

## Lab 3- Sử dụng Cognito Hosted UI

Tạo một App Client (nếu chưa tạo).
Sử dụng Hosted UI để tiến hành Login, Lấy code
Sử dụng code python mẫu để exchange code -> token.
Sử dụng JWT Tool để decrypt token xem bên trong có gì.

## Lab 4- Combine Cognito with API Gateway

Yêu cầu đã có một API Gateway chạy được với method đơn giản
Cấu hình Authorizer cho API Gateway sử dụng Cognito user pool đã tạo
Sử dụng hosted UI + code python (Lab3) để login và lấy token.
Thử truy cập API mà không có token -> Access Denied
Thử truy cập API có token lấy được từ step trước -> Allow.

![api](/img/cognito_lab4.png)
