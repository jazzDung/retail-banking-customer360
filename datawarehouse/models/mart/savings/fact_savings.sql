/* Mô tả: Môt dòng là 1 giao chuyển tiền của KH
 */

{{
    config(
    materialized = 'table',
    unique_key = 'savings_id',
    sort = [
        'savings_id',
        'account_id',
        'created_at',
        'customer_id'
    ]
    )
}}


with source as (
    select
        *
    from {{ ref('int_fact_savings') }}
)
    select * from source