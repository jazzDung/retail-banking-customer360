/* Mô tả: Một dòng là 1 chi nhánh VP bank
 */
{{
    config(
    materialized = 'incremental',
    unique_key = 'atm_id',
    sort = [
        'atm_id',
        'vpp_branch'
    ],
    sort_type = 'interleaved'
    )
}}

with source as (
      select * from {{ source('vpb_branch', 'atm') }}
),

renamed as (
    select
        {{ adapter.quote("atm_id") }}::text ,
        {{ adapter.quote("name") }}::text ,
        {{ adapter.quote("is_branch") }}::boolean as vpb_branch ,
        {{ adapter.quote("is_atm") }}::boolean ,
        {{ adapter.quote("is_cdm") }}::boolean ,
        {{ adapter.quote("is_atm_247") }}::boolean ,
        {{ adapter.quote("atm_247_label") }}::text ,
        {{ adapter.quote("is_household") }}::boolean ,
        {{ adapter.quote("is_sme") }}::boolean ,
        {{ adapter.quote("address") }}::text,
        {{ adapter.quote("latitude") }}, ---  16,817521 Lỗi
        {{ adapter.quote("longitude") }},
        {{ adapter.quote("phone_number") }}::text

    from source
)
select * from renamed
  