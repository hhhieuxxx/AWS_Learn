# Amazon RDS Overview

Amazon RDS (Relational Database Service) is a Database-as-a-Service (DBaaS) that allows users to quickly create and manage database instances or clusters without handling the underlying infrastructure.

---

## Key Features

- **No Instance-Level Login**  
  Unlike databases installed on EC2, users cannot log directly into the underlying database instance.

- **Scaling Options**

  - **Vertical Scaling**: Increase or decrease instance configurations.
  - **Horizontal Scaling**: Add or remove read replica nodes (read-only).

- **Storage Limits**

  - Up to **64TB** for MySQL, MariaDB, etc.
  - Up to **16TB** for Microsoft SQL Server.

- **Other Features**
  - Quick creation of database instances or clusters.
  - Automatic failover from master to standby in case of failure.
  - High Availability via Multi-AZ deployments.
  - Optional auto-scaling of storage.
  - Integration with **CloudWatch** for monitoring.
  - Automated backups with retention management.
  - Easy configuration at the database level using **Parameter Groups**.

---

## Pricing

Pricing is based on factors like:

- Instance size
- Storage size (GB/month)
- Snapshot size
- Aurora backtracking feature

---

## Deployment Models

### 1. Single Instance

![RDS](/img/rds_single_instance.png)

- One database instance in a single **Availability Zone (AZ)**.
- If an AZ-level failure occurs, the instance becomes inaccessible.
- Suitable for **Dev/Test** environments to save costs.

### 2. Single Instance with Multi-AZ

![RDS](/img/rds_single_instance_multiAz.png)

- A standby replica is created in another AZ.
- The standby is not accessible and syncs data from the master.
- In case of failure, the standby is promoted to master automatically.
- Endpoint remains unchanged.
- **Cost is doubled** due to the additional standby instance.
- Recommended for **Production** databases.

### 3. Master - Read Replica Cluster

![RDS](/img/rds_read_replica_cluster.png)

- A single master node with multiple read-only replicas.
- Option to add a Multi-AZ standby for the master to improve availability.
- Easily scalable for read-heavy applications.

A ReadOnly instance continuously replicates data from the master instance and is used strictly for read operations.  
This setup is ideal for systems where read workload is significantly higher than write workload, aiming to optimize database performance.

Once the relationship is established, the instances form a cluster.

If the master instance fails, **automatic failover** promotes a ReadOnly instance to become the new master.

> ⚠️ Note:
>
> - If the instances were created separately and the read-replica relationship is established afterward, each instance will have its own endpoint. After failover, the application must update its database connection string manually.
> - It is recommended to **create the cluster first** and then add read nodes to manage connections at the cluster level. The number of read nodes can be adjusted as needed.

##3 Multi-AZ enable

x4 Price
![RDS](/img/rds_read_cluster_multiAz.png)

- Applications use **read/write endpoints** to interact with the cluster.
- If the master fails, one of the read replicas is promoted to master.
- Clusters should span **more than two Availability Zones** for resilience.

### Multi Read Cluster

![RDS](/img/rds_multi_read_cluster.png)

---

## Cluster vs Instance

AWS supports RDS clusters which simplify management of nodes and failovers.

### Advantages over Single Instances:

- Cluster-level **endpoints** remain unchanged during failover.
- **Automatic failover** management.
- Easy **scaling** of read replicas.

---

## Snapshots

---
