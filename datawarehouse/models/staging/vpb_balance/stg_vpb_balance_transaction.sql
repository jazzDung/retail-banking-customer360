/* Mô tả: Môt dòng là 1 giao chuyển tiền của KH
 */

{{
    config(
    materialized = 'incremental',
    unique_key = 'transaction_id',
    sort = [
        'transaction_id',
        'sender_account_no',
        'txn_time',
        'sender_bank'
    ],
    sort_type = 'interleaved'
    )
}}


with source as (
    select
        *
    from {{ source('vpb_balance', 'transaction') }}
    where 1 = 1
    {% if is_incremental() %}
    and transaction_time >= CURRENT_DATE - INTERVAL '30 day'  --- giả lập bảng transaction nang, lam incremental toi uu luong
    {% endif %}
),
renamed as (
    select
        {{ adapter.quote("transaction_id") }}::text as transaction_id,
        {{ adapter.quote("sender_account_no") }}::text  as sender_account_no,
        {{ adapter.quote("sender_bank") }}::text,
        {{ adapter.quote("transaction_date") }}::date  as txn_date,
        {{ adapter.quote("transaction_time") }}::timestamp as txn_time ,
        {{ adapter.quote("transaction_type") }}::text ,
        {{ adapter.quote("status") }}::text ,
        {{ adapter.quote("amount") }}::float,
        {{ adapter.quote("fee") }}::float,
        {{ adapter.quote("currency") }}::text,
        {{ adapter.quote("description") }}::text,
        {{ adapter.quote("rate") }}::float

    from source
)
select * from renamed
  