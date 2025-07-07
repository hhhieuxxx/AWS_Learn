# What is a Load Balancer?

A **Load Balancer** is an intermediate component that distributes client requests to multiple backend targets, ensuring:

- **High Availability** – System stays online even if one part fails
- **Scalability** – Easy to scale out
- **Fault Tolerance** – Avoid single point of failure (SPOF)

---

## What is a Single Point of Failure?

<img src="/img/alb_SPOF.png" alt="Alt Text" width="600" height="400">

A **Single Point of Failure (SPOF)** is a component that, if it fails, will cause the entire system to become unavailable.

### Examples:

- Application crash
- Database failure
- Operating System hangs
- Hardware failure (RAM, CPU, Disk, Power...)

### Higher-level incidents:

- Power supply failure for an entire server rack
- Data center power outage
- Natural disasters: floods, storms, earthquakes, etc.

⟶ To avoid SPOF, every layer of the system should have redundancy.

---

## Why Do We Need Load Balancing?

When a system has more than one backend, we need a **Load Balancer** to:

- Distribute requests evenly
- Perform health checks on backend targets
- Ensure continuous service availability
- Simplify scaling and horizontal expansion

---

## What is AWS Elastic Load Balancing (ELB)?

A **fully managed AWS service** that routes client requests to backend targets such as EC2, Lambda, and containers.

### Benefits:

- **High Availability**
- **Scalability** – Virtually unlimited
- **High Security** – Integrates with WAF, Security Groups
- Supports multi-AZ deployment for fault tolerance

> Each **Availability Zone (AZ)** represents an isolated data center, usually tens to hundreds of kilometers apart.

---

## Load Balancer Components

<img src="/img/alb_components.png" alt="Alt Text" width="600" height="300">

- **Listener** – Defines protocol and port (e.g., HTTP:80, HTTPS:443)
- **Rules** – Define how requests are routed
- **Target Group** – Holds targets (e.g., EC2, Lambda) and health check config

---

## Types of Load Balancer in AWS

### 1. Application Load Balancer (ALB)

- Operates at **Layer 7** (Application)
- Supports:
  - **Path-based routing**: `/api/*`, `/user/*`
  - **Host-based routing**: subdomains
  - **Header/IP-based routing**
  - Integration with **Lambda**, **ECS**
  - Custom HTTP responses

### 2. Network Load Balancer (NLB)

- Operates at **Layer 4** (Transport)
- Supports protocols: **TCP, UDP**
- Handles extremely high throughput (millions of requests/second)
- Less flexible in routing than ALB

### 3. Classic Load Balancer (CLB)

- Legacy LB, works at both Layer 4 and Layer 7
- Fewer features compared to ALB/NLB

### 4. Gateway Load Balancer (GLB)

<img src="/img/alb_GWLB.png" alt="Alt Text" width="600" height="400">

- For deploying and scaling **3rd-party Virtual Appliances**
- Operates at **Layer 3 & 4**
- Use cases: firewall, IDS/IPS, deep packet inspection
- Uses **GLB Endpoint** to route traffic between **provider VPC** and **consumer VPC**

> Least commonly used type of Load Balancer in real-world projects.

---

## How Load Balancing Works

- **Default behavior**: Round-robin (requests are distributed evenly in a circular order to all healthy targets, e.g., A → B → C → A → ...) routing to all healthy targets in a target group
- With **multiple target groups**, routing is based on:
  - Listener port
  - Path pattern (for ALB)
  - Fixed weight (e.g., 20% traffic to tg-01, 80% to tg-02)

<img src="/img/alb_work2.png" alt="Alt Text" width="600" height="300">

> An instance should be registered in only one target group

---

## Cross-Zone Load Balancing

Allows the Load Balancer to evenly distribute traffic across targets in **all AZs**.

| LB Type | Cross-Zone Enabled by Default |
| ------- | ----------------------------- |
| ALB     | ✅ Yes                        |
| NLB     | ❌ No (must enable manually)  |

> ⚠️ When creating a Load Balancer, make sure to select **all available zones**. If the selected zones do not contain your EC2 instances, you'll get a **502 Bad Gateway** error.

---

## ELB Pricing

### 1. Hourly Fee

- Fixed hourly cost based on region.

### 2. LCU-based Pricing (Load Balancer Capacity Units)

LCU usage is based on:

- Number of requests per second (RPS)
- Data transferred (GB/TB per hour)
- Number of new connections
- Average connection duration
- Number of routing rules applied

---

## Auto Scaling + Load Balancing Example

### Lab Steps

1. Launch two EC2 instances (A and B) with different user data for visual distinction.
2. Create **Target Group tg-01**, add both A and B.
3. Create an **Application Load Balancer (ALB)** and configure **Listener port 80** to forward to `tg-01`.
4. Access ALB via DNS link to verify routing.

### Multi Target Group Setup

5. Remove instance B from `tg-01`, create **tg-02** and add instance B.
6. Add new **Listener port 8080**, forwarding to `tg-02`.
7. Access ALB via:
   - `http://<alb-dns>:80` → Instance A
   - `http://<alb-dns>:8080` → Instance B

### Traffic Ratio (Optional)

8. Configure **traffic split**: `tg-01` gets 25%, `tg-02` gets 75%
9. Refresh multiple times to observe traffic distribution

---

## Summary

- Load Balancer ensures **high availability** and **horizontal scalability**
- Helps avoid **Single Point of Failure**
- AWS offers multiple types of ELB, each optimized for different workloads
- Cross-zone load balancing improves resilience and traffic distribution
