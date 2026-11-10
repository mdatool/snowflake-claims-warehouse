-- One database with a schema per pipeline layer.
USE ROLE SYSADMIN;

CREATE DATABASE IF NOT EXISTS CLAIMS_DW;

CREATE SCHEMA IF NOT EXISTS CLAIMS_DW.RAW;      -- files as received
CREATE SCHEMA IF NOT EXISTS CLAIMS_DW.STAGING;  -- cleaned and typed
CREATE SCHEMA IF NOT EXISTS CLAIMS_DW.MARTS;    -- facts and dimensions