{{config(materialized='incremental', incremental_strategy='append')}}

with products as (

    select
        hk_product,
        load_dt,
        product_name,
        product_category,
        product_price,
        source
    from {{ ref('stg_customer_product') }}
    where hk_product is not null

)

select * from products