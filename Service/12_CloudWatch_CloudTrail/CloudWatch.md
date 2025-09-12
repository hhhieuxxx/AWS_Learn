Monitoring is essential because even well-designed systems can fail. It helps track system health, detect issues early, and trigger alerts or recovery actions. Since workloads and resource usage change over time, monitoring ensures timely responses, prevents downtime, and enables auto-scaling.

# CloudWatch là gì?

AWS CloudWatch là một dịch vụ được thiết kế để giám sát và quản lý hệ thống và ứng dụng trên nền tảng AWS. Nó cung cấp khả năng thu thập, xử lý và hiển thị các thông tin liên quan đến hiệu suất, khả năng mở rộng và lỗi của các tài nguyên trong môi trường AWS.

CloudWatch cho phép bạn theo dõi các thông số quan trọng như CPU usage, network traffic, storage, database. Nó cũng cung cấp các dịch vụ ghi log để lưu trữ và phân tích các sự kiện quan trọng từ các ứng dụng và hệ thống. Bạn có thể sử dụng CloudWatch để tạo ra các đồ thị và báo cáo để theo dõi hiệu suất và tình trạng của các ứng dụng và hệ thống trên AWS.

CloudWatch cũng hỗ trợ các cảnh báo tự động (Alarm) dựa trên ngưỡng mà bạn đặt để thông báo khi các tài nguyên vượt quá giới hạn hoặc xảy ra lỗi. Điều này cho phép bạn tự động phản ứng kịp thời và giải quyết các vấn đề trong hệ thống của mình.

---

## Tính năng

![cw](/img/cw_cheatsheet.png)  
![cw](/img/cw_sample_dia.png)

---

## Thành phần

**Metrics**  
Thu thập số liệu (tự động từ AWS services hoặc custom metrics).

**Alarms**  
Giám sát metric và đưa ra cảnh báo hoặc hành động (ví dụ gửi SNS, auto scaling).

**Logs**  
Thu thập log từ EC2, Lambda, API Gateway, CloudTrail, …  
Có Logs Insights để query phân tích.

**Dashboards**  
Bảng điều khiển trực quan hóa metric/log.

**Synthetics**  
Tạo canaries (script test) để giám sát API endpoint, website.

**RUM (Real User Monitoring)**  
Theo dõi trải nghiệm thật của người dùng cuối (client-side performance).

**Metrics Insights**  
Ngôn ngữ query để phân tích metric ở quy mô lớn (SQL-like).

**Cross-account observability**  
Cho phép theo dõi logs, metrics từ nhiều AWS account khác nhau trong 1 nơi.

**Data protection**  
Tích hợp với Amazon Macie/KMS, giúp phát hiện & bảo vệ dữ liệu nhạy cảm trong log.

**Events / EventBridge**  
Quản lý sự kiện. Bao gồm:

- Rule → định nghĩa điều kiện kích hoạt.
- Event (time-based) → theo lịch (cron, rate).
- Event (event-based) → dựa vào sự kiện hệ thống (EC2 start/stop, S3 object created...).

---

## CloudWatch Metrics

Metrics là các thông số đo lường được thu thập và lưu trữ bởi CloudWatch.  
Chúng đại diện cho các giá trị số hoặc các điểm dữ liệu liên quan đến hoạt động của các tài nguyên trong môi trường AWS, VD EC2, RDS, Elastic Load Balancer, hoặc các dịch vụ tạo ra bởi người dùng.  
Metrics hiểu cơ bản là một tập hợp time-series data.  
Có 2 loại metrics là default metrics (do AWS thu thập) và custom metrics (do người dùng tự định nghĩa).  
Metrics được dùng để làm input cho Alarm hoặc hiển thị trên graph của dashboard phục vụ mục đích giám sát.

CloudWatch Metrics có quy định về thời gian lưu trữ cho metrics, cụ thể như sau:

- 1 second metrics are available for 3 hours.
- 60 second metrics are available for 15 days.
- 5 minute metrics are available for 63 days.
- 1 hour metrics are available for 455 days (15 months).

Điều này đồng nghĩa với việc những khoảng thời gian càng lâu sẽ càng ít detail hơn (độ dày của data point ít hơn).

### Custom

Một số thông số trên EC2 instance mặc định không thể được thu thập bởi AWS, cần phải cài đặt agent lên để thu thập và gửi metrics lên CloudWatch. VD về agent: CloudWatch Agent, Prometheus, Data dog agent, Telegraf, StatsD.  
Các metrics có thể được tính toán để tạo ra một metrics khác phục vụ nhu cầu autoscaling, alarm.  
VD: (số lượng instance) / (số lượng message trên SQS).

---

## CloudWatch Alarm

CloudWatch Alarm cho phép bạn tạo ra cảnh báo tự động dựa trên các giá trị Metrics. Khi một CloudWatch Alarm được định cấu hình, nó kiểm tra liên tục các giá trị Metrics và kích hoạt cảnh báo nếu các giá trị vượt quá hoặc thỏa mãn các ngưỡng xác định.

Khi một CloudWatch Alarm được kích hoạt, nó có thể thực hiện các hành động xác định trước, bao gồm:

- Gửi thông báo qua email (kết hợp với SNS, SES)
- Gửi thông báo qua tin nhắn văn bản (SMS) khi kết hợp với SNS
- Kích hoạt các hành động tự động: CloudWatch Alarm có thể kích hoạt các hành động tự động, chẳng hạn như restart EC2, adjust storage, hoặc call API đến các dịch vụ khác trong AWS.

Các CloudWatch Alarm có thể được tạo ra dựa trên nhiều điều kiện khác nhau, bao gồm giá trị Metrics vượt ngưỡng, giá trị Metrics thấp hơn ngưỡng, trung bình hay tổng hợp các giá trị Metrics trong một khoảng thời gian nhất định, và nhiều điều kiện khác nữa.

---

## CloudWatch Log

- CloudWatch Logs là một dịch vụ cho phép bạn lưu trữ, xem và phân tích các logs từ các ứng dụng và hệ thống trong môi trường AWS cũng như on-premise.
- Nhiều service của AWS có optinion cho export thẳng log ra CloudWatch, chỉ cần enable lên là có thể xem được.
- CloudWatch Log hỗ trợ các thao tác:
  - Xem các logs theo thời gian thực trong giao diện CloudWatch Logs hoặc sử dụng API để truy xuất logs.
  - Lọc và Tìm kiếm Logs: CloudWatch Logs cung cấp công cụ để lọc và tìm kiếm logs theo các điều kiện xác định. Bạn có thể tìm kiếm các mẫu, từ khóa hoặc các thuộc tỉnh đặc biệt trong logs để tìm kiếm và phân tích thông tin cần thiết.
  - Lưu trữ Logs: CloudWatch Logs cho phép bạn lưu trữ logs trong một kho lưu trữ lâu dài để duy trì lịch sử và thực hiện các phân tích sau này.
  - Phân tích Logs: Bạn có thế sử dụng các dịch vụ và công cụ khác của AWS như Amazon Athena, Amazon Elasticsearch hoặc các công cụ khác để phân tích logs từ CloudWatch Logs và trích xuất thông tin hữu ích.

### Concepts

- **Log Group:** Level cao nhất của CloudWatch Log. Thông thường mỗi nhóm service hoặc resource sẽ Rush log ra một log group cụ thể.
- **Log Stream:** Đơn vị nhỏ hơn trong log group.
- **Log Metrics Filter:** Định nghĩa các pattern của log để thống kê. Khi log message được set filter, đồng thời bạn cũng tạo ra một metrics trên log group đó.
- **Log retention:** Thời gian log tồn tại trên CloudWatch, được set riêng cho từng log group.
- **Log streaming and archive:** Bạn có thể export log ra các service như S3 nhằm mục đích lưu trữ lâu dài với giá rẻ hoặc stream sang Kinesis phục vụ mục đích realtime analytic.

### Log Insight

- Query log

---

## X-ray

Cung cấp cái nhìn toàn cảnh và chi tiết đường đi của request trong application, giúp điều tra, visualize dựa theo function, api, service.

---

## Dashboard

CloudWatch Dashboard cho phép bạn theo dõi nhiều resource (cross regions) trên một view duy nhất.  
Bạn có thể add nhiều biểu đồ (widget) với nhiều hình dạng, customize size, màu sắc, title, đơn vị, vị trí...  
Widget có thể là biểu đồ, con số biểu diễn một metrics của một resource hoặc danh sách log từ một log group.

---

## Khi thiết kế monitor cần quan tâm những gì?

Đặt câu hỏi và trả lời các mục sau:

- Hệ thống có những resource nào cần monitor?
- Với mỗi resource cần monitor những thông số nào?
- Những thông số nào cần set alarm? thông số nào cần visualize (dashboard)?
- Những resource nào cần collect log?
- Với mỗi resource có log, collect những loại log nào?
- Có set alarm cho log không?
- Metrics và Log lưu trữ ở đâu? (Native service or tự dựng?)
- Khi có alarm cần thông báo tới ai?
- Những yêu cầu khác liên quan quy trình vận hành...
