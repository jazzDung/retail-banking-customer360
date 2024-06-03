FROM apache/airflow:2.9.1-python3.9

USER root

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
ENV DBT_PROFILES_DIR=datawarehouse/.config
ENV DBT_PROJECT_DIR=datawarehouse


WORKDIR /
COPY --chown=airflow:root ./dags/ \${AIRFLOW_HOME}/dags/
COPY requirements.txt /

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
         vim git\ 
  && apt-get autoremove -yqq --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

USER airflow

EXPOSE 8080
EXPOSE 8081
RUN pip install -r requirements.txt