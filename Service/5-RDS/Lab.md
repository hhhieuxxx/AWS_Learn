## Lab 1: RDS Basic Operations

> _Requires MySQL Workbench installed_

### Steps:

1. **Create an RDS instance**

   - Instance Type: `db.t3.medium`
   - Engine: MySQL
   - Deployment: Single DB Instance
   - Storage: gp3

2. **Connect to the instance via MySQL Workbench**

   - Edit **Security Group** to allow port 3306 from **My IP**.
   - Use the **endpoint** to connect.

3. **Run basic CRUD SQL queries**

4. **Create a Read Replica**

   - Go to Actions → Create Read Replica
   - Availability: Single DB instance
   - Zone: No preference
   - Enable **Resource Grouping** for better UI management

5. **Connect to the Read Replica using MySQL Workbench**

6. **Execute basic CRUD queries** → _Read-only mode_

---

## Lab 2: RDS Cluster Operations

### Steps:

1. **Create an RDS Cluster**

2. **Connect using Cluster Write Endpoint**

   - Perform basic **CRUD operations**

3. **Connect using Cluster Read Endpoint**
   - Perform basic **Read-only operations**

---

## Lab 3:

1. Tạo Aurora Cluster với 2 instance (một Write, một Read-replica)
2. Kết nối đến Cluster sử dụng Write endpoint.
3. Thực hiện một số thao tác đơn giản (CRUD).
4. Enable tính năng back tracking
5. Đợi khoảng 5 phút.
6. Xoá toàn bộ data.
7. Thực hiện back tracking về 5 phút trước đó.
8. Kiểm tra data đã được phục hồi lại trạng thái trước khi bị xoá.

---

## Lab 4 – RDS Parameter Groups

1. Tạo 1 Parameter Group từ default MySQL 5.x
2. Cấu hình lại thông số như bảng sau:
3. Apply Parameter Group đó cho 1 cluster

| Parameter name       | Value                |
| -------------------- | -------------------- |
| `max_connections`    | `100`                |
| `max_allowed_packet` | `100000000` (~100MB) |
| `long_query_time`    | `0.5`                |
| `slow_query_log`     | `1`                  |
