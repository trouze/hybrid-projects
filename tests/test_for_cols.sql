-- take all project models
with models as (
    select distinct node_unique_id from {{ ref('stg_columns') }}
),
-- aggregate count of columns that should exist for each project model
columns as (
    select
      node_unique_id,
      count(distinct name) as found_cols
    from {{ ref('stg_columns') }}
    where name in ('load_dts') -- specify required columns here
      and node_unique_id like '%{{ project_name }}%'
    group by node_unique_id
),
-- filter for models in violation
result as (
  select
    models.node_unique_id as node_id,
    columns.found_cols as found_cols
  from models left join columns on models.node_unique_id = columns.node_unique_id
)
select * from result
where found_cols < 1 or found_cols is null