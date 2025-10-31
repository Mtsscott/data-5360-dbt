{{ config(
    materialized = 'table',
    schema = 'ecoessentials'
    )
}}

select
product_key as product_key,
product_id,
product_type,
product_name,
price
FROM {{ source('ecoessentials', 'product') }}