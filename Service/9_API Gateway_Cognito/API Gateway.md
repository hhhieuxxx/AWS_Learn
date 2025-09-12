## API Gateway

Một dịch vụ API Gateway được cung cấp bởi AWS. Nó cung cấp một cách đơn giản để xây dựng, quản lý và bảo mật các RESTful API hoặc WebSocket.

AWS API Gateway là một dịch vụ quan trọng trong kiến trúc dựa trên các dịch vụ của AWS (AWS-based microservices architecture) và thường được sử dụng cùng với các dịch vụ AWS khác như AWS Lambda, EC2, S3, Amazon DynamoDB.

AWS API Gateway cung cấp các tính năng:

- Cho phép thiết kế và phát triển API RESTful hoặc WebSocket thông qua web GUI.
- Điều phối các yêu cầu API đến các hệ thống hoặc dịch vụ khác nhau.
- Authen/Author request tới các API.
- Quản lý và giám sát các yêu cầu API, vd số lượng request, response time...
- AWS API Gateway cũng cung cấp các tính năng bảo mật, bao gồm chứng thực và ủy quyền các yêu cầu API và mã hóa secure communication giữa các hệ thống khác nhau.

---

### Đặc trưng của API Gateway

- Là một fully managed service của AWS.
- Khả năng scale và High Availablity không giới hạn.
- Zero idle cost.
- Easy to setup.
- Dễ dàng kết hợp với các dịch vụ khác như CloudWatch, WAF cho mục đích monitor & security.

---

### Hệ sinh thái API Gateway

API Gateway là một service chủ yếu có nhiệm vụ nhận request của client sau đó forward tới các service phía sau.

- DynamoDB, Lambda, EC2, EKS, S3, StepFunctions, IoT, Cognito (authen)

---

### Khi nào nên sử dụng API Gateway?

API Gateway phù hợp cho những bài toán sau:

- Kiến trúc Micro-service sử dụng lambda làm backend.
- Backend API cho hầu hết các use case (web API, IoT).
- Gateway nhận data trực tiếp từ client sau đó lưu vào DynamoDB (DB First).
- Web Socket cho những hệ thống realtime communication.

---

### Pricing

API Gateway là một dịch vụ có idle cost = 0. Người dùng chỉ trả tiền cho chi phí chạy thực tế, cụ thể:

**Với REST API:**

- Số lượng request (VD Singapore region: $4.25/1M requests)
- Data transfer out ($/GB)
- Caching size tính theo GB/hour

**Với Web socket:**

- Message number (đối với Web socket). VD $1.15/1M message với block 32KB.
- Connection minutes: $0.288/1M connection minutes

---

### Authentication cho API Gateway

API Gateway cung cấp 2 phương thức authen tích hợp trực tiếp (authorizer) thường được sử dụng đó là:

- **Cognito Authorizer:**  
  Liên kết trực tiếp với một Cognito User Pool sử dụng làm authorizer. Khi access API, client passing trực tiếp token lấy được thông qua login với Cognito, API Gateway sẽ check token và allow access nếu token hợp lệ.

- **Lambda Authorizer (custom authorizer):**  
  Khi sử dụng loại authorizer này, bạn sẽ tự implement logic authen trên Lambda. Có 2 hình thức là authen dựa vào TOKEN (JWT) hoặc request parameter based (VD username/password).

![api](/img/apiGw_custom-auth-workflow.png)

---

### API Gateway advanced option

- **Stage:** Môi trường triển khai API (vd: dev, staging, prod) chứa cấu hình và endpoint riêng.
- **Usage plan:** Quy định hạn mức sử dụng API (throttling, quota) cho nhóm người dùng.
- **API Key:** Mã định danh để xác thực và theo dõi việc sử dụng API (thường kết hợp với Usage Plan).
- **Deployment History:** Lịch sử các lần deploy API, giúp rollback hoặc xem thay đổi.
- **Canary Deployment:** Triển khai thử API cho một phần nhỏ traffic trước khi áp dụng toàn bộ, để test an toàn.
- **Custom domain:** Gắn tên miền riêng (vd: api.mycompany.com) thay vì dùng URL mặc định của AWS.
