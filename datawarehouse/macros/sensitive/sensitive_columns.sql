{% macro sensitive_columns(source_table) %}

    {% set meta_columns = get_meta_columns(source_table, "sensitive") %}
    {% set list_normal_columns = dbt_utils.star(from=ref(source_table), except=meta_columns) %}
    {{ dbt_utils.star(from=ref(source_table), except=meta_columns) }} ,

    {% for column in meta_columns %}
    {{ hash_of_column(column) }} {% if not loop.last %} , {% endif %}
    {% endfor %}

{% endmacro %}
