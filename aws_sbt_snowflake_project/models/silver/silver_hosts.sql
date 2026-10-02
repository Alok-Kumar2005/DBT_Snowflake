{{ config(materialized='incremental', unique_key='HOST_ID') }}

select 
    HOST_ID,
    REPLACE(HOST_NAME, ' ', '_') as HOST_NAME,
    HOST_SINCE,
    IS_SUPERHOST,
    RESPONSE_RATE,
    CASE 
        WHEN RESPONSE_RATE > 95 THEN 'VERY GOOD'
        WHEN RESPONSE_RATE > 80 THEN 'GOOD'
        WHEN RESPONSE_RATE > 60 THEN 'FAIR'
        ELSE 'POOR'
    END as RESPONSE_TIME_QUALITY,
    CREATED_AT
from 
    {{ ref('bronze_hosts') }}