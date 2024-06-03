{% macro sensitive_columns_sources(source_schema, source_table) %}

    {% set meta_columns = get_meta_columns_sources(schema_name=source_schema, model_name=source_table, meta_key='sensitive') %}
    {% set list_normal_columns = dbt_utils.star(from=source(source_schema, source_table), except=meta_columns) %}
    {{ dbt_utils.star(from=source(source_schema, source_table), except=meta_columns) }} ,

    {% for column in meta_columns %}
    {{ hash_of_column(column) }} {% if not loop.last %} , {% endif %}
    {% endfor %}

{% endmacro %}
