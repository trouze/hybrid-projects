select
    customer_id,
    name,
    signup_date,
    current_timestamp() as last_model_run,
    'test_this' as test_col,
    'test2' as test2
from {{ ref('stg_customers') }}