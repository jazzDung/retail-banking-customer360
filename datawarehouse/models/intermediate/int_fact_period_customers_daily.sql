/* Mục tiêu: Xây dựng bảng tổng hợp thông tin về mỗi khách hàng một ngày, các metric và thông tin demographic của Kh
Lưu ý: Do dataset nguồn không có đủ, nên tạm ước lượng dữ liệu nguồn cho 3 KH điển hình
 */

{{
    config(
    materialized = 'incremental',
    unique_key = 'unique_id',
    sort = [
        'unique_id',
        'customer_id',
        'gen_date',
        'customer_register_date'
    ],
    sort_type = 'interleaved'
    )
}}


with source as (
    select
          *
    from {{ ref('stg_vpb_other_customers_nav_daily') }}
    where 1 = 1
    {% if is_incremental() %}
    and gen_date::date >= CURRENT_DATE - INTERVAL '90 day'  --- giả lập bảng transaction nang, lam incremental toi uu luong
    {% endif %}
)
select
    source.*,
    full_name,
    date_of_birth,
    gender,
--         address ,
--         status ,
--         hometown ,
--         phone ,
--         email ,
    customer_register_date,
    customer_type
from source
left join {{ ref('int_dim_custormers') }} as dc
on dc.customer_id = source.customer_id