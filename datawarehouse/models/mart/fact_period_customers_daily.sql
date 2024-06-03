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

    select
          *
    from {{ ref('int_fact_period_customers_daily') }}
    where 1 = 1
    {% if is_incremental() %}
    and gen_date::date >= CURRENT_DATE - INTERVAL '90 day'  --- giả lập bảng transaction nang, lam incremental toi uu luong
    {% endif %}