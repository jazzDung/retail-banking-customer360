classDiagram
direction BT
class account {
   text account_id
   text customer_id
   bigint account_number
   text account_type
   bigint pin
   bigint cvv
   date date_opened
   text date_closed
   text account_status
   text branch
}
class customer {
   text customer_id
   bigint identity_id
   text last_name
   text first_name
   date date_of_birth
   bigint age
   text gender
   text address
   text status
   text hometown
   text phone
   text email
   date register_date
   text customer_type
}

