## Lab 1- CloudWatch Alarm

Yêu cầu tạo một alarm dành cho EC2 có notification sang email, giả lập usage cao (VD CPU, Network) và tiến hành test alarm.

1. Tạo một EC2 server, sử dụng script để cài httpd, test truy cập thành công.
2. Tạo một alarm cho Network In, thresthold 2000, notify đến email.
3. Tạo một alarm cho CPU Usage, threshold 20%, notify đến email.
4. Truy cập liên tục website, confirm alarm Network gửi đến email.
5. Giả lập CPU usage cao, confirm alarm CPU gửi đến email.

Một số chú ý cho CW Alarm trong quá trình thiết kế và setting
Naming rule: dễ đọc, dễ hiểu, nhìn vô biết ngay là hệ thống nào, môi trường nào, resource nào, vấn đề gì.
Tham khảo naming rule: <system-name>-<env>-<resource>-<alarm>
VD: ABCBank-dev-master_database-CPU-is-higher-80%-in-10-mins
Threshold phải hợp lý. Điều này phải được kiểm chứng thông qua quá trình performance test và turning, rất khó để setting kiểu “một phát ăn ngay".
Phân chia notification target cho những nhóm resource và người phụ trách phù hợp. Có thể tách mỗi nhóm resource thành 1 topic SNS.
Xác nhận với khách hàng/người thiết kế về những thông số cần collect/set alarm từ giai đoạn sớm của dự án.

## Lab 2 - CloudWatch Agent

Yêu cầu: Tạo một EC2 instance, thực hiện cài đặt CWAgent lên trên đó, cấu hình CWAgent đẩy các thông số như Memory, Disk, Log lên CloudWatch.

1. Tạo một EC2 instance với AMI Amazon linux 2023, cài httpd, test truy cập.
2. Cấp IAM Role phù hợp cho EC2 Instance (CloudWatchAgentServerPolicy)
3. Cài đặt CloudWatch Agent
4. Cấu hình CloudWatch Agent (collect access log của httpd, Memory, Disk usage)
5. Enable service CW Agent khởi động cùng OS và theo dõi log của CW Agent xem hoạt động thành công.
6. Xem metrics có được gửi lên CloudWatch metrics thành công?
7. Thử access website, confirm log được gửi lên CW Log?

## Lab 3 - Log Metrics filters

Yêu cầu: Metrics filter trên log group "access_log", setting alarm nếu xuất hiện ERROR log trên 3 lần trong 1 phút thì thông báo notification.

1. Tạo một Log Metrics filter trên log group "access_log" với keyword là "ERROR".
2. Tạo một Alarm dựa trên Metrics filter vừa tạo.
   Theshold: 3
   Duration: 1 min
   Statistic: Sum
3. Thử ghi log dummy có keyword ERROR vào trong "access_log" file.
4. Confirm alarm được kích hoạt và gửi email.

![cw_lab](/img/cw_log_lab3.png)
Yêu cầu đã làm bài Lab2, cài đặt CW Agent trên EC2 thành công.
Steps:

1. Truy cập vào CloudWatch, Dashboard, tạo một Dashboard mới.
2. Add CPU Usage widget
3. Add Memory Usage widget
4. Add Disk Usage widget
5. Add Log message widget
6. Lưu Dashboard lại.
