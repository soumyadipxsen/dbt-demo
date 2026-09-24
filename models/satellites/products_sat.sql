{{config(materialized='incremental', incremental_strategy='append', tags=['sat'])}}

with products as (
select
    hk_product,
    product_hashdiff,
    load_dt,
    product_name,
    product_category,
    product_price,
    source
from {{ ref('stg_customer_product') }}
where hk_product is not null

),

product_temp as (
select *,
row_number() over (partition by hk_product, product_hashdiff order by load_dt, source) as rn
from products
),

product_temp_1 as (
select * from product_temp
where rn=1
),

product_unique as (
select src.*
from product_temp_1 src
{% if is_incremental() %}
where not exists (
select 1
from {{ this }} tgt
where tgt.hk_product = src.hk_product
and tgt.product_hashdiff = src.product_hashdiff
)
{% endif %}
)

select * from product_unique