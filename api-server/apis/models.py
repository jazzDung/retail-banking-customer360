from django.db import models

# Create your models here.
class Transaction(models.Model):
    transaction_id = models.TextField(primary_key=True)
    sender_account_no = models.IntegerField(8)
    sender_bank = models.TextField()
    transaction_date = models.DateField()
    transaction_time = models.DateTimeField()
    transaction_type = models.TextField()
    status = models.TextField()
    amount = models.IntegerField()
    fee = models.FloatField(8)
    currency = models.TextField()
    description=models.TextField()
    rate = models.FloatField(8)

    def __str__(self):
        return self.transaction_id

    class Meta:
        db_table = '"vpb_balance"."transaction"'
        

class FactCustomer(models.Model):
    customer_id = models.TextField(primary_key=True)
    identity_id = models.TextField()
    last_name = models.TextField()
    first_name = models.TextField()
    full_name = models.TextField()
    date_of_birth = models.TextField()
    age = models.IntegerField(4)
    gender = models.TextField()
    address = models.TextField()
    status = models.TextField()
    hometown=models.TextField()
    phone = models.TextField()
    email= models.TextField()
    customer_register_date = models.DateField() 
    customer_type = models.TextField()
    loan_count = models.IntegerField(8)
    origin_principal = models.FloatField(8)
    total_interest = models.IntegerField()
    paid_interest = models.IntegerField()
    unpaid_loan_amount = models.FloatField(8)
    unpaid_loan_count = models.IntegerField()
    savings_count = models.IntegerField()
    origin_deposit_amount = models.FloatField()
    matured_deposit_amount = models.FloatField()

    def __str__(self):
        return self.full_name
    
    class Meta:
        db_table = '"dwh"."fact_customers"'
        
class Atm(models.Model):
    atm_id = models.TextField(primary_key=True)
    name = models.TextField()
    is_branch = models.BooleanField()
    is_atm = models.BooleanField()
    is_cdm = models.BooleanField()
    is_atm_247 = models.BooleanField()
    atm_247_label = models.TextField()
    is_household = models.BooleanField()
    is_sme = models.BooleanField()
    address = models.TextField()
    latitude = models.TextField()
    longitude = models.TextField()
    phone_number = models.TextField()

    def __str__(self):
        return self.name

    class Meta:
        db_table = '"vpb_branch"."atm"'