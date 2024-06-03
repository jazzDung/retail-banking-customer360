# Define the default arguments for the DAG
from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from datetime import datetime, timedelta

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime.now() - timedelta(days=1),
    # 'start_date': datetime.now(),
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Create the DAG with the specified schedule interval
with DAG(
    dag_id='pull_dbt_project', 
    default_args=default_args, 
    schedule_interval=timedelta(days=1)
):

    # Define the dbt run command as a BashOperator
    # install_git = BashOperator(
    #     task_id='install_git',
    #     bash_command='''
    #         sudo apt update
    #         sudo apt install git
    #     ''',
    #     run_as_user='root'
    # )

    # install_dependency = BashOperator(
    #     task_id='install_dependency',
    #     bash_command='''
    #         pip install \
    #             dbt-core==1.5.0 \
    #             dbt-postgres==1.5.0 \
    #     '''
    # )

    remove_dbt_project = BashOperator(
        task_id='remove_dbt_project',
        bash_command='''
            rm -rf /home/airflow/datawarehouse && pwd 
        '''
    )

    clone_dbt_project = BashOperator(
        task_id='clone_dbt_project',
        bash_command='git clone https://github.com/jazzDung/datawarehouse.git $HOME/datawarehouse',
        # run_as_user='airflow'
    )

    install_dbt_deps = BashOperator(
        task_id='install_dbt_deps',
        bash_command='dbt deps --profiles-dir $HOME/datawarehouse/.config --project-dir $HOME/datawarehouse',
        # run_as_user='airflow'
    )

    # install_git >> install_dependency >> remove_dbt_project >> clone_dbt_project
    remove_dbt_project >> clone_dbt_project >> install_dbt_deps