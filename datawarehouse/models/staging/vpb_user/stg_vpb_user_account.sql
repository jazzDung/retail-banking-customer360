with source as (
      select
           {{ sensitive_columns_sources('vpb_user', 'account') }}
      from {{ source('vpb_user', 'account') }}
),
renamed as (
    select
        {{ adapter.quote("account_id") }}::text ,
        {{ adapter.quote("customer_id") }}::text,
        {{ adapter.quote("account_number") }}::text,  --- Thông tin nhạy cảm
        {{ adapter.quote("account_type") }}::text,
        {{ adapter.quote("pin") }}, --- Thông tin nhạy cảm
        {{ adapter.quote("cvv") }},
        {{ adapter.quote("date_opened") }}::date as opened_date,
        {{ adapter.quote("date_closed") }} as closed_date,
        {{ adapter.quote("account_status") }}::text as account_status,
        {{ adapter.quote("branch") }}::text as branch_id

    from source
)
select * from renamed
  