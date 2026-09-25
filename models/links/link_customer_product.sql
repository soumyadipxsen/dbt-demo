{{ config(materialized='incremental',tags=['link']) }}
with customer_product as(
select
    hk_customer_product,
    hk_customer,
    hk_product,
    load_dt,
    source 
from {{ref('stg_customer_product')}}
),

customer_product_temp as (
select *,
    row_number() over(partition by hk_customer_product order by load_dt desc) as rn
from customer_product
),

customer_product_temp_1 as (
select * from customer_product_temp where rn = 1
)

select
    hk_customer_product,
    hk_customer,
    hk_product,
    load_dt,
    source
from customer_product_temp_1
where 1=1
{% if is_incremental() %}
  and hk_customer_product not in (select hk_customer_product from {{ this }})
{% endif %}