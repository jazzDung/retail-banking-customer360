classDiagram
direction BT
class savings_account {
   text savings_account_id
   text product_id
   text customer_id
   text account_number
   text deposit_amount
   date opening_date
   date maturity_date
   text status
   timestamp created_at
   text updated_at
   text seller_id
}
class savings_account_transaction {
   text transaction_id
   text savings_account_id
   date transaction_date
   text transaction_type
   double precision transaction_amount
   double precision balance_after
   timestamp created_at
   timestamp updated_at
   text description
   text teller_id
   text channel
}
class savings_product {
   text product_id
   text product_name
   bigint min_term
   bigint max_term
   double precision interest_rate
   bigint min_deposit
   text deposit_method
   text interest_payment
   text promotion
   date created_at
   text updated_at
}

