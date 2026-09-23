{{ config(unique_key='customer_id') }}

with source_data as (
    select * from {{ source('stg', 'CUSTOMER_PRODUCT') }}
)

select 
    nullif(trim(customer_id), '') as customer_id,
    nullif(trim(customer_name), 'NA') as customer_name,
    nullif(trim(customer_email), 'NA') as customer_email,
    nullif(trim(customer_status), 'NA') as customer_status,
    nullif(trim(product_id), '') as product_id,
    nullif(trim(product_name), 'NA') as product_name,
    nullif(trim(product_category), 'NA') as product_category,
    nullif(product_price, 0) as product_price,
    nullif(trim(relationship_type), 'NA') as relationship_type,
    source_load_dts as load_dt, 
    'snowflake' as source,
    md5(customer_id) as hk_customer,
    md5(product_id) as hk_product,
    md5(concat(customer_id,'||',product_id)) as hk_customer_product
from source_data
where customer_id is not null
and product_id is not null