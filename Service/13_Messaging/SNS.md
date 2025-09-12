## Simple Notification Service - SNS

AWS Simple Notification Service (SNS) is a fully managed notification service that enables you to send messages to various endpoints such as applications, users, systems, or other AWS services.  
SNS supports multiple delivery methods including email, SMS, push notifications, and API calls. You can create and manage topics in SNS, and then publish messages to those topics. All subscribers to a topic will receive the published messages.

---

## Features

- **Publisher-Subscriber Model:** SNS operates on a pub/sub model. When a publisher sends a message to an SNS topic, the message is delivered to all subscribers.
- **Multi-channel Notification:** Supports email, SMS, push notifications (e.g., mobile), and API calls.
- **Scalable and Reliable:** SNS automatically handles scaling and ensures reliable message delivery across AWS infrastructure.
- **Integration with AWS Services:** SNS integrates seamlessly with other AWS services such as SQS, CloudWatch, Lambda, EC2, and more, enabling you to build complex and automated notification workflows.
- **FIFO Support:** SNS supports FIFO topics similar to SQS for ordered message delivery.
- **Message Attributes:** Allows storing additional metadata with each message.
- **Message Filtering:** Enables filtering rules to control which subscribers receive specific messages.
- **Message Security:** Integrates with KMS for message encryption and enhanced security.

---

## Concepts

SNS can integrate with various AWS services and notify multiple types of external targets.

---

## Use Cases

- Send notifications to email/SMS for alerting and notification services.
- Integrate with monitoring, audit, and security services to notify responsible personnel.
- Notify mobile applications.
- Simultaneously send notifications to multiple targets in real time.
- Build distributed systems and chat applications.

---

## Pricing

SNS charges based on the type and volume of notifications sent:

- **Mobile push:** $0.50 per 1M notifications
- **Email:** $1 per 1M notifications
- **HTTP:** $0.60 per 1M notifications
- **Data transfer:**
  - Transfer in: Free
  - Transfer out: $0.12/GB
- **SMS:** Cost varies by country
- **Message filter:** $0.11 per GB of payload data scanned

For the latest pricing, refer to the [SNS Pricing Page](https://aws.amazon.com/sns/pricing/).

## Lab 3 - Thao tác cơ bản với SNS

1. Tạo SNS topic
2. Subscribe một email vào.
3. Vào email và confirm subscription.
4. Thử push một mesage lên SNS
5. Kiểm tra Email.

## Lab 4 - Message filter

Mục tiêu của bài lab là hướng dẫn các bạn làm quen với message filter.
Ta có một topic với 2 subscriber, một là lambda function và một là SQS. Setting message filter theo rule nếu có attribute sendTo=LAMBDA thì gửi sang lambda, nếu sendTo=SQS thì gửi sang SQS.

Steps

1. Tạo một SNS Topic với setting cơ bản.
2. Tạo một lambda function Python có chức năng in ra message đã notify tới nó.
3. Subscribe lambda function vào SNS topic.
4. Tạo một SQS với setting cơ bản (có thể sơ lại queue ở bài lab trước).
5. Subscribe SQS vào SNS topic.
6. Setting message filter tương ứng như đề bài yêu cầu.
7. Send message với 2 thuộc tỉnh khác nhau và kiểm tra kết quả.
