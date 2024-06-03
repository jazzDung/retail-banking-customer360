{{
    config(
    materialized = 'view',
    unique_key = 'loan_id',
    sort = [
        'loan_id',
        'loan_type',
        'created_date',
        'description'
    ],
    sort_type = 'interleaved'
    )
}}

with source as (
    select
        *
    from {{ source('vpb_loan','loan') }}
),

renamed as (
    select
        {{ adapter.quote("customer_id") }}::text ,
        {{ adapter.quote("loan_id") }}::text ,
        {{ adapter.quote("loan_service") }}::text ,
        {{ adapter.quote("loan_type") }}::text ,
        {{ adapter.quote("loan_amount") }}::float ,
        {{ adapter.quote("interest_rate") }}::float ,
        {{ adapter.quote("term") }}::int as term,
        created_date::date,
        start_date,
        end_date,
        {{ adapter.quote("status") }}::text,
        {{ adapter.quote("due_principal") }}::decimal ,
        {{ adapter.quote("due_interest") }}::decimal ,
        {{ adapter.quote("paid_principal") }}::decimal ,
        {{ adapter.quote("paid_interest") }}::decimal ,
        {{ adapter.quote("undue_principal") }}::decimal ,
        {{ adapter.quote("undue_interest") }}::decimal ,
        {{ adapter.quote("overdue_principal") }}::decimal ,
        {{ adapter.quote("overdue_interest") }}::decimal ,
        {{ adapter.quote("to_collect_principal") }}::decimal ,
        {{ adapter.quote("to_collect_interest") }}::decimal ,
        {{ adapter.quote("interest_on_overdue_loan") }}::decimal ,
        {{ adapter.quote("unpaid_principal") }}::decimal ,
        {{ adapter.quote("unpaid_interest") }}::decimal ,
        {{ adapter.quote("description") }}::text ,
        created_time,
        release_time, --- Do có value null dạng chữ
        overdue_date, --- Do có value null dạng chữ
        disbursement_date, --- Do có value null dạng chữ
        modified_time--- Do có value null dạng chữ
    /*
        (case when created_date = 'NULL' then null  else created_date::date end) as created_date ,
        (case when start_date = 'NULL'  then null else start_date::date end) as start_date,
        (case when end_date = 'NULL'  then null else end_date::date end) as end_date, --- Do có value null dạng chữ
        (case when created_time = 'NULL' then null else created_time end) as  created_time,
        (case when release_time = 'NULL' then null else release_time end) as  release_time, --- Do có value null dạng chữ
        (case when overdue_date = 'NULL' then null else overdue_date end)  as overdue_date, --- Do có value null dạng chữ
        (case when disbursement_date = 'NULL' then null else disbursement_date end) as disbursement_date, --- Do có value null dạng chữ
        (case when modified_time = 'NULL' then null else modified_time end) as  modified_time--- Do có value null dạng chữ
     */
    from source
)
select * from renamed
  