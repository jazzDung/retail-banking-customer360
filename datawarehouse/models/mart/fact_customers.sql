/* mô tả: Một dòng là thông tin chi tiết về 1 khách hàng và các metric cập nhật mới nhất tới ngày T-1 của KH
 */
{{
    config(
        materialized = 'table',
        unique_key = 'account_id',
        sort = [
            'account_id',
            'date_opened'
        ]
    )
}}

select
    *
from
    {{ ref('int_fact_customers') }} as ac
