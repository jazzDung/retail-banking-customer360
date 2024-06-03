## What is this? 
Okay, so this is our proposed and implemented solution for the VPBank Technology Hackathon 2024 competition, participate in challenge "Customer 360"

## Did you win it?
Sadly, no, but we (Team 101) did make it to the top 18 participants, with the announcement right [HERE](https://www.linkedin.com/posts/vpbank_vpbank-homeoftalents-activity-7201777548886695937-R0mL/)

## So how does it look like?
Here are the overview of the architecture
![Customer 360 - Architecture Diagram](Cerebro - Architecture Diagram (1).png)

Or maybe an simplified one
![Customer 360 - Abstracted Diagram](Cerebro - Architecture Diagram (1).png)

## My personal contribution
 1. Leader of a 4-member team (2 Data Analysts and 1 Full-stack devloper) developing a working solution within 24 days.
 2. Designed, deployed and maintained the entire solution's architecture (AWS and Kubernetes), including:
    - Data sources (S3 buckets, External Databases, External APIs, Kafka streams)
    - AWS Glue (Jobs and crawlers)
    - Relational database (PostgreSQL) and Graph database (Neo4j)
    - Airflow, dbt docs, API server, Superset, Web application (All on Kubernetes cluster managed by EKS)
    - CI/CD workflow (With GitHub Actions, ECR, GitSync)
 3. Implemented all Spark and non-SQL transformations to integrate raw data into databases.
 4. Provided detailed, service-specific cost and setup time estimation for retail banking usage.


## Folders
- airflow: Airflow dags and Dockerfile to build custom image
- api-server: API server code
- web-app: Web application code
- datawarehouse: dbt project
- demo-video: Self-explanatory
- eks-cluster-setup: EKS cluster setup script
- glue-script: Glue data integration scripts
- helm-chart: Helm chart for all deployment and services on k8s
- schema: Data Warehouse schema
- figures: Screenshots throughout stages of solution
- documentation: Proposal, Technical documentation and presentation slide
