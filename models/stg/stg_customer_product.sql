{{ config(unique_key='customer_id', tags=['stg'])}}

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
    {{ dv_hash_key(['customer_id']) }} as hk_customer,
    {{ dv_hash_key(['product_id'])}} as hk_product,
    {{ dv_hash_key(['customer_id','product_id'])}} as hk_customer_product,
    {{ dv_hash_diff(["customer_name","customer_email","customer_status"]) }} as customer_hashdiff,
    {{ dv_hash_diff(["product_name","product_category","product_price"]) }} as product_hashdiff
from source_data
where customer_id is not null
and product_id is not null