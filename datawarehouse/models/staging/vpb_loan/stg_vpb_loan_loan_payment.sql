{{
    config(
    materialized = 'incremental',
    unique_key = 'scheduled_payment_date',
    sort = [
        'payment_amount',
        'interest_amount',
        'paid_amount'
    ],
    sort_type = 'interleaved'
    )
}}

with source as (
      select * from {{ source('vpb_loan','loan_payment') }}
),

renamed as (
    select
        {{ adapter.quote("loan_payment_id") }}::text as loan_payment_id,
        {{ adapter.quote("scheduled_payment_date") }}::date ,
        {{ adapter.quote("payment_amount") }}::decimal ,
        {{ adapter.quote("principal_amount") }}::decimal ,
        {{ adapter.quote("interest_amount") }}::decimal ,
        {{ adapter.quote("paid_amount") }}::decimal ,
        {{ adapter.quote("paid_date") }}::date

    from source
)
select * from renamed
  