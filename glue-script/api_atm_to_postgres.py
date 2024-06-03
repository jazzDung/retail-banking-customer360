import sys
import requests
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
from awsglue import DynamicFrame

## @params: [JOB_NAME]
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)
job.commit()

r = requests.get(url='http://k8s-apiserve-apiserve-03159dafcc-74596ca9fbb60af8.elb.us-east-1.amazonaws.com/api/atms/')
df = spark.read.json(sc.parallelize([r.text]))

dynamicFrame = DynamicFrame.fromDF(
    df, glue_ctx=glueContext, name="df"
)

#dynamicFrame.show()

atmImport = glueContext.write_dynamic_frame.from_jdbc_conf(
    frame = dynamicFrame, 
    catalog_connection = "Customer 360 Postgres", 
    connection_options = {
        "dbtable": "vpb_branch.atm", 
        "database": "postgres",
        "preactions":"TRUNCATE TABLE <table-name>"
    }, 
    transformation_ctx = "atm_import"
)

    
job.commit()