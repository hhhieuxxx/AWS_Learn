# AWS EventBridge

AWS EventBridge là một dịch vụ dùng để quản lý và định tuyến sự kiện trong hệ thống. Nó cho phép bạn theo dõi, xử lý và phản ứng tự động với các sự kiện từ các nguồn khác nhau trong môi trường AWS Cloud.

EventBridge hoạt động dựa trên kiến trúc publish-subscribe, trong đó event source gửi sự kiện của mình tới EventBridge. EventBridge sau đó định tuyến sự kiện tới các event targets đã được đăng ký, ví dụ các Lambda function, SQS, WorkFlow, các dịch vụ AWS khác hoặc các ứng dụng tự xây dựng.

EventBridge cung cấp khả năng linh hoạt trong việc quản lý các quy tắc định tuyến sự kiện (event rules), cho phép bạn lọc và xử lý sự kiện theo các tiêu chí như kiểu sự kiện, nguồn sự kiện, hoặc nội dung sự kiện. Bạn có thể sử dụng các quy tắc này để triển khai tự động các tác vụ, như kích hoạt các hàm Lambda để xử lý sự kiện, gửi thông báo qua email hoặc SMS, hoặc đưa sự kiện vào các workflow phức tạp hơn.

Với EventBridge, bạn có thể xây dựng các hệ thống ứng dụng phản ứng thời gian thực, tự động và linh hoạt hơn trong môi trường đám mây AWS, giúp giảm thời gian triển khai và tăng khả năng mở rộng, module hóa của hệ thống.

---

## Kết hợp

EventBridge có thể tích hợp với nhiều dịch vụ AWS khác như:

- CodePipeline
- EC2
- Lambda

Có thể phát sinh events thông qua các rule đến:

- Lambda
- SNS
- SQS
- Kinesis
- StepFunction

Tham khảo: [AWS EventBridge Documentation](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-what-is.html)

---

## Concepts

- **Event:** Một sự kiện xảy ra trong hệ thống AWS hoặc được chủ động tạo ra.
- **Rule:** Quy định các event và message sẽ được xử lý như thế nào nếu match rule.
- **Event Bus:** Kênh giao tiếp để nhận và gửi event.
- **Schema:** Định nghĩa cấu trúc của event được gửi tới EventBridge.
- **Schema registry:** Nơi lưu trữ những schema được detect tự động hoặc tạo bởi user.
- **Pipes:** Phương thức nhanh chóng để kết nối source và target. Có thể apply filter hoặc enrichment (transform) cho data.
- **Scheduler:** Đặt lịch cho các tác vụ.

---

## Use case

### Event buses

Tham khảo: [Event buses](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-event-bus.html)

---

## Pipes

Tham khảo: [Pipes](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-pipes.html)

---

### Scheduler

---

## Lab 1 - Thao tác cơ bản với EventBridge

1. Login to AWS console -> EventBridge.
2. Tạo một Event Bus, ví dụ: `udemy-test-event-bus`.
3. Tạo một SQS queue và một SNS topic (topic có subscriber là một email).
4. Thiết lập rule filter trên EventBridge bus: nếu có `sendTarget = SQS` thì gửi tới queue, `sendTarget = SNS` thì gửi tới topic.
5. Thực hiện gửi 2 message tới event bus, kiểm tra message có được gửi tới SQS và SNS tương ứng không.

---

## Lab 2 - Capture sự kiện với EventBridge

Sử dụng EventBridge để capture các event liên quan tới một loại resource, ví dụ EC2. Khi có sự kiện xảy ra đối với resource sẽ notify tới người quản lý.

**Steps:**

1. Tạo một event rule bắt các sự kiện liên quan EC2. _Lưu ý chọn event bus "default"._
2. Cấu hình notify sang SNS topic.
3. Thử tạo EC2 instance, bật/tắt EC2 instance.
4. Kiểm tra email xem event có notify tới không.
