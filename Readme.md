## What is this? 
Okay, so this is our proposed and implemented solution for the VPBank Technology Hackathon 2024 competition, participate in the challenge "Customer 360"

## Did you win it?
Sadly, no, but we (Team 101) did make it to the top 18 participants, with the announcement right [HERE](https://www.linkedin.com/posts/vpbank_vpbank-homeoftalents-activity-7201777548886695937-R0mL/)


## Used Technology
1. Data source simulation: RDS, MSK, S3
2. Data Integration: AWS Glue, Spark
3. Data Warehouse: RDS, PostgreSQL, Neo4j
4. Analytics & Visualization: dbt, Airflow, Superset
5. API Server: Python, Django
6. Web Application: ReactJS
7. Deployment: ECR, EKS, Kubernetes

## My contribution
 1. Leader of a 4-member team (2 Data Analysts and 1 Full-stack developer) developing a working solution within 24 days.
 2. Design, configured, deployed, and maintained the entire solution's architecture (AWS and Kubernetes), including:
    - Data sources (S3 buckets, External Databases, External APIs, Kafka streams)
    - AWS Glue (Jobs and crawlers)
    - Relational database (PostgreSQL managed by RDS) and Graph database (Neo4j deployed con EC2)
    - Airflow, dbt docs, API server (Deploy only), Superset, Web application (Deploy only) (All on Kubernetes cluster managed by EKS)
    - CI/CD workflow (With GitHub Actions, ECR, GitSync)
 3. Implemented all Spark and non-SQL transformations to integrate raw data into databases.
 4. Provided detailed, service-specific cost and setup time estimation for retail banking usage.
 5. Designed a cute, little PowerPoint presentation, I was also the presenter of the group during the Final round

## So what does it look like?
Here is the overview of the architecture
![Customer 360 - Detailed Architecture](https://raw.githubusercontent.com/jazzDung/retail-banking-customer360/main/figures/architecture/Detailed.png)


Or maybe a simplified one
![Customer 360 - Abstracted Architecture](https://raw.githubusercontent.com/jazzDung/retail-banking-customer360/main/figures/architecture/Abstracted.jpg)


## Folders
1. _airflow_: Airflow dags and Dockerfile to build custom image
2. _api-server_: API server code
3. _web-app_: Web application code
4. _datawarehouse_: dbt project
5. _demo-video_: Self-explanatory
6. _eks-cluster-setup_: EKS cluster setup script
7. _glue-script_: Glue data integration scripts
8. _helm-chart_: Helm chart for all deployment and services on k8s
9. _schema_: Data Warehouse schema
10. _figures_: Screenshots throughout stages of solution
11. _documentation_: Proposal, Technical documentation, and presentation slide
