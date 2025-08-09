## VPC Peering

Là hình thức đơn giản nhất để kết nối 2 VPC trên AWS. 2 VPC có thể cùng account hoặc khác account.  
Để thiết lập, một phía sẽ phải đưa ra peering request (requester) và bên còn lại sẽ accept request (accepter).  
Sau khi đã thiết lập quan hệ peering, cần cấu hình lại Route Table (thêm route đi ra peering connection) và setting Security Group thích hợp để resource ở 2 VPC có thể connect lẫn nhau thông qua private IP (không đi ra internet).

_Lưu ý:_

- VPC Peering không có tính chất bắc cầu. VD VPC-A peer VPC-B, VPC-B peer VPC-C không có nghĩa là VPC-A cũng peer với VPC-C.
- Hai VPC muốn peering được với nhau phải có dải IP CIDR không overlap.

---

## Transit Gateway

Đóng vai trò như 1 hub trung chuyển giữa On-Premise và AWS Cloud hoặc giữa nhiều VPC trên Cloud.  
Thường sử dụng kết hợp với Site-to-Site VPN hoặc Direct Connect.

---

## Site to Site VPN

Là hình thức kết nối network Onpremise với network trên AWS Cloud.

- **Customer Gateway:** thiết bị vật lý hoặc virtual appliance ở phía On-Premise có nhiệm vụ điều hướng traffic.
- Thông tin truyền đi giữa On-Premise và AWS Cloud được mã hoá.
- Bandwidth khoảng ~4Gbps.

![dsd](/img/vpc_adv.png)

---

## Dirrect Connect

Hình thức kết nối từ On-Premise lên AWS Cloud thông qua một kênh connect low latency, high speed.

- Connection được duy trì thông qua một đường truyền chuyên dụng không qua public internet.
- Thông tin truyền đi giữa On-Premise và AWS Cloud không được mã hoá by default.
- Bandwidth dao động từ 50Mbps-100Gbps.
- Khó setup hơn so với VPN, cần làm việc với nhà cung cấp
