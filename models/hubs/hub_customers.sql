{{ config(materialized='incremental', unique_key='hk_customer', tags=['hub']) }}

with customers as (
    select 
    hk_customer,
    customer_id,
    load_dt,
    source
from {{ ref('stg_customer_product') }}
),

customers_temp as (
    select *,
    row_number() over(partition by customer_id order by load_dt desc) as rn 
    from customers
)

select 
    hk_customer,
    customer_id,
    load_dt,
    source
from customers_temp
where rn=1
-- {% if is_incremental() %}
--   and hk_customer not in (select hk_customer from {{ this }})
-- {% endif %}