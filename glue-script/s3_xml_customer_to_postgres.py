import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

## @params: [JOB_NAME]
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

sc = SparkContext.getOrCreate()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)


dynamicFrame = glueContext.create_dynamic_frame.from_catalog(
    database="s3_bank_data", 
    table_name="customer_xml"
)

customer_import = glueContext.write_dynamic_frame.from_jdbc_conf(
    frame = dynamicFrame, 
    catalog_connection = "Customer 360 Postgres", 
    connection_options = {
        "dbtable": "vpb_user.customer", 
        "database": "postgres",
        "preactions":"TRUNCATE TABLE <table-name>"
    }, 
    transformation_ctx = "customer_import"
)


job.commit()