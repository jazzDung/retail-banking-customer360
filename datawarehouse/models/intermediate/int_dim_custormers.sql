/* mô tả: Một dòng là thông tin chi tiết về 1 khách hàng
 */
{{
    config(
        materialized = 'table',
        unique_key = 'customer_id',
        sort = [
            'customer_id',
            'identity_id',
            'customer_register_date'
        ]
    )
}}
with customer_dedup as ( --- Xử lý dup KH trong TH dữ liệu nguồn bị dup
    select
        customer_id,
        identity_id,
        last_name,
        first_name,
        first_name||' '|| last_name as full_name,
        date_of_birth,
        age,
        gender,
        address,
        status,
        hometown,
        phone ,
        email ,
        register_date  as customer_register_date,
        customer_type
    from
        (select
            *,
            row_number() OVER (PARTITION BY identity_id ORDER BY register_date) AS rn --- một khách hàng chỉ có 1 định danh duy nhất
        from
          {{ ref('stg_vpb_user_customer') }} as ac
        )
    where  rn = 1
    )
select
    *
from customer_dedup as ac
