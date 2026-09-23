{{ config(materialized='incremental') }}

select
    hk_customer_product,
    hk_customer,
    hk_product,
    load_dt,
    source 
from {{ref('stg_customer_product')}}
-- where 1=1
-- {% if is_incremental() %}
--   and hk_customer_product not in (select hk_customer_product from {{ this }})
-- {% endif %}