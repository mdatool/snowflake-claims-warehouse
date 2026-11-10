-- Raw member table. All source columns stay as text; typing happens in staging.
USE ROLE SYSADMIN;
USE WAREHOUSE CLAIMS_WH;

CREATE TABLE IF NOT EXISTS CLAIMS_DW.RAW.RAW_MEMBERS (
  member_id STRING,
  first_name STRING,
  last_name STRING,
  date_of_birth STRING,
  gender STRING,
  zip_code STRING,
  state STRING,
  plan_code STRING,
  line_of_business STRING,
  effective_date STRING,
  source_file STRING,
  source_row_number NUMBER,
  loaded_at TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);

-- Load metadata makes this safe to rerun: already loaded files are skipped.
COPY INTO CLAIMS_DW.RAW.RAW_MEMBERS (
  member_id, first_name, last_name, date_of_birth, gender,
  zip_code, state, plan_code, line_of_business, effective_date,
  source_file, source_row_number
)
FROM (
  SELECT
    $1, $2, $3, $4, $5, $6, $7, $8, $9, $10,
    METADATA$FILENAME,
    METADATA$FILE_ROW_NUMBER
  FROM @CLAIMS_DW.RAW.LANDING
)
FILE_FORMAT = (FORMAT_NAME = 'CLAIMS_DW.RAW.CSV_WITH_HEADER')
PATTERN = '.*members_.*[.]csv.*';

-- Expected: 500 rows, 500 unique members, M000001 to M000500.
SELECT
  COUNT(*) AS total_rows,
  COUNT(DISTINCT member_id) AS unique_members,
  MIN(member_id) AS first_member,
  MAX(member_id) AS last_member
FROM CLAIMS_DW.RAW.RAW_MEMBERS;