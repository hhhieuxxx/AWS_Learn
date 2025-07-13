## Lab 2

![ASG with Metrics](/img/alb_lab_auto_scaling.png)

Use EC2 from Lab 1

1. Enable auto start for service httpd

```bash
sudo systemctl enable httpd
```

2. Tạo AMI từ 1 instance đang chạy.
   - Select Instance - Actions - Images and Templates - Create Image - (Images/AMIs)
3. Tạo Launch Template (Instance/ Launch Templates)
4. Tạo Auto Scaling Group, chọn target group cho ASG là tg-01
   Desired capacity
   2
   Minimum capacity
   2
   Maximum capacity
   4
5. Cấu hình Application Load Balancer trỏ vào tg-01 (target group k chứa instance nào -> auto scaling )
6. Kiểm tra số lượng instance tạo ra có phù hợp chưa.
7. Thử terminate 1 instance xem ASG có tự tạo lại instance khác để bổ sung không?
8. Điều chỉnh số lượng instance trong ASG (tăng hoặc giảm size min + desire capacity)
9. Thử access liên tục xem ASG có tự add thêm instance không? (trước đó có cấu hình bật auto-scale).
   - Auto Scaling Groups - Select
     - Dynamic
       - Target tracking scaling (Monitor trên chính cluster này)
       - Metric type: Network in
       - Target value: 2000
         --> CloudWatch/ All alarms: 2 alarm đc tạo ra ( networkIn > 2000 ) và ( networkIn < 1800 trigger) --> trigger add instance
     - Predictive
     - Scheduled
10. Thử setting Schedule Auto Scaling (Lưu ý: chọn thời gian gần để test)
    Set lại Auto Scaling Group
    Desired capacity: 2
    Minimum capacity: 2
    Maximum capacity: 2
    - Scheduled Actions
      - Desired: 4 / Min: 4/ Max:4 (should Desired = Min)

## Lab 3

- Update Launch Template -> tạo ra thêm một version mới
- Cập nhật lại Auto Scaling Group lên version mới
  > Trick : muốn áp dụng được thay đổi luôn x2 Desired, Min rồi hạ về
