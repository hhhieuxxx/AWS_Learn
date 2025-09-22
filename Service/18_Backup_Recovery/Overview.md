## Tầm quan trọng của backup

Đảm bảo data được bảo vệ trước các sự cố không mong muốn.
Giảm thiểu mất mát data khi có sự cố.

Revert lại trạng thái trước đó nếu xảy ra sai sót trong thao tác.
Giúp hệ thống có thể recovery lại ở một nơi khác (Disaster Recovery), đảm bảo tính sẵn sàng ngay cả khi có sự cố lớn.

## Các yếu tố cần quan tâm

https://aws.amazon.com/blogs/architecture/disaster-recovery-dr-architecture-on-aws-part-i-strategies-for-recovery-in-the-cloud/

RPO: Recovery Point Objective. Khi sự cố xảy ra thì có bao nhiêu data sẽ có thể mất và không thể phục hồi.
RTO: Recovery Time Objective. Khi sự cố xảy ra thì mất bao lâu để khôi phục lại hệ thống.
Hai thông số này sẽ ảnh hưởng tới việc lựa chọn chiến lược backup, tần suất backup cũng như disaster recovery.

## Có những hình thức backup nào?

Backup EC2
Snapshot Data volume
Create AMI of whole instance
Enable Life cycle policy
Backup RDS
Dump data to External Volume, and/or copy to S3 Bucket
Enable default backup (create snapshot daily)
Create custom backup using AWS Backup (custom plan, retention policy)
Enable Backtracking feature (Aurora only)

Backup EFS
Backup ondemand thủ công, auto backup hoặc sử dụng AWS Backup.
Sử dụng tính năng data replication sang một EFS khác (có thể khác region).
Backup S3 bucket
Backup liên tục (Continous backup) cho phép recovery lại bất kỳ thời điểm nào trong 35 days.
Backup định kỳ: vd 1hour, 12hours, 1 day, 1 week, 1 month.
Replica data liên tục sang một bucket khác (có thể khác region).
...và nhiều resource khác nữa.

## AWS Backup

AWS Backup là một dịch vụ của AWS được thiết kế để quản lý việc backup và khôi phục dữ liệu trên các AWS Service khác nhau. Nó cung cấp một giao diện đơn giản để tạo, quản lý và kiểm soát các hoạt động backup dữ liệu, giúp người dùng dễ dàng duy trì tính toàn vẹn và khả dụng của dữ liệu trong môi trường AWS.
AWS Backup hỗ trợ việc backup và khôi phục dữ liệu cho các dịch vụ như EBS, Amazon RDS, Amazon DynamoDB, EFS, và Amazon Storage Gateway. Dịch vụ này cung cấp các tính năng như:

1. Tạo và quản lý các backup plan tự động.
2. Quản lý và theo dõi backup: Người dùng có thể xem và quản lý tất cả các hoạt động backup từ một giao diện duy nhất.
3. Khôi phục dữ liệu: AWS Backup cho phép khôi phục dữ liệu từ các backup đã tạo.

## Lab 1 - Enable EC2 Backup sd life cycle.

Yêu cầu: Sử dụng EC2 Lifecycle để bật backup cho một EC2 instance (backup toàn bộ). Yêu cầu mỗi ngày chạy 1 lần lúc 20:00 UTC và lưu tối đa 20 bản backup. (EBS-backed AMI policy)

## Lab 2 - Backup RDS sử dụng AWS Backup

Yêu cầu sử dụng AWS Backup để thiết kế backup cho một RDS instance như sau.
Daily backup: mỗi 20h00 UTC, lưu 20 bản backup
Weekly backup: mỗi 0:00 UTC thứ 6 hàng tuần, lưu 5 bản backup.
