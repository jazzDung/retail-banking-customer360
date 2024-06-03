import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

import pandas as pd
import neo4j
from datetime import datetime, date
from unidecode import unidecode

## @params: [JOB_NAME]
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

# Connect to neo4j
uri = 'bolt://54.234.66.55:7687'
auth = ('neo4j', '02092001')
neo4j_conn = neo4j.GraphDatabase.driver(uri=uri, auth=auth)

# Read from RDS
current_account = glueContext.create_dynamic_frame.from_options(
        connection_type='postgresql',
        connection_options={
            'url': 'jdbc:postgresql://customer360-prod.c12gyiyeso58.us-east-1.rds.amazonaws.com:5432/postgres',
            'user': 'postgres',
            'password': 'postgres',
            'dbtable': 'public_staging.stg_vpb_user_account'
        },
        transformation_ctx="account_neo4j_import"
).toDF().toPandas()

customer = glueContext.create_dynamic_frame.from_options(
        connection_type='postgresql',
        connection_options={
            'url': 'jdbc:postgresql://customer360-prod.c12gyiyeso58.us-east-1.rds.amazonaws.com:5432/postgres',
            'user': 'postgres',
            'password': 'postgres',
            'dbtable': 'public_staging.stg_vpb_user_customer'
        },
        transformation_ctx="customer_neo4j_import"
).toDF().toPandas()

def barebone_name(name: str):
    return unidecode(name.lower().replace(' ', '_'))
    
def create_attribute(name: str, value):
    # print(value, name, type(value))
    if type(value) == str:
        return f'{name}: "{value}"'
    if type(value) in [datetime, date]:
        return f'{name}: datetime("{value.strftime("%Y-%l-%dT%H:%l:%S")}")'
    else:
        return f'{name}: {value}'


def node_construct(
    node_name: str, 
    node_name_col: str, 
    rows: list, 
    conn, 
    debug: bool=True
):
    query = 'CREATE '

    for row in rows:
        attr_list = [create_attribute(key, value) for key, value in row.items()]
        node = f'\n    ({row[node_name_col]}:{node_name}{{{", ".join(attr_list)}}}),'
        query += node
    
    query = query[:-1] + ';'

    if not debug:
        conn.execute_query(query)
    else:
        print(query)
    return query


customer['full_name_format'] = customer.apply(
    lambda x: barebone_name(x.first_name) + '_' + barebone_name(x.last_name), 
    axis=1
)

current_account['domain'] = 'current'
current_account.drop_duplicates(subset=['account_id'], inplace=True)

# Customer
node_construct(
    node_name='CUSTOMER', 
    node_name_col='customer_id', 
    rows=customer.to_dict(orient='records'),
    conn=neo4j_conn,
    debug=False
)

# Current
node_construct(
    node_name='ACCOUNT', 
    node_name_col='account_id', 
    rows=current_account.to_dict(orient='records'),
    conn=neo4j_conn,
    debug=False
)

job.commit()

