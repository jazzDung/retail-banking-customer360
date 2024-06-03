from django.urls import path
from . import views
 
urlpatterns = [
    path('transactions/', views.view_transaction_items, name="transactions"),
    path('customers/', views.view_customer_items, name="customers"),
    path('atms/', views.view_atm_items, name="atms")
]