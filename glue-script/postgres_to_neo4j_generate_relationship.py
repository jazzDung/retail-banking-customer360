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


def create_relationship(
    relationship_name: str, 
    left_node: str, 
    left_attr: str, 
    right_node: str, 
    right_attr: str,  
    conn, 
    debug: bool=True
):
    query = f'''
    MATCH (l:{left_node})
    MATCH (r:{right_node})
    WHERE l.{left_attr} = r.{right_attr}
    MERGE (l)-[:{relationship_name}]->(r)
    RETURN * 
'''

    if not debug:
        conn.execute_query(query)
    else:
        print(query)
    return query


def enrich_relationship(
    relationship_name: str, 
    left_node: str, 
    left_attr: str, 
    right_node: str, 
    right_attr: str, 
    rows: list, 
    conn, 
    debug: bool=True
):
    for row in rows:
        attr_list = [create_attribute(key, value) for key, value in row.items()]
        query = f'''
        MATCH (l:left_node {{{create_attribute(left_attr, row[left_attr])}}})
        MATCH (r:right_node {{{create_attribute(left_node, row[left_attr])}}})
        MERGE (r)-[r:{relationship_name} {{{", ".join(attr_list)}}}]->(l)
        RETURN *;

        '''
    return query

# Relationship: HAS_ACCOUNT
create_relationship(
    relationship_name='HAS_ACCOUNT', 
    left_node='CUSTOMER',
    left_attr='customer_id', 
    right_node='ACCOUNT',
    right_attr='customer_id',
    conn=neo4j_conn,
    debug=False
)

job.commit()


