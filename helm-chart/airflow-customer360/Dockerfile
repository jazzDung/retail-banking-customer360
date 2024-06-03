FROM apache/airflow:2.8.3

ARG DBT_DEV_DB_NAME
ARG DBT_DEV_HOST
ARG DBT_DEV_PASSWORD
ARG DBT_DEV_USER
ARG DBT_DEV_SCHEMA
ARG DBT_DEV_PORT

ENV DBT_DEV_DB_NAME=$DBT_DEV_DB_NAME
ENV DBT_DEV_HOST=$DBT_DEV_HOST
ENV DBT_DEV_PASSWORD=$DBT_DEV_PASSWORD
ENV DBT_DEV_USER=$DBT_DEV_USER
ENV DBT_DEV_SCHEMA=$DBT_DEV_SCHEMA
ENV DBT_DEV_PORT=$DBT_DEV_PORT
ENV DBT_PROFILES_DIR=$AIRFLOW_HOME/dags/repo/datawarehouse/.config
ENV DBT_PROJECT_DIR=$AIRFLOW_HOME/dags/repo/datawarehouse

COPY requirements.txt .
RUN pip install -r requirements.txt

USER root
RUN apt update && apt install git -y
RUN mkdir /home/datawarehouse
RUN chown airflow /home/datawarehouse

