-- macros/test_zip_result.sql

{% macro test_zip_result() %}
    {% if execute %}
        {# Simulate a mock result with two columns and known row order #}
        {% set mock_query %}
            SELECT 'foo' AS col1, 'bar' AS col2 UNION ALL
            SELECT 'baz', 'qux' UNION ALL
            SELECT 'spam', 'eggs'
        {% endset %}

        {% set result = run_query(mock_query) %}

        {# Pull column values #}
        {% set col1_values = result.columns[0].values() %}
        {% set col2_values = result.columns[1].values() %}
        {%- set relations = [] -%}
        {# Optional: loop over zipped values to simulate Relation creation #}
        {% for val1, val2 in zip(col1_values, col2_values) %}
            {{ log("Row: " ~ val1 ~ ", " ~ val2, info=True) }}
            {%- do relations.append(val1~val2) -%}
        {% endfor %}
        {{ log(relations, info=True) }}

    {% endif %}
{% endmacro %}