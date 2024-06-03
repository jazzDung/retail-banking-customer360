from rest_framework import  status
from rest_framework.response import Response
from .serializers import TransactionsSerializer, CustomerSerializer, AtmSerializer
from .models import Transaction, FactCustomer, Atm
from rest_framework.decorators import api_view
from core.filter_util import FilterUtil

@api_view(['GET'])
def view_transaction_items(request):
    return handle_filter_items(request, Transaction, TransactionsSerializer)

@api_view(['GET'])
def view_customer_items(request):
    return handle_filter_items(request, FactCustomer, CustomerSerializer)

@api_view(['GET'])
def view_atm_items(request):
    return handle_filter_items(request, Atm, AtmSerializer)

def handle_filter_items(request, query_set, serializerModel):
    query_params = request.query_params.get('query', None)
    order_info = request.query_params.get("order_by", None)

    items = query_set.objects.all()

    if query_params:
        try:
            items = FilterUtil.filter_with_operators(query_params, items)
            items = FilterUtil.sort_with_columns(order_info, items)
        except Exception as e:
                return Response(
                    {"error": str(e)},
                    status=status.HTTP_400_BAD_REQUEST)

    serializer = serializerModel(items, many=True)
    return Response(serializer.data)