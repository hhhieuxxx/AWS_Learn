# Simple Queue Service - SQS

Simple Queue Service (SQS) là một dịch vụ hàng đợi thông điệp mạnh mẽ và dễ sử dụng từ AWS. SQS cho phép bạn truyền tin nhắn giữa các thành phần của hệ thống phân tán một cách đáng tin cậy và có khả năng mở rộng.

Với SQS, bạn có thể tạo ra các message queue và gửi/nhận message trên queue đó. Hàng đợi được quản lý bởi SQS, đảm bảo tính đáng tin cậy và khả năng mở rộng cao. Việc các ứng dụng khác nhau có gửi nhận message trên queue một cách độc lập giúp tăng tính chịu lỗi và sự phân tán trong hệ thống của bạn (de-coupling).

SQS cung cấp hai loại queue: **standard** & **FIFO (First-In-First-Out)**.

- Standard queue cung cấp khả năng mở rộng cao và đáng tin cậy,
- FIFO queue đảm bảo tin nhắn được xử lý theo tuần tự (nhược điểm là bị giới hạn về tần suất gửi nhận).

SQS cũng cung cấp các tính năng như chế độ retry tự động, message filtering và khả năng xác nhận (acknowledge) tin nhắn. Ngoài ra, SQS tích hợp với các dịch vụ AWS khác

## Đặc trưng của SQS

- SQS là một managed service do đó bạn không quản lý hạ tầng phía sau.
- SQS được tạo và quản lý dưới các đơn vị message queue.
- Tương tác gửi nhận message với queue thông qua Console, SDK, API.
- Khả năng mở rộng của SQS là không giới hạn (về lý thuyết).
- Về cơ bản message nào được gửi vào queue trước sẽ được xử lý trước (khi có hành động get message). Tuy nhiên với Queue type standard, AWS không đảm bảo 100%.
- Với FIFO Queue, SQS đảm bảo deliver đúng thứ tự tuy nhiên tần suất gửi nhận message bị giảm xuống 300/s và 3000/s đối với batch process.
- SQS có thể được cấu hình notify message sang Lambda mỗi khi có mesage mới, sử dụng cho bài toán xử lý tự động hoặc ETL.

---

## Concepts

SQS là nơi trung chuyển giữa một bên là **Message Producer (Sender)** và một bên là **Message Consumer (Receiver)**.

- Với Standard Queue, message khi được gửi vào queue sẽ tồn tại ở đó cho tới khi bị xoá hoặc hết thời gian retention. Do vậy Consumer phải chủ động xoá message đã xử lý xong.
- Với FIFO Queue, message sẽ được delivery chính xác 1 lần tới consumer (tự động bị xoá sau khi có event receive message).

![sqs](/img/sqs_flow.png)

---

### Visibility Timeout

Là thông số thời gian message tạm bị ẩn đi đối với các consumer trong khi message đó đang được receive bởi một consumer. Quá thời gian này nếu message chưa bị xoá sẽ quay trở lại queue.

Ví dụ về việc KHÔNG apply visibility timed out (hoặc timed out quá ngắn) trong trường hợp có nhiều consumer. Các consumer có thể get message đang được xử lý bởi một consumer khác (chưa finished).

![sqs](/img/sqs_Visibility_Timeout.png)

Việc apply Visibility Timeout như thế nào cho phù hợp hoàn toàn phụ thuộc vào nghiệp vụ của bạn. VD một tác vụ xử lý decode một video mất 10 mins thì bạn nên để Visibility Timeout >10 phút để tránh tình trạng xung đột xử lý giữa các consumers.

![sqs](/img/sqs_Visibility_Timeout2.png)

---

### Receive count

Message mỗi khi được receive sẽ có một thông số receive count (được cộng lên +1 mỗi khi message đó được receive bởi một consumer), ta có thể dựa vào đó để setting dead letter queue (tự động move message đã bị xử lý quá số lần mà vẫn chưa thành công).

![sqs](/img/sqs_rec_count.png)

Ví dụ: hình dưới ta có 2 queue, apply dead-letter queue với receive count = 5, khi tới ngưỡng giới hạn mà message vẫn chưa được xử lý thành công và xoá khỏi queue, ta sẽ move sang một queue khác (dead-letter queue) để xử lý sau.

---

### Long polling

Long polling wait time: thời gian SQS chờ trước khi trả về empty cho consumer nếu không có message trong queue.

![sqs](/img/sqs_polling_time.png)

---

## Limit

- Số lượng message trên một queue: unlimited
- Queue name: 80 characters
- Queue tag: 50 tags
- Long polling: 20s
- Message Visibility Timeout: min: 0s, max: 12 hours
- Message size max: 256KB
- Message attributes: 10 metadata attributes
- Message content: có thể bao gồm XML, Json, Text
- Message retention: default 4 days, min: 1 minute, max 14 days.

---

## Monitor SQS

- Approximage age of oldest message: thời gian của message cũ nhất đã được gửi vào queue.
- Approximate number of message not visible: Số lượng mesage đang được xử lý (in-flight) nên bị tạm ẩn khỏi queue.
- Approximate number of message visible: Số lượng message chưa được xử lý.
- Number of message sent: Số lượng message đã được gửi.
- Number of message received: Số lượng message đã được nhận.
- Number of message deleted: Số lượng message đã bị xoá.

---

## Use case

- Đồng bộ dữ liệu giữa các hệ thống hoặc ứng dụng.
- Xử lý hàng đợi, giúp de-coupling hệ thống và chống bottle neck tại những component có thể có workload tăng đột ngột. Giúp chuyển từ xử lý đồng bộ sang bất đồng bộ.
- Hệ thống xử lý thời gian thực bằng cách sử dụng FIFO queue.
- Data migration. Ví dụ data từ source cần được chia ra nhiều luồng xử lý bất đồng bộ và có phương pháp retry cũng như phân loại message lỗi.

---

## Pricing

- Số lượng request gửi nhận. Vd $0.4/1 triệu request với Standard và $0.5 /1 triệu request với FIFO queue. Tính theo block 64KB.
- Dữ liệu truyền từ SQS đi ra: $0.12/GB

## Lab

Lab 1-SQS thao tác cơ bản

1. Login vào AWS Console, navigate tới dịch vụ SQS
2. Tạo một queue với các thông số cơ bản.
3. Thử gửi và nhận message trên queue.
4. Thử xoá một message
5. Thử purge queue (xoá toàn bộ message)

Lab 2 - SQS thao tác cơ bản

1. Login vào AWS Console, navigate tới dịch vụ SQS
2. Tạo một thêm một queue với tên gọi "dead-letter-queue"
3. Cấu hình queue trong lab1 sử dụng queue ở bước trên làm dead letter queue, max receive count = 5
4. Thử gửi một mesage vào queue chính sau đó poll liên tục 5 lần. Chú ý thông số receive count của message sẽ bị +1 sau mỗi lần poll
5. Poll tới lần thứ 6, message không còn nữa.
6. Confirm message đã bị đẩy sang "dead-letter-queue". Chú ý thông số receive count sẽ không bị reset mà được giữ nguyên và tiếp tục công +1 lên sau mỗi lần poll.
