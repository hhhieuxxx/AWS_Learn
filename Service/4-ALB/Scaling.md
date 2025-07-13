# Scaling

Scaling is the process of adjusting the configuration of resources to meet workload demands (e.g., number of user requests, processing jobs, etc.).

- **Scale Up/Down**: Increase/Decrease the configuration of a resource (e.g., increase CPU/RAM for a server or database, increase disk capacity, etc.)
- **Scale Out/In**: Increase/Decrease the number of components in a functional group (e.g., add more servers to the application cluster, add nodes to a Kubernetes cluster, etc.)

---

## Auto Scaling Group (ASG)

An Auto Scaling Group automatically adjusts the number of EC2 instances according to the workload.

**Goals:**

- Cost optimization
- Automation of expansion and failure recovery

![ASG Example](/img/asg_example.png)

ASGs use **Launch Templates** to determine how to launch EC2 instances.

To perform scaling, the Auto Scaling Group must monitor the metrics of system components to decide when to scale out or scale in.  
➡️ This highlights the importance of **CloudWatch**.

---

### Launch Configuration and Launch Template

These are used to instruct Auto Scaling Groups on how to launch EC2 instances.

**Parameters defined in a launch template:**

- AMI
- Instance Type
- Key Pair (if you need to SSH into instances)
- Subnet (often omitted and controlled by ASG)
- Security Group(s)
- Volume(s)
- Tag(s)
- User Data (scripts that run when the instance starts)

> _Some parameters like Instance Type, Subnet, and Security Group can be overridden by the ASG._  
> _Launch Templates are preferred over Launch Configurations as they support version management._

---

## Scaling Methods

### 1. No Scaling

Maintain a fixed number of instances. If an instance fails, a new one is launched as a replacement. No proactive scaling occurs.

### 2. Manual Scaling

Manually adjust:

- Minimum number of instances
- Maximum number of instances
- Desired number of instances

### 3. Dynamic Scaling

Scale automatically based on monitoring metrics.

#### a. Target Tracking Scaling

Monitor metrics directly from the cluster (e.g., CPU, Memory, Network In/Out) and maintain a target value.

#### b. Step Scaling

Adjust the number of instances based on a set of alarms (these alarms can originate from external resources, not just the cluster itself).

#### c. Simple Scaling

Similar to Step Scaling, but includes a **cool down period** to avoid frequent scaling actions.

#### d. Scheduled Scaling

Set schedules to scale the number of instances up or down at specific times (suitable for workloads that increase at predictable times of the day).

#### e. Predictive Scaling

AWS uses machine learning to predict future traffic based on historical data, adjusting the number of instances accordingly.  
The accuracy depends on application stability and the amount of data collected.

---

### Min, Max, Desire capacity

ASG relies on the **Desired Capacity** to determine whether to add or remove instances in the cluster.

![ASG with Metrics](/img/alb_capacity.png)

##### Examples:

- When the cluster has 2 instances and `Desired Capacity = 4`, ASG will **add 2 instances**.
- When the cluster has 4 instances and `Desired Capacity = 3`, ASG will **terminate 1 instance**.

##### Constraints:

- **Min Capacity**: Once the number of instances equals the **Min**, ASG will **not terminate** any more instances for any reason.
- **Max Capacity**: Once the number of instances equals the **Max**, ASG will **not add** any more instances for any reason.

---

## Example: Scaling Using Metrics from an External Resource

Consider a video encoding cluster:

![ASG with Metrics](/img/asg_metrics.png)

- A message producer places video encoding tasks into an SQS queue.
- The cluster retrieves and processes these videos.
- If the number of messages in the queue becomes too high or they remain in the queue for too long, it may indicate a need to scale out (i.e., add more instances).

➡️ You can monitor the **queue length** or **message age** to trigger scaling actions.

## Elastic Load Balancer stickiness session

Cho phép điều hướng một client cụ thể tới target cố định trong một khoảng thời gian.
Phù hợp cho các website sử dụng công nghệ cũ quản lý session của user trên RAM.
--> cố gắng route request về 1 target trong 1 khoảng thời gian
Should enable

- Load Balance - Listener: Enable group-level stickiness Info
- Target Group : Stickiness
