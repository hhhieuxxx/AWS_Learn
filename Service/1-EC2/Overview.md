## EC2 (Amazon Elastic Compute Cloud)

<img src="/img/ec2_lap.png" alt="Alt Text" width="400" height="300">

EC2 là một máy chủ ảo chạy trên Hypervisor của AWS (bên dưới là các phần cứng)
Người dùng chỉ có thể quản lý từ cấp độ OS trở lên
Hoạt động như 1 máy chủ độc lập

<img src="/img/ec2_hyper.png" alt="Alt Text" width="400" height="300">

### Khái niệm cơ bản

<img src="/img/ec2_arch.png" alt="Alt Text" width="400" height="300">

- `AMI (Amazon Machine Image) `: ~ file ISO/Ghost chứa os
- `EBS Volume` : Ổ cứng ảo được cấp phát
- `Snapshot`: Capture of EBS volume at a time - to backup
- `Instance`: 1 virtual server have CPU, RAM, GPU,...

### Life Cycle

<img src="/img/ec2_lf_cycle.png" alt="Alt Text" >

- Launch/Reboot/Stop/Start/Terminate Instance
- Attach/Detach Volume/IP/Security Group/ IAM Role/
- Create Snapshot Volume
- Create AMI from Instance

  > Terminated cannot be recovered . EBS attach with Instance be deleted depending on setting

##### EC2 support `instance-store` volume

- Supported only on specific AMIs and instance types
- Cannot be stopped once launched

<img src="/img/ec2_lf_cycle_store.png" alt="Alt Text" width="350" height="300">

This volume is directly attached to the host. It is ephemeral and data is lost when the instance is stopped but have high IOPS
--> non-critical data or workloads that require high-speed read/write operations

### Security Group

- Limit access to EC2 and from EC2 to
  - Inbound Rule
  - Outbound Rule
- Rule of security group is stateful

### User Data, Meta data

- EC2 allows you to run custom scripts at instance launch using User Data. This can be used to:

  - Install software
  - Down src code/artifact
  - Customize settings

- After an EC2 instance is launched, you can access its metadata, which provides important information about the instance, such as:
  - include: IP, security group, AMI-ID, Role,...
  - saved at http://169.254.169.254/lastest/meta-data

```bash
#Execute below command to get meta data
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/
```

### Use Cases

EC2 is a powerful service provided by AWS, appearing in almost all system architectures.
Besides that, EC2 also serves as the foundational platform for container services such as ECS and EKS (K8s).

- Lift and shift: Migrate 1:1 existing on-premise applications of the company without requiring restructuring.
- Run basic websites in an all-in-one setup.
- Compute cluster: Used for data processing applications such as Hadoop, Spark, etc.
- Used as a database host in cases where managed database services from AWS are not preferred.
- Used as nodes in a Kubernetes (K8s) cluster.

### Price

- **On-Demand**: Pay as you go. Good for dev/test.
- **Reserved / Saving Plan**: Pay upfront or commit to usage Ideal for production.
- **Spot Instance**: Bid-based. Cheap, can be interrupted anytime. Good for batch jobs.
- **Dedicated Host**: Physical server rental. Needed for compliance or licensing.

## EBS

- Block-level storage service.
- Managed by `EBS Volumes`.
- Can only be accessed when attached to one EC2 instance (e.g., root or data drive).
- Some volumes support multi-attach (attach to multiple EC2s).
- Resizable while running (increase only, cannot shrink).

**Pricing:**

- Charged by volume size ($/GB/month), even if underutilized.
- IOPS (read/write speed): Higher performance = higher cost.
- Snapshots also incur charges ($/GB/month), but cheaper than volumes.

**Types:**

- _General Purpose (gp2, gp3)_: Default type. Balanced performance, suitable for most use cases.
- _IOPS Provisioned (io1, io2)_: High-performance SSDs for apps needing high read/write IOPS.
- _Throughput Optimized HDD_: Ideal for Big Data, Data Warehousing (high throughput).
- _Cold HDD_: Low-cost storage for infrequently accessed files (e.g., archive/file server).
- _Magnetic_: Older generation, rarely used now.
