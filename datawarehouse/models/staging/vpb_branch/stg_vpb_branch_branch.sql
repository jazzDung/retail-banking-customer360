{{
    config(
    materialized = 'view',
    unique_key = 'branch_id',
    sort = [
        'branch_id',
        'branch_name'
    ]
    )
}}

with source as (
      select * from {{ source('vpb_branch', 'branch') }}
),

renamed as (
    select
        {{ adapter.quote("region") }}::text as branch_region,
        {{ adapter.quote("province") }}::text as branch_province,
        {{ adapter.quote("branch_name") }}::text  as branch_name,
        {{ adapter.quote("branch_id") }}::text as branch_id,
        {{ adapter.quote("address") }}::text as branch_address

    from source
)
select * from renamed
  