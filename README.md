# 🔄 Migration: EC2 Instances → Auto Scaling Group (ASG)
This repo contains all of the configuration and documentation of my homelab in AWS, the project is a personal lab environment on AWS with real DevOps practices. 

## 🎯 Objective
Migrate the current manually managed EC2 nodes (1 On-Demand + 1 Spot) to an **Auto Scaling Group** that guarantees:
- Always 3 nodes available (1 On-Demand + 2 Spot).
- Automatic replacement of Spot nodes when interrupted.
- Zero downtime during migration.

### 📋 Migration Plan
1. **Preparation**
   - Create snapshots/AMI of current instances.
   - Store K3s token securely in AWS SSM Parameter Store.
   - Update Terraform code with a new `autoscaling` module (mixed instances policy).

2. **Implementation**
   - Create a new feature branch: `feature/asg-mixed`.
   - Add ASG Terraform code (Launch Template + ASG).
   - Test deployment in a dedicated Terraform workspace (`asg-test`).

3. **Validation**
   - Verify that new nodes join the K3s cluster and appear as `Ready`.
   - Ensure pods are scheduled correctly on new nodes.
   - Simulate Spot termination and check replacement behavior.

4. **Production rollout**
   - Deploy ASG in production without destroying old nodes.
   - Once new nodes are stable, drain and delete old nodes (`kubectl drain && kubectl delete node`).
   - Remove legacy `aws_instance` resources from Terraform state.

5. **Post-migration**
   - Confirm cluster has 3 healthy nodes (1 On-Demand + 2 Spot).
   - Update Grafana dashboards and alerts to monitor ASG node health.
   - Document new runbooks (what to do in case of Spot interruption).

### ✅ Success Criteria
- 3 nodes are always available.
- At least 1 On-Demand instance is guaranteed.
- No downtime for deployed apps during migration