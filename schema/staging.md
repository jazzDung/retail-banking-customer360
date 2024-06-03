classDiagram
direction BT
class int_dim_accounts {
   text account_id
   text customer_id
   text account_number
   text account_type
   text pin
   bigint cvv
   date account_opened_date
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
class int_dim_custormers {
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
}
class int_fact_customers {
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
class int_fact_loans {
   text loan_id
   text customer_id
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
   text release_time
   date overdue_date
   text disbursement_date
   text modified_time
   text full_name
   integer customer_age
   text gender
   text address
   date customer_register_date
   text customer_type
}
class int_fact_period_customers_daily {
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
class int_fact_savings {
   text savings_id
   text product_id
   text product_name
   numeric interest_rate
   text promotion
   text customer_id
   text full_name
   integer age
   text gender
   double precision deposit_amount
   date opening_date
   date maturity_date
   text status
   timestamp created_at
   text updated_at
}
class int_period_bank_metric_daily {
   date txn_date
   double precision transaction_amount
}
class stg_vpb_balance_transaction {
   text transaction_id
   text sender_account_no
   text sender_bank
   date txn_date
   timestamp txn_time
   text transaction_type
   text status
   double precision amount
   double precision fee
   text currency
   text description
   double precision rate
}
class stg_vpb_branch_atm {
   text atm_id
   text name
   boolean vpb_branch
   boolean is_atm
   boolean is_cdm
   boolean is_atm_247
   text atm_247_label
   boolean is_household
   boolean is_sme
   text address
   text latitude
   text longitude
   text phone_number
}
class stg_vpb_branch_branch {
   text branch_region
   text branch_province
   text branch_name
   text branch_id
   text branch_address
}
class stg_vpb_loan_loan {
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
class stg_vpb_loan_loan_payment {
   text loan_payment_id
   date scheduled_payment_date
   numeric payment_amount
   numeric principal_amount
   numeric interest_amount
   numeric paid_amount
   date paid_date
}
class stg_vpb_other_customers_nav_daily {
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
}
class stg_vpb_savings_savings_account {
   text savings_id
   text product_id
   text customer_id
   double precision deposit_amount
   date opening_date
   date maturity_date
   text status
   timestamp created_at
   text updated_at
   text seller_id
}
class stg_vpb_savings_savings_account_transaction {
   text transaction_id
   text savings_id
   date transaction_date
   text transaction_type
   double precision transaction_amount
   double precision balance_after
   text created_at
   text updated_at
   text description
   text teller_id
   text channel
}
class stg_vpb_savings_savings_product {
   text product_id
   text product_name
   integer min_term
   integer max_term
   numeric interest_rate
   double precision min_deposit
   text deposit_method
   text interest_payment
   text promotion
   timestamp created_at
   text updated_at
}
class stg_vpb_user_account {
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
}
class stg_vpb_user_customer {
   text customer_id
   text identity_id
   text last_name
   text first_name
   text date_of_birth
   integer age
   text gender
   text address
   text status
   text hometown
   text phone
   text email
   date register_date
   text customer_type
}

