# Simple Email Service (SES)

Amazon Simple Email Service (SES) is a cloud-based email sending service designed to help businesses send marketing, notification, and transactional emails reliably and at scale.

## Key Features

- **Email Sending:** Send emails from your application or cloud infrastructure using SMTP or AWS SDK.
- **Recipient Management:** Manage and store recipient lists.
- **Authentication & Security:** Supports DKIM, SPF, and DMARC to ensure email authenticity and prevent spoofing.
- **Activity Logging:** Provides detailed logs for sent emails, including sender, recipient, timestamp, and delivery status.
- **Integration:** Easily integrates with other AWS services like Lambda, S3, and SNS for automation and event-driven workflows.

> Note: SES is primarily for sending emails. Receiving and processing incoming emails is limited; for full inbound email features, consider Amazon WorkMail or SNS.

---

## Pricing

- **Email sending:** $0.10 per 1,000 emails
- **Attachments:** $0.12 per 1 GB of attachments
- **Additional options:** Charges apply for Dedicated IPs, Virtual Deliverability Manager, etc.

For the latest pricing, refer to the [AWS SES Pricing page](https://aws.amazon.com/ses/pricing/).

---

## Reputation Metrics

SES provides metrics to monitor your sender reputation, such as bounce rate and complaint rate. Monitoring these metrics is crucial to maintain high deliverability and avoid sending limits or throttling.

---

## Lab 5 - SES cơ bản

Yêu cầu: Sử dụng SES để gửi mail ở chế độ sandbox.  
_Sandbox mode chỉ cho phép gửi mail tới danh sách email đã xác thực trước (đã đăng ký vào SNS hoặc xác thực qua SES)._

1. Truy cập vào SES.
2. Tạo một Domain.
3. Đăng ký một email.
4. Gửi mail từ SES.
5. Kiểm tra định dạng mail nhận được.

---

## Lab 6 - Bật production mode cho SES

Để có thể gửi email tới bất kỳ địa chỉ nào, SES cần được bật production mode.  
_Nếu chưa bật production mode, bạn chỉ gửi được mail tới các email đã xác thực trước (sandbox mode)._

Để enable production mode, AWS yêu cầu cung cấp các thông tin:

- Nguồn lấy email từ đâu?
- Email được gửi trong các use case nào? (marketing, hướng dẫn, giao dịch...)
- Làm sao để user có thể hủy đăng ký nhận email (unsubscribe)?
- Bạn làm gì để hạn chế gửi mail tới địa chỉ không tồn tại (bounce email)?

Sau khi xem xét các yếu tố trên, AWS sẽ quyết định có bật production mode cho bạn hay không.

**Lưu ý sau khi đã enable production mode:**

- Luôn theo dõi chỉ số Bounce Rate, Complaint Rate và thiết lập cảnh báo để xử lý kịp thời.
- Theo dõi limit gửi mail của SES để chủ động yêu cầu nâng hạn mức khi gần chạm ngưỡng
