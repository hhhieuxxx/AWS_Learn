#### Root User

- Root account, unlimited policy - should not use often

## IAM Users

- `Account Alias` : change ID account to alias

## IAM Groups

Organize IAM users and manage their permissions collectively.

## IAM Policy

Policy là các điều khoản được tạo hoặc chỉ định để kiểm soát quyền truy cập vào tài nguyên của AWS. Quy định việc ai/cái gì có thể hoặc không thể làm gì.
Một policy thường bao gồm nhiều Statement quy định Allow/Deny hành động trên resource dựa trên condition.
Mỗi statement cần định nghĩa các thông tin:

- Effect: có 2 loại là Allow & Deny. \*Deny được ưu tiên hơn.
- Action: tập hợp các action cho phép thực thi.
- Resource: tập hợp các resource cho phép tương tác.
- [Condition]: Điều kiện kèm theo để apply statement này.
  Policy có thể gắn vào Role/Group/User.

Policy có 2 loại là:

- Inline Policy : được đính trực tiếp lên Role/User/Group và không thể tái sử dụng ở Role/User/Group khác
- Managed Policy: được đính trực tiếp lên Role/User/Group và không thể tái sử dụng
  - AWS Managed
  - User Managed
    Việc lựa chọn giữa Inline vs Managed phải được tính toán dựa trên các yếu tố như: tính tái sử dụng, quản lý thay đổi tập trung, versioning & rollback

_IAM Policy Simulator_: mô phỏng policy được tạo ra có đúng hay không - AWS Policy Generator

**Permission Boundary**: Giới hạn quyền

Identity-based Policy và Resource-based Policy và Permission Boundary

<img src="/img/mdh_policy.png" alt="Alt Text" width="600" height="300">

Service Control Policy với AWS Organization

#### Policy vs Resource Policy

Một số resouce như S3, SQS, KMS hỗ trợ định nghĩa policy ở cấp độ resource.

Quyền của một user (group/role) đối với resource = IAM Policy + Resource Policy sau khi đã loại trừ Deny.

Một số resource cần security cao sẽ thường được ưu tiên setting resource policy.

Lưu ý: IAM Policy nói chung không có tác dụng đối với account root.
=>Nếu lỡ tay setting deny all không thao tác được trên một resource, có thể login = account root để chỉnh lại.

## IAM Role

- Đại diện cho 1 quyền trên AWS.
- Sử dụng khi muốn cấp quyền cho 1 thực thể có thể tương tác với các resources khác trên AWS

  VD: EC2 - S3 : từ EC2 config api key call tới S3 (không nên) - create Role - EC2/Actions/Sercurity/... add role

- Có thể sử dụng để cấp quyền cho 1 user nằm ở AWS account khác mà không muốn tạo ra user profile cho họ trên acc của mình. (Cho phép 1 user assume-role tới 1 role trên account)

> Lưu ý: một resource trên AWS không thể tương tác với resource khác nếu không được gán Role với các quyền thích hợp.

#### Assume Role

Một thực thể (IAM user, app, service) tạm thời nhận quyền hạn của một IAM Role khác để thực hiện các tác vụ mà không cần có quyền trực tiếp

Usecase: cấp quyền tạm thời mà không muốn tạo nhiều user, quản lý tập trung user thông qua Single-Sign-On thay vì tạo user trên từng account

<img src="/img/assumeRole.png" alt="Alt Text" width="400" height="300">
<img src="/img/assumeRole2.png" alt="Alt Text" width="400" height="300">

#### Switch Role

Một IAM user có thể chuyển đổi sang một IAM Role khác để tạm thời nhận quyền hạn của role
<img src="/img/switch.jpg" alt="Alt Text" width="250" height="100">

#### Trust Policy

Quy định đối tượng nào có thể assume sang role được gắn trust policy này.
Đối tượng được trust có thể là User/Role/AWS service.
\*Trong rất nhiều trường hợp các dịch vụ của AWS cần được setting trust policy một cách tường minh để có thể assume sang một role cần thiết.

<img src="/img/trustPolicy.png" alt="Alt Text" width="600" height="300">

## Best Practices

Sử dụng group để gán quyền cho các user.
Cấp quyền vừa đủ cho user, không cấp quá dư thừa.
Chú ý các deny rule khi thiết kế policy để tránh bị conflict permission giữa các group (group này allow nhưng group kia deny).
Luôn force MFA cho các IAM user (không bật MFA sẽ không xài dc console)
Sử dụng Role khi muốn cấp quyền cho server/ứng dụng. Access/Secret key chỉ dùng để sử dụng khi gõ CLI trên local hoặc test các app đang trong quá trình phát triển.
Tuyệt đối KHÔNG share User hoặc Access/Secret key giữa các member trong dự án.

#### IAM Quotas

Federation là quá trình cho phép người dùng bên ngoài AWS truy cập vào tài nguyên AWS mà không cần tạo tài khoản IAM riêng. Thay vào đó, họ có thể đăng nhập bằng danh tính từ một Identity Provider (IdP) như Google, Microsoft Active Directory, Okta, v.v.

Các phương thức Federation phổ biến:
SAML 2.0 Federation – Dùng cho doanh nghiệp có hệ thống xác thực riêng.

OpenID Connect (OIDC) – Dùng cho ứng dụng web và di động.

AWS IAM Identity Center (trước đây là AWS SSO) – Quản lý truy cập tập trung cho nhiều tài khoản AWS.
