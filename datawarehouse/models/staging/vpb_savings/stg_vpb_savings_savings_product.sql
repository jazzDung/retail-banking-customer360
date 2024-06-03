/* Mô tả: Một dòng là 1 thông tin về các sản phẩm gửi tiết kiệm
 */
{{
    config(
    materialized = 'view',
    unique_key = 'product_id',
    sort = [
        'product_id',
        'created_at'
    ]
    )
}}

with source as (
      select * from {{ source('vpb_savings', 'savings_product') }}
),

renamed as (
    select
        {{ adapter.quote("product_id") }}::text ,
        {{ adapter.quote("product_name") }}::text ,
        {{ adapter.quote("min_term") }}::int ,
        {{ adapter.quote("max_term") }}::int ,
        {{ adapter.quote("interest_rate") }}::decimal ,
        {{ adapter.quote("min_deposit") }}::float ,
        {{ adapter.quote("deposit_method") }}::text ,
        {{ adapter.quote("interest_payment") }}::text ,
        {{ adapter.quote("promotion") }}::text ,
        {{ adapter.quote("created_at") }}::timestamp ,
        {{ adapter.quote("updated_at") }}  --- cột này đang bị null nên tạm thời không check data_type

    from source
)
select * from renamed
  