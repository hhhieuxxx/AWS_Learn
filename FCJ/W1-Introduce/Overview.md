### Cloud Computing

Cloud Computing is the distribution of information technology resources on demand over the Internet with a pay-as-you-use policy.

- pay-as-you-use
- Accelerate development by leveraging automation features and management provided by the vendor.
- Flexible scalability, Global scale

### AWS

#### Global Infra

- **Data Center**:
- **Availabilty Zone (AZ)**: Contains one or more Data Centers, designed to ensure that no two AZ are affected simultaneously (fault isolation) – `Should be deployed in at least two AZs.`
- **Region**:
  - More than 25 regions globally.
  - Contains at least 3 Availability Zones (AZs), connected by AWS's backbone network
  - Data and services in each region are separate (except for global services)
  - Price in each region !=
- **Edge Locations (POP)**:
  - Mạng lưới trung tâm dữ liệu AWS có độ trễ thấp
  - Service (dịch vụ mạng biên) in POP
    - CloudFont(CDN)
    - Web App FireWall (WAF)
    - Route 53 (DNS Service)

#### Tools

- AWS Management Console:
  - Login
    - Root user (first account registered): Should be used sparingly, only for registration and security purposes
    - IAM user (not an actual account): A user (child account) that manages resource usage.
      `First-time login: Use the Root user to create an IAM user for future logins.`
  - Service
  - Support Center: Create a case to request support.
- AWS SDK
  Simplifies the use of AWS services through a library suite for application development.

- AWS CLI

  - use command line
    ![cli](../img/w1-cli.png)

#### Optimization

- Selecting the Right Configuration and Storage Location
- Payment and Discounts

  - **Default (On-Demand)**: Priced based on time usage (most expensive).
  - **Reserved Instance, Saving Plan**: Long-term usage commitment for discounts.
  - **Spot Instances**: Temporary resources with lower costs but can be reclaimed.

- **Delete unused data** and **enable automatic turn on/off** for resources when not needed.
- Serverless Services
- Estimate Calculator

_Advance:_

- _Optimized architecture design_
- AWS Budget
- Cost management by department/application with cost allocation tags
- Continuous monitoring and optimization

### AWS Support

- 4 gói hỗ trợ :
  - Basic(Explore)
  - Developer(Test/Dev)
  - Business(Production)
  - Enterprise(Large Enterprise)
- From the Developer plan, users can request technical questions.
- Can upgrade the plan to speed up support (not recommended).
