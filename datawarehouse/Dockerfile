FROM python:3.9-slim as build_dbt_docs

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
ENV DBT_PROFILES_DIR=.config


WORKDIR /datawarehouse
COPY . .

EXPOSE 8080
RUN pip install -r requirements.txt
RUN dbt deps
RUN dbt docs generate

# CMD [ "dbt", "docs", "serve"]

FROM nginx as build_nginx
ENV DBT_DIR /datawarehouse

# Copy the static dbt docs HTMLs to the nginx directory
# target directory created using the command `dbt docs generate`
COPY --from=build_dbt_docs $DBT_DIR/target/ /usr/share/nginx/html
# COPY --from=build_dbt_docs $DBT_DIR/edr_target/ /usr/share/nginx/html/edr_target

# Copy the nginx configuration template to the nginx config directory
COPY --from=build_dbt_docs $DBT_DIR/docs_website/default.template /etc/nginx/conf.d/default.template

# must be defined to run container locally, but not needed for cloud run
ENV PORT=8080
EXPOSE 8080

# Substitute the environment variables and generate the final config
CMD envsubst < /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/default.conf && exec nginx -g 'daemon off;'