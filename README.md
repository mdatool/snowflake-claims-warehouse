# Snowflake Claims Warehouse

A hands-on health insurance claims data warehouse built on Snowflake and dbt,
using fully synthetic data.

## Layers
- **RAW:** source files loaded as received with `COPY INTO`
- **STAGING:** cleaned and typed data (dbt)
- **MARTS:** fact and dimension tables (dbt)

## Run order
Run the files in `snowflake/` in numeric order.

## Data
All members and claims are synthetic. No real PHI is used.