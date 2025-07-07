Giai đoạn 1: Nền tảng bảo mật AWS (Basic Security Foundation)
🔸 1. IAM (Identity and Access Management)

IAM user, group, role, policy (managed vs inline)

Trust relationship, assume role

MFA (Multi-Factor Authentication)

IAM best practices:

Principle of least privilege

Use roles over long-term access keys

Enable MFA for all accounts

🔸 2. AWS Root Account Protection

Không dùng root account cho mọi tác vụ

Kích hoạt MFA cho root

Tạo user admin IAM để sử dụng thường xuyên

🔸 3. AWS Organizations & SCPs

Quản lý nhiều tài khoản AWS

Dùng Service Control Policies (SCPs) để hạn chế quyền ở cấp account

🔸 4. Logging & Monitoring

AWS CloudTrail: ghi lại API call

AWS Config: theo dõi cấu hình tài nguyên

Amazon CloudWatch: log, alarm, dashboard

🛡️ Giai đoạn 2: Tăng cường bảo mật hệ thống (Intermediate Security)
🔸 5. Network Security

VPC, Subnet, Route Table

Security Groups vs Network ACLs

NAT Gateway, Internet Gateway

Private vs Public Subnet

VPC Flow Logs

🔸 6. Data Protection

Encryption at rest (S3, RDS, EBS): KMS, SSE-S3, SSE-KMS

Encryption in transit: HTTPS, TLS

AWS Certificate Manager (ACM)

🔸 7. Identity Federation & SSO

Kết nối IAM với Google, AD, Okta,...

SAML, OIDC

AWS Cognito (cho app web/mobile)

🔸 8. Secrets & Credential Management

AWS Secrets Manager vs Systems Manager Parameter Store

Rotate secrets tự động

Không hard-code secret vào code!

🔐 Giai đoạn 3: Bảo mật nâng cao (Advanced Security)
🔸 9. AWS Security Tools

AWS Inspector: quét lỗ hổng bảo mật cho EC2

Amazon GuardDuty: phát hiện mối đe dọa

AWS Shield: bảo vệ chống DDoS

AWS WAF: Web Application Firewall

Security Hub: tổng hợp cảnh báo từ các dịch vụ

🔸 10. Cross-account Access & STS

Dùng IAM Role + trust policy để truy cập tài khoản khác

Sử dụng sts:AssumeRole với CLI hoặc SDK

🔸 11. Incident Response & Audit

Xây dựng playbook xử lý sự cố

Dùng CloudTrail + S3 để lưu trữ log audit dài hạn
