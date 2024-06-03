/* Mô tả: Một dòng là 1 thông tin về khoản gửi tiết kiệm của KH
 */
{{
    config(
    materialized = 'table',
    unique_key = 'savings_id',
    sort = [
        'savings_id',
        'deposit_amount',
        'product_id',
        'opening_date'
    ]
    )
}}

with source as (
      select
            {{ sensitive_columns_sources('vpb_savings', 'savings_account') }}
      from {{ source('vpb_savings','savings_account') }}
),

renamed as (
    select
        {{ adapter.quote("savings_account_id") }}::text as savings_id,
        {{ adapter.quote("product_id") }}::text ,
        {{ adapter.quote("customer_id") }}::text ,
        {{ adapter.quote("deposit_amount") }}::float ,
        {{ adapter.quote("opening_date") }}::date ,
        {{ adapter.quote("maturity_date") }}::date ,
        {{ adapter.quote("status") }}::text ,
        {{ adapter.quote("created_at") }} ,
        {{ adapter.quote("updated_at") }} ,
        {{ adapter.quote("seller_id") }}::text

    from source
)
select
    *
from renamed
  