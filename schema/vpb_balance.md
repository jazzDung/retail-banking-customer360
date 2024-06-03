classDiagram
direction BT
class transaction {
   text transaction_id
   bigint sender_account_no
   text sender_bank
   date transaction_date
   timestamp transaction_time
   text transaction_type
   text status
   bigint amount
   double precision fee
   text currency
   text description
   double precision rate
}

