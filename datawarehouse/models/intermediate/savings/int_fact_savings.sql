/* Mô tả: Một dòng là 1 thông tin về khoản gửi tiết kiệm của KH 1 một ngày
 */
{{
    config(
    materialized = 'view',
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
    from
        {{ ref('stg_vpb_savings_savings_account') }} as ac
)
select
    ac.savings_id,
    ac.product_id,
    pr.product_name,
    pr.interest_rate,
    pr.promotion,
    ac.customer_id,
    dc.full_name,
    dc.age,
    dc.gender,
    ac.deposit_amount ,
    (case when  ac.opening_date::date <= '2020-01-01' then '2024-02-01'
            when ac.opening_date::date <= '2021-01-01' then '2024-03-01'
            when ac.opening_date::date <= '2022-01-01' then '2024-04-01'
            when ac.opening_date::date <= '2023-01-01' then '2024-04-16'
            when ac.opening_date::date <= '2023-01-01' then '2024-04-22'
        else  ac.opening_date end)::date as  opening_date, -- Tạm xử lý dataset thêm thông tin
    ac.maturity_date,
    ac.status,
    ac.created_at,
    ac.updated_at
from source ac
left join {{ ref('int_dim_custormers') }} as dc  on ac.customer_id = dc.customer_id
left join {{ ref('stg_vpb_savings_savings_product') }} as  pr on  pr.product_id = ac.product_id