{% macro dv_hash_key(columns) %}
    {{ dbt_utils.generate_surrogate_key(columns) }}
{% endmacro %}


{% macro dv_hash_diff(columns) %}
    {{ dbt_utils.generate_surrogate_key(columns) }}
{% endmacro %}
