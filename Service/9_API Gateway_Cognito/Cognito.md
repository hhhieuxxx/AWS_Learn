### Cognito là gì?

AWS Cognito là một dịch vụ quản lý danh tính và xác thực người dùng của Amazon Web Services (AWS). Dịch vụ này cho phép bạn tạo ra các ứng dụng web và di động an toàn với khả năng xác thực người dùng, phân quyền, và đăng nhập với nhiều tùy chọn như user account, Social login hoặc đăng nhập qua nhà Identity Provider.

---

### Tính năng cơ bản của Cognito

- Đăng ký & Xác thực người dùng sử dụng username/pw/email hoặc tài khoản mạng xã hội.
- Phân quyền người dùng vào các ứng dụng hoặc tài nguyên.
- Xác thực email/số điện thoại.
- Tích hợp với các dịch vụ khác (API Gateway, Lambda) để xây dựng ứng dụng.
- Hỗ trợ cho ứng dụng di động (iOS, Android) thông qua SDK.
- Cognito sync: sync data giữa các mobile device với nhau.
- Advanced Security: giám sát & phân tích truy cập của user để phát hiện và ngăn chặn truy cập bất thường (optional).

---

## Pricing

- Số lượng Monthly Active User. VD ở Singapore là $0.0055/MAU (càng lên cao càng rẻ).
- User sign in thông qua SAML hoặc OIDC: $0.015/MAU.
- Tính năng Advance Security: $0.05/MAU nếu enable.
- SMS trong trường hợp gửi message MFA: Tuỳ theo khu vực.

---

## Hạn chế của Cognito

- Số lượng User trên 1 user pool: 40M (contact AWS nếu muốn tăng).
- Số lượng user pool tối đa: default 1,000, max 10,000.
- Custom attribute: 50.
- Hạn chế về tần suất Admin API call vd:
  - UserCreation: 50 RPS. Tăng thêm 10RPS cho mỗi 1 triệu MAU.
  - AdminUserRead: 120 RPS. Tăng thêm 40 RPS cho mỗi 1 triệu MAU.
  - Revoke Token: 120 RPS. Tăng thêm 40 RPS cho mỗi 1 triệu MAU.
  - UserUpdate: 25 RPS không thể tăng thêm.

---

## Lưu ý về cơ chế verify token của Cognito

JWT token do Cognito phát hành thông thường sẽ dùng client side verify (sử dụng Public Key do Cognito cung cấp.  
_Lưu ý AWS không cung cấp private key của Cognito._

Việc này đồng nghĩa với việc nếu user logout thì access-token vẫn có hiệu lực cho tới khi expired (vd 30 min).  
Nếu hệ thống có nhu cầu revoke access-token đã phát hành khi user có các hành động như change password, log-out thì không thể thực hiện với Cognito. Tất nhiên có thể workaround sử dụng các kỹ thuật Caching/DB.

![api](/img/cognito_verify.png)
