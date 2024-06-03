# import serializer from rest_framework
from rest_framework import serializers
 
# import model from models.py
from .models import Transaction, FactCustomer, Atm
 
# Create a model serializer
class TransactionsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Transaction
        fields = '__all__'

class CustomerSerializer(serializers.ModelSerializer):
    class Meta:
        model = FactCustomer
        fields = '__all__'

class AtmSerializer(serializers.ModelSerializer):
    class Meta:
        model = Atm
        fields = '__all__'