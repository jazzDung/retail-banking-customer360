
# Tạo cluster + node group
eksctl create cluster \
	--name Customer360 \
	--region us-east-1 \
	--nodegroup-name my-nodegroup \
	--node-type m5.large \
	--nodes 3 \
	--nodes-min 1 \
	--nodes-max 3 \
	--zones=us-east-1b,us-east-1f \
	--node-zones=us-east-1b \
	--managed

# Open public access
eksctl utils update-cluster-vpc-config \
	--cluster=Customer360 \
	--private-access=true \
	--public-access=true \
	--approve


# Create IAM Open ID connector
eksctl utils associate-iam-oidc-provider \
	--region=us-east-1 \
	--cluster=Customer360 \
	--approve

# Create IAM Role for addon EBS CSI
eksctl create iamserviceaccount \
    --name ebs-csi-controller-sa \
    --namespace kube-system \
    --cluster Customer360 \
    --role-name AmazonEKS_EBS_CSI_DriverRole \
    --role-only \
    --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
    --approve

# Check CSI Version
aws eks describe-addon-versions --addon-name aws-ebs-csi-driver

# Update / Install EBS CSI addon
eksctl create addon \
	--name aws-ebs-csi-driver \
	--version v1.30.0-eksbuild.1 \
	--cluster Customer360 \
	--service-account-role-arn arn:aws:iam::211125445165:role/AmazonEKS_EBS_CSI_DriverRole \
	--force

# Create Policy for load balancing
aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://aws-load-balancer/iam_policy.json

# Create IAM Role
eksctl create iamserviceaccount \
  --cluster=Customer360 \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --attach-policy-arn=arn:aws:iam::211125445165:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve

# Add EKS to repo
helm repo add eks https://aws.github.io/eks-charts
helm repo update eks

# Install AWS Load Balancer
helm upgrade --install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=Customer360 \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller
  # --set region=us-east-1 \ 
  # --set vpcId=vpc-06dfa699cdb7d321b

# Create namespace
kubectl create namespace airflow
kubectl create namespace dbt
kubectl create namespace superset
kubectl create namespace api-server
kubectl create namespace web-app

# Add ssh secret
kubectl create secret generic airflow-ssh-git-secret \
	--from-file=gitSshKey=/home/jazz/credentials/gitSyncCustomer360.pem \
	-n airflow

# Deploy helm chart Airflow
cd /home/jazz/projects/helm-chart/
helm upgrade \
	--install airflow apache-airflow/airflow \
	-n airflow \
	-f airflow-customer360/aws.yaml \
	--debug

# Deploy Airflow load balancer
kubectl apply -f aws-load-balancer/airflow-ui-balancer.yaml

# Deploy dbt
kubectl apply -f dbt-docs/dbt-docs.yaml

# Deploy dbt load balancer
kubectl apply -f dbt-docs/dbt-docs-balancer.yaml

# Deploy Superset
helm upgrade \
	--install superset superset/superset \
	-n superset \
	-f superset/custom.yaml \
	--debug

# Deploy Superset load balancer
kubectl apply -f aws-load-balancer/superset-ui-balancer.yaml


# Deploy API server and load balancer
kubectl apply -f api-server/api-server-customer360.yaml
kubectl apply -f aws-load-balancer/api-server-customer360-balancer.yaml
kubectl get svc -n api-server api-server-customer360-balancer

# Deploy Web app and load balancer
kubectl apply -f web-app/web-app-customer360.yaml
kubectl apply -f aws-load-balancer/web-app-customer360-balancer.yaml
kubectl get svc -n web-app web-app-customer360-balancer