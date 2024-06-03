import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

## @params: [JOB_NAME]
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)

options = {
    'url': 'jdbc:postgresql://postgres-01.c12gyiyeso58.us-east-1.rds.amazonaws.com:5432/postgres',
    'user': 'postgres',
    'password': 'postgres',
    'dbtable': 'vpb_loan.loan_payment'
}

loan_payment_frame = glueContext.create_dynamic_frame.from_options(
        connection_type='postgresql',
        connection_options=options,
        transformation_ctx="current_transaction_import"
)

loan_payment_import = glueContext.write_dynamic_frame.from_jdbc_conf(
    frame = loan_payment_frame, 
    catalog_connection = "Customer 360 Postgres", 
    connection_options = {
        "dbtable": "vpb_loan.loan_payment", 
        "database": "postgres",
        "preactions":"TRUNCATE TABLE <table-name>"
    }, 
    transformation_ctx = "loan_payment_import"
)

job.init(args['JOB_NAME'], args)
job.commit()