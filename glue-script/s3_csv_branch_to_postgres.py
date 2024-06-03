import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

args = getResolvedOptions(sys.argv, ['JOB_NAME'])

sc = SparkContext.getOrCreate()
glueContext = GlueContext(sc)
spark = glueContext.spark_session


dynamicFrame = glueContext.create_dynamic_frame.from_catalog(
    database="s3_bank_data", table_name="branch_csv"
)

glueJob = Job(glueContext)
glueJob.init(args['JOB_NAME'], args)

branch_import = glueContext.write_dynamic_frame.from_jdbc_conf(
    frame = dynamicFrame, 
    catalog_connection = "Customer 360 Postgres", 
    connection_options = {
        "dbtable": "vpb_branch.branch", 
        "database": "postgres",
        "preactions":"TRUNCATE TABLE <table-name>"
    }, 
    transformation_ctx = "branch_import"
)

glueJob.commit()





