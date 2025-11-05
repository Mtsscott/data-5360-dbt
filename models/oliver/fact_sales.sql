{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT  
    c.customer_id as customer_key,
    e.employee_id as employee_key,
    p.product_id as product_key,
    s.store_id as store_key,
    d.date_key as date_key,
    l.quantity as quantity,
    o.total_amount,
    p.unit_price
from {{ source('oliver_landing', 'orderline') }} l
inner join {{ source('oliver_landing', 'orders') }} o
    on l.order_id = o.order_id
inner join {{ ref('oliver_dim_customer') }} c
    on o.customer_id = c.customer_key
inner join {{ ref('oliver_dim_employee') }} e
    on o.employee_id = e.employee_id
inner join {{ ref('oliver_dim_product') }} p
    on l.product_id = p.product_id
inner join {{ ref('oliver_dim_store') }} s
    on o.store_id = s.store_id
inner join {{ ref('oliver_dim_date') }} d
    on o.order_date = d.date_day
