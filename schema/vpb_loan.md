classDiagram
direction BT
class loan {
   text customer_id
   text loan_id
   text loan_service
   text loan_type
   bigint loan_amount
   double precision interest_rate
   bigint term
   date created_date
   date start_date
   text end_date
   text status
   double precision due_principal
   double precision due_interest
   double precision paid_principal
   double precision paid_interest
   double precision undue_principal
   double precision undue_interest
   double precision overdue_principal
   double precision overdue_interest
   double precision to_collect_principal
   double precision to_collect_interest
   double precision interest_on_overdue_loan
   double precision unpaid_principal
   double precision unpaid_interest
   text description
   date created_time
   text release_time
   date overdue_date
   text disbursement_date
   text modified_time
}
class loan_payment {
   date scheduled_payment_date
   double precision payment_amount
   double precision principal_amount
   double precision interest_amount
   double precision paid_amount
   date paid_date
   integer loan_payment_id
}

