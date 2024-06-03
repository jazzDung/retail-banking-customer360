{# with source as (
      select
            *
      from {{ source('vpb_user', 'customer') }}
), #}

with source as (
    select
        {{ sensitive_columns_sources('vpb_user', 'customer') }}
    from {{ source('vpb_user', 'customer') }}
),
renamed as (
    select
        {{ adapter.quote("customer_id") }}::text ,
        {{ adapter.quote("identity_id") }}::text, -- Cột thông tin nhạy cảm
        {{ adapter.quote("last_name") }}::text,
        {{ adapter.quote("first_name") }}::text,
        {{ adapter.quote("date_of_birth") }}::text,
        {{ adapter.quote("age") }}::int ,
        {{ adapter.quote("gender") }}::text,
        {{ adapter.quote("address") }}::text, -- Cột thông tin nhạy cảm
        {{ adapter.quote("status") }}::text,
        {{ adapter.quote("hometown") }}::text,
        {{ adapter.quote("phone") }}::text, -- Cột thông tin nhạy cảm
        {{ adapter.quote("email") }}::text, -- Cột thông tin nhạy cảm
        {{ adapter.quote("register_date") }}::date as register_date ,
        {{ adapter.quote("customer_type") }}::text

    from source
)
select * from renamed
  