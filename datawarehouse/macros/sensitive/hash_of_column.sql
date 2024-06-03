{% macro hash_of_column(column) %}
    MD5(cast({{column}} as TEXT)) AS {{column}}
{% endmacro %}
