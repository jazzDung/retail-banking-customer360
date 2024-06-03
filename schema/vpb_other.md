classDiagram
direction BT
class customers_nav_daily {
   text gen_date
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

