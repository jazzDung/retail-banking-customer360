/* mô tả:
 */
{{
    config(
        materialized = 'view',
        unique_key = 'txn_date',
        sort = [
            'txn_date'
            , 'transaction_amount'
        ]
    )
}}

select
    txn_time::date as txn_date
    , sum(amount) as transaction_amount
from
  {{ ref('stg_vpb_balance_transaction') }}
group by 1
order by 1 desc