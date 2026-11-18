with source as (

    select * from {{ source('raw', 'raw_members') }}

),

renamed as (

    select
        trim(member_id)                   as member_id,
        trim(first_name)                  as first_name,
        trim(last_name)                   as last_name,
        try_to_date(date_of_birth)        as date_of_birth,
        upper(trim(gender))               as gender_code,
        trim(zip_code)                    as zip_code,
        upper(trim(state))                as state_code,
        upper(trim(plan_code))            as plan_code,
        upper(trim(line_of_business))     as line_of_business,
        try_to_date(effective_date)       as coverage_effective_date,
        source_file,
        source_row_number,
        loaded_at
    from source

)

select * from renamed