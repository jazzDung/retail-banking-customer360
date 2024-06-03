classDiagram
direction BT
class dbt_metrics_default_calendar {
   date date_day
   date date_week
   date date_month
   date date_quarter
   date date_year
}
class dim_date {
   integer date_id
   text date
   text earliest_time
   text latest_time
   text au_format_date
   text us_format_date
   integer year_number
   integer year_week_number
   integer year_day_number
   integer au_fiscal_year_number
   integer us_fiscal_year_number
   text first_day_of_year
   text last_day_of_year
   integer qtr_number
   integer au_fiscal_qtr_number
   integer us_fiscal_qtr_number
   text first_day_of_quarter
   text last_day_of_quarter
   integer month_number
   text month_name
   integer month_day_number
   text first_day_of_month
   text last_day_of_month
   integer week_day_number
   text first_day_of_week
   text last_day_of_week
   text day_name
   integer is_weekday
   integer is_eom
   integer year_name
   text quater_year_name
   text month_year_name
   text week_year_name
   text is_holiday
   integer is_eom_trading
}
class fact_accounts {
   text account_id
   text customer_id
   text account_number
   text account_type
   text pin
   bigint cvv
   date opened_date
   text closed_date
   text account_status
   text branch_id
   text full_name
   integer age
   text gender
   date customer_register_date
   text branch_province
   text branch_name
}
class fact_accounts_savings {
   date txn_date
   double precision transaction_amount
}
class fact_customers {
   text customer_id
   text identity_id
   text last_name
   text first_name
   text full_name
   text date_of_birth
   integer age
   text gender
   text address
   text status
   text hometown
   text phone
   text email
   date customer_register_date
   text customer_type
   date first_loan_date
   bigint loan_count
   double precision origin_principal
   numeric total_interest
   numeric paid_interest
   double precision unpaid_loan_amount
   bigint unpaid_loan_count
   date first_savings_date
   bigint savings_count
   double precision origin_deposit_amount
   double precision matured_deposit_amount
   text customer_segment
   bigint nav
   bigint total_balance
   bigint deposit
   bigint withdraw
}
class fact_loans {
   text customer_id
   text loan_id
   text loan_service
   text loan_type
   double precision loan_amount
   double precision interest_rate
   integer term
   date created_date
   date start_date
   text end_date
   text status
   numeric due_principal
   numeric due_interest
   numeric paid_principal
   numeric paid_interest
   numeric undue_principal
   numeric undue_interest
   numeric overdue_principal
   numeric overdue_interest
   numeric to_collect_principal
   numeric to_collect_interest
   numeric interest_on_overdue_loan
   numeric unpaid_principal
   numeric unpaid_interest
   text description
   date created_time
   text release_time
   date overdue_date
   text disbursement_date
   text modified_time
}
class fact_period_customers_daily {
   text unique_id
   date gen_date
   text customer_id
   bigint nav
   bigint total_balance
   bigint deposit
   bigint withdraw
   bigint total_loan
   bigint new_loan
   bigint total_saving
   bigint new_saving
   text customer_segment
   integer is_recommended_loan
   text recommended_loan_type
   integer is_recommended_savings
   integer is_recommended_credit_card
   text recommended_credit_card_type
   text full_name
   text date_of_birth
   text gender
   date customer_register_date
   text customer_type
}
class fact_savings_accounts {
   text savings_id
   text product_id
   text product_name
   numeric interest_rate
   text promotion
   text customer_id
   text account_id
   text account_number
   double precision deposit_amount
   date opening_date
   date maturity_date
   text status
   timestamp created_at
   text updated_at
}

