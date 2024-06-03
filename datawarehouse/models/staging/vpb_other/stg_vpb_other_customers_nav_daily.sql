/* Mô tả: Một dòng là 1 KH và 1 một ngày và các tài sản cuối ngày của KH, các label segment cuối ngày của KH
 */

{{
    config(
    materialized = 'incremental',
    unique_key = 'unique_id',
    sort = [
        'unique_id',
        'customer_id',
        'gen_date'
    ],
    sort_type = 'interleaved'
    )
}}


with source as (
    select
          *
    from {{ source('vpb_other', 'customers_nav_daily') }}
    where 1 = 1
    {% if is_incremental() %}
    and gen_date::date >= CURRENT_DATE - INTERVAL '90 day'  --- giả lập bảng transaction nang, lam incremental toi uu luong
    {% endif %}
),
renamed as (
    select
        {{ adapter.quote("gen_date") }}::date as gen_date,
        {{ adapter.quote("customer_id") }}::text ,
        {{ adapter.quote("nav") }}::bigint,
        {{ adapter.quote("total_balance") }}::bigint,
        {{ adapter.quote("deposit") }}::bigint,
        {{ adapter.quote("withdraw") }}::bigint,
        {{ adapter.quote("total_loan") }}::bigint,
        {{ adapter.quote("new_loan") }}::bigint,
        {{ adapter.quote("total_saving") }}::bigint,
        {{ adapter.quote("new_saving") }}::bigint,
        {{ adapter.quote("customer_segment") }}::text,
        {{ adapter.quote("is_recommended_loan") }},
        {{ adapter.quote("recommended_loan_type") }}::text,
        {{ adapter.quote("is_recommended_savings") }},
        {{ adapter.quote("is_recommended_credit_card") }},
        {{ adapter.quote("recommended_credit_card_type") }}::text

    from source
)
select
    {{ dbt_utils.generate_surrogate_key(['gen_date', 'customer_id']) }} AS unique_id,
    *
from renamed
  