{{ config(materialized='incremental', unique_key='hk_product', tags=['hub']) }}

with products as (
select 
    hk_product,
    product_id,
    load_dt,
    'snowflake' as source
from {{ ref('stg_customer_product') }}
),

products_temp as (
    select *,
    row_number() over(partition by product_id order by load_dt desc) as rn 
    from products
)

select 
    hk_product,
    product_id,
    load_dt,
    source
from products_temp
where rn=1
-- {% if is_incremental() %}
--   and hk_product not in (select hk_product from {{ this }})
-- {% endif %}