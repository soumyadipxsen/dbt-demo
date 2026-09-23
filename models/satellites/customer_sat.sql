{{ config(materialized='incremental',incremental_strategy='append')}}

with customers as (
    select
        hk_customer,
        load_dt,
        customer_name,
        customer_email,
        customer_status,
        source
    from {{ ref('stg_customer_product') }}
    where hk_customer is not null
)

select 
    * 
from customers
