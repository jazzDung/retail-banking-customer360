# Define the default arguments for the DAG
from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from datetime import datetime, timedelta

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime.now() - timedelta(days=1),
    # 'start_date': datetime(2024, 5, 6),
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Create the DAG with the specified schedule interval
dag = DAG(
    'run_all', 
    default_args=default_args, 
    schedule_interval=timedelta(days=1)
)

# Define the dbt run command as a BashOperator
run_dbt_model = BashOperator(
    task_id='run_dbt_model',
    bash_command='dbt run --profiles-dir $HOME/datawarehouse/.config --project-dir $HOME/datawarehouse',
    # bash_command='dbt run --profiles-dir $HOME/datawarehouse/.config --project-dir $HOME/datawarehouse',
    dag=dag
)

run_dbt_model