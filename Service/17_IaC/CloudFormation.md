## Những vấn đề gặp phải khi triển khai hệ thống manually

- Tốc độ chậm, tốn nhiều effort.
- Thiếu chính xác, dễ xảy ra lỗi.
- Khó đảm bảo tính nhất quán giữa các môi trường hoặc regions.
- Không thể tái sử dụng cho dự án khác.

---

## Infrastructure as Code là gì?

Infrastructure as Code (IaC) là một phương pháp trong quản lý hạ tầng công nghệ thông tin (IT infrastructure) bằng cách sử dụng template hoặc code để triển khai hạ tầng.  
IaC nhằm tự động hóa quy trình triển khai, cấu hình và quản lý hạ tầng, thay vì thực hiện các tác vụ này bằng tay.

---

## CloudFormation

AWS CloudFormation là một dịch vụ trong Amazon Web Services (AWS) cung cấp cách tự động hóa việc triển khai và quản lý các nguồn tài nguyên AWS.  
Nó cho phép bạn xác định các nguồn tài nguyên AWS của mình dưới dạng mã (infrastructure as code), sử dụng cú pháp JSON hoặc YAML, và sau đó triển khai và quản lý các tài nguyên này trong một cấu trúc tổ chức gọi là stack.

### Lợi ích khi sử dụng Infra-as-code (cũng như CloudFormation)

- Tăng tốc độ triển khai.
- Đảm bảo tính nhất quán về kiến trúc cũng như setting của resources giữa các môi trường.
- Giảm thiểu sai sót do triển khai & cấu hình bằng tay (console, cli).
- Tăng tính tái sử dụng của resource (cho các dự án khác nhau).

---

### Concept

- **Stacks:** Một tập hợp các resource được quản lý như một đơn vị duy nhất.
- **StackSets:** Quản lý và triển khai stack trên nhiều account và region.

---

## CloudFormation Template

CloudFormation hỗ trợ 2 định dạng:

- JSON
- YAML (thường được sử dụng hơn do dễ đọc và có thể comment)

**Cấu trúc template:**

- Version
- Description
- Metadata
- Parameters
- Rules
- Mapping
- Condition
- Transform
- Resources _(bắt buộc)_
- Outputs

---

## Lab 1 – Sử dụng CloudFormation template

Yêu cầu: Sử dụng CloudFormation template đơn giản để triển khai một EC2 instance (tham khảo code mẫu).

1. Chuẩn bị CloudFormation template như mẫu.
2. Truy cập vào CloudFormation, chọn create stack.
3. Chọn upload file from local.
4. Nhập các tham số cần thiết.
5. Create và đợi Stack triển khai thành công, confirm kết quả.

```yaml
Parameters:
  SubnetId:
    Description: SubnetID for EC2
    Type: AWS::EC2::Subnet::Id
  SecurityGroupIds:
    Description: List of security group id that apply to instance
    Type: List<AWS::EC2::SecurityGroup::Id>
  AMI:
    Description: AMI id for EC2 instance
    Type: String
  Keypair:
    Description: Keypair for EC2
    Type: String
  TagName:
    Description: Name tag for EC2
    Type: String
Resources:
  TestEIP:
    Type: AWS::EC2::EIP
    Properties:
      Domain: String
      InstanceId: !Ref MyEC2Instance

  MyEC2Instance:
    Type: AWS::EC2::Instance
    Properties:
      ImageId: !Ref AMI
      KeyName: !Ref Keypair
      InstanceType: "t3.micro"
      BlockDeviceMappings:
        - DeviceName: "/dev/sdm"
          Ebs:
            VolumeType: "gp2"
            DeleteOnTermination: "false"
            VolumeSize: "20"
      NetworkInterfaces:
        - AssociatePublicIpAddress: "true"
          DeviceIndex: "0"
          GroupSet: !Ref SecurityGroupIds
          SubnetId: !Ref SubnetId
      Tags:
        - Key: Name
          Value: !Ref TagName
```

---

## Plugin & Tool

- AWS CDK
- Ansible
- Terraform
- Pulumi
- Chef

CloudFormation in VSCode
