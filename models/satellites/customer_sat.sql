{{ config(materialized='incremental',incremental_strategy='append', tags=['sat'])}}

with customers as (
    select
        hk_customer,
        customer_hashdiff,
        load_dt,
        customer_name,
        customer_email,
        customer_status,
        source
    from {{ ref('stg_customer_product') }}
    where hk_customer is not null
),

customers_temp as (

select *, 
row_number() over (partition by hk_customer, customer_hashdiff order by load_dt, source) as rn
from customers
),

customers_temp_1 as (
    select * from customers_temp where rn=1
),

customer_updated as (
select src.* from customers_temp_1 src where 1=1
{% if is_incremental() %}
and not exists (
select 1
from {{ this }} tgt
where tgt.hk_customer = src.hk_customer
and tgt.customer_hashdiff = src.customer_hashdiff
)
{% endif %}
)

select 
    * 
from customer_updated
