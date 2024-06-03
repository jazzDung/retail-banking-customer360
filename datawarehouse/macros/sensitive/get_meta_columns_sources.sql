{% macro get_meta_columns_sources(schema_name, model_name, meta_key=none, node_type='source', project='customer360') %}

	{% if execute %}
    
        {% set meta_columns = [] %}

	    {% set fqname = node_type ~ '.' ~ project ~ '.' ~ schema_name ~ '.' ~ model_name %}
	    {% set columns = graph.sources[fqname]['columns']  %}
        {% do log("columns: " ~ column, info=true) %}
        {% for column in columns %}
            {% if meta_key is not none %}

                {% if graph.sources[fqname]['columns'][column]['meta'][meta_key] == true %}

                    {# {% do log("Sensitive: " ~ column, info=true) %} #}

                    {% do meta_columns.append(column) %}

                {% endif %}
            {% else %}
                {% do meta_columns.append(column) %}
            {% endif %}
        {% endfor %}
	
        {{ return(meta_columns) }}

	{% endif %}

{% endmacro %}

