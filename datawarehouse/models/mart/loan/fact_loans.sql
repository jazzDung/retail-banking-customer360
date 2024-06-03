/* Mô tả: Một dòng là 1 thông tin về mỗi khoản vay của khách hàng
 */

{{
    config(
    materialized = 'table',
    unique_key = 'loan_id',
    sort = [
        'loan_id',
        'customer_id',
        'created_at'
    ]
    )
}}
    select
        *
    from
        {{ ref('stg_vpb_loan_loan') }} as ac