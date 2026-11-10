-- Landing stage for source files, plus a reusable CSV file format.
USE ROLE SYSADMIN;

CREATE STAGE IF NOT EXISTS CLAIMS_DW.RAW.LANDING
  COMMENT = 'Landing area for synthetic claims files';

CREATE FILE FORMAT IF NOT EXISTS CLAIMS_DW.RAW.CSV_WITH_HEADER
  TYPE = CSV
  SKIP_HEADER = 1
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
  TRIM_SPACE = TRUE
  EMPTY_FIELD_AS_NULL = TRUE;

-- Upload data/batch_01/members_batch_01.csv to @CLAIMS_DW.RAW.LANDING/batch_01/
-- with Snowsight (Add Data > Load files into a Stage), then confirm:
-- LIST @CLAIMS_DW.RAW.LANDING;