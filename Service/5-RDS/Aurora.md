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
