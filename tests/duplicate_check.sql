select 
    hk_customer,
    load_dt,
    count(*) as row_count
from {{ ref('sat_customer') }}
group by
    hk_customer,
    load_dt
having count(*) > 1