## Amazon Aurora

Aurora is a **proprietary database** service by AWS, compatible with **MySQL** and **PostgreSQL** engines.

#### Aurora Deployment Modes:

- **Cluster Mode** (Master + Multi Read Replicas)
- **Serverless Mode**

#### Key Aurora Advantages:

- Better performance (as claimed by AWS).
- Supports **Backtracking** (up to 72 hours):
  - Instantly revert the cluster to a previous state without creating a new instance.
- Automatic management of **Read/Write endpoints** at the cluster level.

### Mô hình cluster

![RDS](/img/aurora-db-clusters.png)

Cluster Aurora bao gồm:
1 Master node (Primary instance)
1 hoặc nhiều Replica node (tối đa 15
Data của Aurora cluster được lưu trên một storage layer gọi là Cluster Volume span trên nhiều AZ để tăng HA.
Data được Cluster Volume tự động replicate trên nhiều AZ. \*Số lượng copy không phụ thuộc vào số lượng instance của cluster.
Cluster Volume tự động tăng size dựa vào nhu cầu của người dùng (không thể fix cứng size).

#### Aurrora Global Cluster

![RDS](/img/aurora-global-cluster.png)

Là một cơ chế cho phép tạo ra cụm cluster cross trên nhiều regions.
Tăng tốc độ read tại mỗi region tương đương với local read.
Mở rộng khả năng scale số lượng node read (limit 15 read nodes cho 1 cluster).
Failover, Disaster recovery: rút ngắn RTO và giảm thiểu RPO khi xảy ra sự cố ở cấp độ region.
Mặc dịnh cluster ở region thứ 2 trở đi chỉ có thể read, tuy nhiên có thể enable write forwarding để điều hướng request tới primary cluster.

\*Khác với RDS thông thường, Aurora sử dụng tầng Storage để replicate data giữa master-read nodes.

### Serverless

Aurora Serverless là 1 công nghệ cho phép tạo Database dưới dạng serverless.
Thay vì điều chỉnh cấu hình của DB instance, người dùng sẽ điều chỉnh ACU (Aurora Capacity Unit), ACU càng cao hiệu suất DB càng mạnh.
Phù hợp cho các hệ thống chưa biết rõ workload, hoặc workload có đặc trưng thay đổi lên xuống thường xuyên.

---

# AWS RDS – Parameter Groups, Option Groups, and Proxy

## Parameter Groups

RDS là một managed service, do đó **không thể login trực tiếp vào instance**. Nếu muốn can thiệp vào **DB-level settings** (không phải OS-level), cần thông qua **Parameter Groups**.

- Khi tạo RDS, nếu không chỉ định thì AWS sẽ dùng **default Parameter Group** của engine đang chọn.
- **Default Parameter Group** không thể chỉnh sửa.
- Có thể tạo **Custom Parameter Group** bằng cách **copy từ default** và chỉnh sửa các tham số phù hợp.

### Phân loại Parameter Group

| Loại                     | Mô tả                                               |
| ------------------------ | --------------------------------------------------- |
| Cluster Parameter Group  | Áp dụng cho toàn bộ cluster (Aurora).               |
| Instance Parameter Group | Áp dụng cho từng instance (non-Aurora hoặc Aurora). |

### Một số parameter thường được custom:

| Tên Parameter        | Ý Nghĩa                                               | Default Value      | Allowed Value    |
| -------------------- | ----------------------------------------------------- | ------------------ | ---------------- |
| `max_connections`    | Số connection tối đa mà DB có thể tiếp nhận đồng thời | Instance-dependent | 50 – 12,000      |
| `long_query_time`    | Query chạy vượt quá số này được xem là **slow query** | `0`                | `0` – `31536000` |
| `slow_query_log`     | Bật/tắt log các câu query chậm                        | `0`                | `0`, `1`         |
| `max_allowed_packet` | Dung lượng package tối đa gửi/nhận                    | `1073741824`       | `1024+`          |
| `general_log`        | Bật/tắt ghi lại toàn bộ general query                 | `0`                | `0`, `1`         |
| `time_zone`          | Thiết lập múi giờ cho database                        | Same as region     | Ex: `Asia/Tokyo` |

---

## Option Groups

Tương tự Parameter Group, nhưng **Option Group dùng cho các thiết lập liên quan đến bảo mật** hoặc tính năng đặc biệt.

### Ví dụ các option:

| Tên Option                | Ý Nghĩa                                                               |
| ------------------------- | --------------------------------------------------------------------- |
| `SERVER_AUDIT_EVENTS`     | Loại hành động sẽ được log (e.g. CONNECT, QUERY_DDL, QUERY_DML, etc.) |
| `SERVER_AUDIT_INCL_USERS` | Include users vào audit log                                           |
| `SERVER_AUDIT_EXCL_USERS` | Loại trừ user khỏi audit log (e.g. system user)                       |
| `SERVER_AUDIT_LOGGING`    | Bật/tắt audit logging                                                 |

---
