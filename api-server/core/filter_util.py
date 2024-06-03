import json

from django.db.models import Q
from core import UnsupportedFilterOperation
from rest_framework.response import Response
from rest_framework import  status

class FilterUtil:
    #query with condition
    def filter_with_operators(query_params, query_set):
        query_dict = json.loads(query_params)
        
        filter_operations = {
            'in': lambda key, val: Q(**{f'{key}__in': val}),
            'greaterThan': lambda key, val: Q(**{f'{key}__gt': val}),
            'lessThan': lambda key, val: Q(**{f'{key}__lt': val}),
            'greaterThanOrEqual': lambda key, val: Q(**{f'{key}__gte': val}),
            'lessThanOrEqual': lambda key, val: Q(**{f'{key}__lte': val}),
            'exact': lambda key, val: Q(**{f'{key}__exact': val}),
            'contains': lambda key, val: Q(**{f'{key}__icontains': val}),
            'notExact': lambda key, val: ~Q(**{f'{key}': val})
        }

        for key, value in query_dict.items():
            if isinstance(value, dict):
                for op, val in value.items():
                    if op in filter_operations:
                        query_set = query_set.filter(filter_operations[op](key, val))
                    else:
                        raise UnsupportedFilterOperation(op)

        return query_set
    
    #order with columns
    def sort_with_columns(order_params, query_set):
        order_dict = json.loads(order_params)

        if order_dict and "columns" in order_dict and "type" in order_dict:
            columns = order_dict["columns"]
            order_type = order_dict["type"]

            if order_type == "desc":
                columns = [f"-{column}" for column in columns]
            elif order_type == "asc":
                columns = [f"{column}" for column in columns]
            else:
                raise UnsupportedFilterOperation(order_type)

            query_set = query_set.order_by(*columns)

        return query_set
    
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