/* mô tả: Một dòng là thông tin chi tiết về 1 tiểu khoản của KH
 */
{{
    config(
        materialized = 'view',
        unique_key = 'account_id',
        sort = [
            'account_id',
            'account_opened_date'
        ]
    )
}}
with account_dedup as ( --- Xử lý dup số tiểu khoản trong TH dữ liệu nguồn bị dup
    select
        account_id,
        customer_id,
        account_number,
        account_type,
        pin , --- Thông tin nhạy cảm
        cvv ,
        opened_date as account_opened_date,
        closed_date ,
        account_status,
        branch_id
    from
        (select
            *,
            row_number() OVER (PARTITION BY account_id ORDER BY opened_date DESC) AS rn
        from
          {{ ref('stg_vpb_user_account') }} as ac
        )
    where  rn = 1
    )
select
    ac.*,
    dc.full_name,
    dc.age,
    dc.gender,
    dc.customer_register_date,
    br.branch_province,
    br.branch_name
from account_dedup as ac
left join {{ ref('int_dim_custormers') }} as dc  on ac.customer_id = dc.customer_id
left join {{ ref('stg_vpb_branch_branch') }} as  br on  br.branch_id = ac.branch_id