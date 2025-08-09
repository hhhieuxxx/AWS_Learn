## NoSQL Overview

NoSQL (Not Only SQL) databases are non-relational systems that do not use the traditional table-based relational model.  
They use alternative data structures, making them suitable for large-scale, high-speed, and highly scalable applications.

### Types of NoSQL Databases

- **Key-Value:**  
  Stores data as key-value pairs. Keys are used to access and retrieve data, while values can be of any data type.

- **Document:**  
  Stores data as documents, usually in JSON or XML format. Documents are schema-less, allowing flexible and easy data storage.

- **Column-Oriented:**  
  Stores data in tables with rows and columns, but columns can be added or removed independently, unlike relational databases.

- **Graph:**  
  Stores data as nodes and relationships, enabling efficient handling of complex data relationships.

---

## DynamoDB Overview

Amazon DynamoDB is a fully managed, serverless, key-value NoSQL database designed to run high-performance applications at any scale.  
DynamoDB offers built-in security, continuous backups, automated multi-Region replication, in-memory caching, and data import/export tools.

### Đặc trưng của DynamoDB

- **Serverless:** Hạ tầng được quản lý bởi AWS. Người dùng tương tác qua Console, CLI, các tool client hoặc SDK.
- **Tổ chức dữ liệu:** Dữ liệu được tổ chức thành các đơn vị table.
- **Độ trễ thấp:** Single digit millisecond.
- **SLA:** 99.999% availability.
- **Tự động scale:** Scale Up/Down theo workload (WCU, RCU).
- **Tích hợp:** Kết hợp được với nhiều service khác của AWS.

### Ưu điểm

- Serverless nên chi phí vận hành thấp, tính khả dụng cao.
- Linh hoạt trong cấu hình (zero idle cost, phù hợp cho startup).
- Khả năng scale không giới hạn (về lý thuyết), độ trễ thấp, hiệu suất cao.
- Strong consistency.
- Hỗ trợ mã hoá.

### Nhược điểm

- Không phù hợp với data query và analytic (OLAP).
- Thiếu tính năng khi so sánh với SQL (relational DB).

---

## DynamoDB Use Cases

- Software application: Phù hợp cho các ứng dụng cần high concurrency cho hàng triệu user (VD: E-commerce).
- Media metadata store: Lưu trữ metadata cho các media.
- Gaming platform.
- Social media: Mạng xã hội, bài đăng, bình luận.
- Logistic system.
- Ứng dụng IoT.

---

## DynamoDB Pricing

DynamoDB tính phí dựa trên các thông số sau:

- **Write Capacity Unit (WCU) & Read Capacity Unit (RCU):** Có 2 mô hình tính giá là On-demand và Provisioned Capacity.
- **Dung lượng lưu trữ:** Tính theo đơn vị KB. VD Singapore: $0.285/GB/Month.
- **Data backup & restore:** VD Singapore: $0.228/GB/Month.
- **Tần suất query data, Indexing, Data import/export, DAX, Data transfer ra ngoài, ...**

Tham khảo: [DynamoDB Pricing](https://aws.amazon.com/dynamodb/pricing/on-demand/)

### Hiểu rõ về WCU/RCU

- **RCU (Read Capacity Unit):**

  - 1 RCU = 2 request read/s (eventual consistency) cho mỗi block 4KB
  - 1 RCU = 1 request read/s (strong consistency) cho mỗi block 4KB
  - Nếu data > 4KB sẽ làm tròn lên block tiếp theo.

- **WCU (Write Capacity Unit):**
  - 1 WCU cho mỗi block 1KB (standard mode).
  - 2 WCU cho mỗi block 1KB (transactional mode).

### On-demand vs Provisioned

- **On-demand:**

  - Tự động scale WCU, RCU khi workload tăng cao.
  - $1.25 per million write request units
  - $0.25 per million read request units

- **Provisioned:**
  - Reserve số WCU, RCU cố định cho từng bảng hoặc index.
  - $0.00065 per WCU/hour
  - $0.00013 per RCU/hour

### Free Tier & Always Free

- **Free tier (12 tháng đầu):**

  - 25 GB data storage
  - 2.5 triệu stream read requests từ DynamoDB Streams
  - 25 Provisioned WCU, 25 Provisioned LCU
  - 100 GB data transfer out

- **Always free:**
  - 25 GB data storage
  - 25 Provisioned WCU, 25 Provisioned LCU
  - Đủ cho khoảng 200 triệu request/tháng

---

## DynamoDB Concepts

- **Table:** Đơn vị quản lý cao nhất, không trùng tên trên một region.
- **Primary key:** Bắt buộc khi tạo table.
  - Simple Primary key: Partition key.
  - Composite primary key: Partition key + Sort key.
- **Global Secondary Index (GSI):** Index độc lập, tối đa 20 GSI/table.
- **Local Secondary Index (LSI):** Index phụ thuộc table, tối đa 5 LSI/table, chỉ tạo lúc tạo table.
- **Query:** Truy vấn data trên một index.
- **Scan:** Tìm toàn bộ giá trị thoả mãn điều kiện (chậm hơn query).
- **PartiQL:** SQL-compatible query language.

### Data Types

- String
- Number
- Binary
- Boolean
- Null
- Set
- Map
- List

_Lưu ý: Không có DateTime. Cần convert sang Unix time hoặc sử dụng format string yyyymmdd._

---

## DynamoDB Advanced Features

### Global Table

- Cho phép sao chép và đồng bộ dữ liệu giữa các khu vực khác nhau trên toàn cầu.
- Đảm bảo dữ liệu phân phối đồng đều và có sẵn cho ứng dụng ở nhiều vùng địa lý.

### DynamoDB Accelerator (DAX)

Amazon DynamoDB Accelerator (DAX) là dịch vụ cache in-memory, fully managed, highly available cho DynamoDB, giúp tăng hiệu suất lên đến 10 lần (từ milliseconds xuống microseconds), kể cả với hàng triệu request/giây.

- DAX hoạt động dưới dạng cluster.
- Để truy cập data qua DAX, cần có DAX client.
- Nếu chọn read strongly consistency, request sẽ được forward thẳng tới DynamoDB.

![dax](/img/dynamodb_dax_high_level.png)

---

### DynamoDB Export and Stream

- Hỗ trợ export data sang S3.
- Stream data sang các target như Kinesis hoặc Lambda để xử lý
