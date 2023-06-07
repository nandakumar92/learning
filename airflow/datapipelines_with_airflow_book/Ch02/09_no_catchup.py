import json, requests, airflow, pathlib
from airflow import DAG 
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
import pandas as pd
import datetime

dag=DAG(x
    dag_id="01_unscheduled",
    start_date=datetime(2019,1,1),
    end_date=dt.datetime(year=2019, month=1, day=5),
    catchup=False,
    schedule_interval="@daily"
)

fetch_events=BashOperator(
    task_id="fetch_events"
    bash_command=(
     "mkdir -p /data/events &&"
     "curl -o /data/events/{{ds}}.json "
     "http://events_api:5000/events?"
        "start_date={{ds}}&"
        "end_date={{next_ds}}"
    ),
    dag=dag
) 

def _calculate_stats(input_path,output_path):

    Path(output_path).parent.mkdir(exist_ok=True)
    events=pd.read_json(input_path)
    stats=events.groupby(["date","user"]).size().reset_index()
    stats.to_csv(output_path,index=False)


calculate_stats=PythonOperator(
    task_id="calculate_stats",
    python_callable= _calculate_stats,
    op_kwargs={"input_path": "/data/events/{{ds}}.json", "output_path": "/data/stats/{{ds}}.csv"},
    dag=dag
)


fetch_events >> calculate_stats

