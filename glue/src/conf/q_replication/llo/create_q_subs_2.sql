-- This file is part of the Grid LSC User Environment (GLUE)
-- 
-- GLUE is free software: you can redistribute it and/or modify it under the
-- terms of the GNU General Public License as published by the Free Software
-- Foundation, either version 3 of the License, or (at your option) any later
-- version.
-- 
-- This program is distributed in the hope that it will be useful, but WITHOUT
-- ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-- FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
-- details.
-- 
-- You should have received a copy of the GNU General Public License along
-- with this program.  If not, see <http://www.gnu.org/licenses/>.

--Beginning of script 2--   DatabaseDB2LUOW (SEG_LLO) [WARNING***Please do not alter this line]--
-- CONNECT TO SEG_LLO USER XXXX using XXXX#
CREATE BUFFERPOOL BP8K SIZE 125 PAGESIZE 8192#
CREATE TABLESPACE QPASN PAGESIZE 8192 MANAGED BY SYSTEM USING 
('QPASN_TSC') BUFFERPOOL BP8K#
CREATE TABLE ASN.IBMQREP_DELTOMB
(
 TARGET_OWNER VARCHAR(30) NOT NULL,
 TARGET_NAME VARCHAR(128) NOT NULL,
 VERSION_TIME TIMESTAMP NOT NULL,
 VERSION_NODE SMALLINT NOT NULL,
 KEY_HASH INTEGER NOT NULL,
 PACKED_KEY VARCHAR(4096) FOR BIT DATA NOT NULL
)
 IN QPASN#
ALTER TABLE ASN.IBMQREP_DELTOMB
 VOLATILE CARDINALITY#
CREATE INDEX ASN.IX1DELTOMB ON ASN.IBMQREP_DELTOMB
(
 VERSION_TIME ASC,
 TARGET_NAME ASC,
 TARGET_OWNER ASC,
 KEY_HASH ASC
)#
ALTER TABLE LDBD.PROCESS
 ADD "ibmqrepVERTIME" TIMESTAMP NOT NULL WITH DEFAULT
 '0001-01-01-00.00.00'
 ADD "ibmqrepVERNODE" SMALLINT NOT NULL WITH DEFAULT 0
 DATA CAPTURE CHANGES INCLUDE LONGVAR COLUMNS#
CREATE TRIGGER LDBD.APROCESSESS NO CASCADE BEFORE INSERT ON
 LDBD.PROCESS
 REFERENCING NEW AS new FOR EACH ROW MODE DB2SQL 
 WHEN (new."ibmqrepVERNODE" = 0)
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = (CURRENT TIMESTAMP - CURRENT TIMEZONE), 
new."ibmqrepVERNODE" = 1*4; 
END#
CREATE TRIGGER LDBD.BPROCESSESS NO CASCADE BEFORE UPDATE ON
 LDBD.PROCESS
 REFERENCING NEW AS new OLD AS old FOR EACH ROW MODE DB2SQL 
 WHEN ((new."ibmqrepVERTIME" = old."ibmqrepVERTIME")
AND (((new."ibmqrepVERNODE")/4) = ((old."ibmqrepVERNODE")/4))) 
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = 
CASE 
WHEN (CURRENT TIMESTAMP - CURRENT TIMEZONE) < old."ibmqrepVERTIME"
THEN old."ibmqrepVERTIME" + 00000000000000.000001 
ELSE (CURRENT TIMESTAMP - CURRENT TIMEZONE) 
END, 
new."ibmqrepVERNODE" = 1*4; 
END#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('PROCESS0001', 'LDBD', 'PROCESS', 'ASN.QM2_TO_QM1.DATAQ', 'P', 'N',
 'N', 'N', 'E', 'I', '000001', 1, 2, 'NNNN', 'N', 'SEG_LHO', 'SEG_LHO'
, 'LDBD', 'PROCESS', 1, 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0001', 'CREATOR_DB', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0001', 'PROGRAM', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0001', 'VERSION', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0001', 'CVS_REPOSITORY', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0001', 'CVS_ENTRY_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0001', 'COMMENT', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0001', 'IS_ONLINE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0001', 'NODE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0001', 'USERNAME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0001', 'UNIX_PROCID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0001', 'START_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0001', 'END_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0001', 'JOBID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0001', 'DOMAIN', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0001', 'PROCESS_ID', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0001', 'PARAM_SET', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0001', 'IFOS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0001', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0001', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0001', 'ibmqrepVERNODE', 0)#
ALTER TABLE LDBD.PROCESS_PARAMS
 ADD "ibmqrepVERTIME" TIMESTAMP NOT NULL WITH DEFAULT
 '0001-01-01-00.00.00'
 ADD "ibmqrepVERNODE" SMALLINT NOT NULL WITH DEFAULT 0
 DATA CAPTURE CHANGES INCLUDE LONGVAR COLUMNS#
CREATE TRIGGER LDBD.APROCESS_PARAMAMS NO CASCADE BEFORE INSERT ON
 LDBD.PROCESS_PARAMS
 REFERENCING NEW AS new FOR EACH ROW MODE DB2SQL 
 WHEN (new."ibmqrepVERNODE" = 0)
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = (CURRENT TIMESTAMP - CURRENT TIMEZONE), 
new."ibmqrepVERNODE" = 1*4; 
END#
CREATE TRIGGER LDBD.BPROCESS_PARAMAMS NO CASCADE BEFORE UPDATE ON
 LDBD.PROCESS_PARAMS
 REFERENCING NEW AS new OLD AS old FOR EACH ROW MODE DB2SQL 
 WHEN ((new."ibmqrepVERTIME" = old."ibmqrepVERTIME")
AND (((new."ibmqrepVERNODE")/4) = ((old."ibmqrepVERNODE")/4))) 
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = 
CASE 
WHEN (CURRENT TIMESTAMP - CURRENT TIMEZONE) < old."ibmqrepVERTIME"
THEN old."ibmqrepVERTIME" + 00000000000000.000001 
ELSE (CURRENT TIMESTAMP - CURRENT TIMEZONE) 
END, 
new."ibmqrepVERNODE" = 1*4; 
END#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('PROCESS_PARAMS0001', 'LDBD', 'PROCESS_PARAMS',
 'ASN.QM2_TO_QM1.DATAQ', 'P', 'N', 'N', 'N', 'E', 'I', '000001', 1, 2,
 'NNNN', 'N', 'SEG_LHO', 'SEG_LHO', 'LDBD', 'PROCESS_PARAMS', 1, 'ASN'
)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS_PARAMS0001', 'CREATOR_DB', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS_PARAMS0001', 'PROGRAM', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS_PARAMS0001', 'PROCESS_ID', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS_PARAMS0001', 'PARAM', 3)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS_PARAMS0001', 'TYPE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS_PARAMS0001', 'VALUE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS_PARAMS0001', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS_PARAMS0001', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS_PARAMS0001', 'ibmqrepVERNODE', 0)#
ALTER TABLE LDBD.LFN
 ADD "ibmqrepVERTIME" TIMESTAMP NOT NULL WITH DEFAULT
 '0001-01-01-00.00.00'
 ADD "ibmqrepVERNODE" SMALLINT NOT NULL WITH DEFAULT 0
 DATA CAPTURE CHANGES INCLUDE LONGVAR COLUMNS#
CREATE TRIGGER LDBD.ALFNLFN NO CASCADE BEFORE INSERT ON LDBD.LFN
 REFERENCING NEW AS new FOR EACH ROW MODE DB2SQL 
 WHEN (new."ibmqrepVERNODE" = 0)
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = (CURRENT TIMESTAMP - CURRENT TIMEZONE), 
new."ibmqrepVERNODE" = 1*4; 
END#
CREATE TRIGGER LDBD.BLFNLFN NO CASCADE BEFORE UPDATE ON LDBD.LFN
 REFERENCING NEW AS new OLD AS old FOR EACH ROW MODE DB2SQL 
 WHEN ((new."ibmqrepVERTIME" = old."ibmqrepVERTIME")
AND (((new."ibmqrepVERNODE")/4) = ((old."ibmqrepVERNODE")/4))) 
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = 
CASE 
WHEN (CURRENT TIMESTAMP - CURRENT TIMEZONE) < old."ibmqrepVERTIME"
THEN old."ibmqrepVERTIME" + 00000000000000.000001 
ELSE (CURRENT TIMESTAMP - CURRENT TIMEZONE) 
END, 
new."ibmqrepVERNODE" = 1*4; 
END#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('LFN0001', 'LDBD', 'LFN', 'ASN.QM2_TO_QM1.DATAQ', 'P', 'N', 'N', 'N'
, 'E', 'I', '000001', 1, 2, 'NNNN', 'N', 'SEG_LHO', 'SEG_LHO', 'LDBD',
 'LFN', 1, 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('LFN0001', 'CREATOR_DB', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('LFN0001', 'PROCESS_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('LFN0001', 'LFN_ID', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('LFN0001', 'NAME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('LFN0001', 'COMMENT', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('LFN0001', 'START_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('LFN0001', 'END_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('LFN0001', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('LFN0001', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('LFN0001', 'ibmqrepVERNODE', 0)#
ALTER TABLE LDBD.GRIDCERT
 ADD "ibmqrepVERTIME" TIMESTAMP NOT NULL WITH DEFAULT
 '0001-01-01-00.00.00'
 ADD "ibmqrepVERNODE" SMALLINT NOT NULL WITH DEFAULT 0
 DATA CAPTURE CHANGES INCLUDE LONGVAR COLUMNS#
CREATE TRIGGER LDBD.AGRIDCERTERT NO CASCADE BEFORE INSERT ON
 LDBD.GRIDCERT
 REFERENCING NEW AS new FOR EACH ROW MODE DB2SQL 
 WHEN (new."ibmqrepVERNODE" = 0)
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = (CURRENT TIMESTAMP - CURRENT TIMEZONE), 
new."ibmqrepVERNODE" = 1*4; 
END#
CREATE TRIGGER LDBD.BGRIDCERTERT NO CASCADE BEFORE UPDATE ON
 LDBD.GRIDCERT
 REFERENCING NEW AS new OLD AS old FOR EACH ROW MODE DB2SQL 
 WHEN ((new."ibmqrepVERTIME" = old."ibmqrepVERTIME")
AND (((new."ibmqrepVERNODE")/4) = ((old."ibmqrepVERNODE")/4))) 
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = 
CASE 
WHEN (CURRENT TIMESTAMP - CURRENT TIMEZONE) < old."ibmqrepVERTIME"
THEN old."ibmqrepVERTIME" + 00000000000000.000001 
ELSE (CURRENT TIMESTAMP - CURRENT TIMEZONE) 
END, 
new."ibmqrepVERNODE" = 1*4; 
END#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('GRIDCERT0001', 'LDBD', 'GRIDCERT', 'ASN.QM2_TO_QM1.DATAQ', 'P', 'N'
, 'N', 'N', 'E', 'I', '000001', 1, 2, 'NNNN', 'N', 'SEG_LHO',
 'SEG_LHO', 'LDBD', 'GRIDCERT', 1, 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('GRIDCERT0001', 'CREATOR_DB', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('GRIDCERT0001', 'PROCESS_ID', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('GRIDCERT0001', 'DN', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('GRIDCERT0001', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('GRIDCERT0001', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('GRIDCERT0001', 'ibmqrepVERNODE', 0)#
ALTER TABLE LDBD.FILTER
 ADD "ibmqrepVERTIME" TIMESTAMP NOT NULL WITH DEFAULT
 '0001-01-01-00.00.00'
 ADD "ibmqrepVERNODE" SMALLINT NOT NULL WITH DEFAULT 0
 DATA CAPTURE CHANGES INCLUDE LONGVAR COLUMNS#
CREATE TRIGGER LDBD.AFILTERTER NO CASCADE BEFORE INSERT ON LDBD.FILTER
 REFERENCING NEW AS new FOR EACH ROW MODE DB2SQL 
 WHEN (new."ibmqrepVERNODE" = 0)
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = (CURRENT TIMESTAMP - CURRENT TIMEZONE), 
new."ibmqrepVERNODE" = 1*4; 
END#
CREATE TRIGGER LDBD.BFILTERTER NO CASCADE BEFORE UPDATE ON LDBD.FILTER
 REFERENCING NEW AS new OLD AS old FOR EACH ROW MODE DB2SQL 
 WHEN ((new."ibmqrepVERTIME" = old."ibmqrepVERTIME")
AND (((new."ibmqrepVERNODE")/4) = ((old."ibmqrepVERNODE")/4))) 
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = 
CASE 
WHEN (CURRENT TIMESTAMP - CURRENT TIMEZONE) < old."ibmqrepVERTIME"
THEN old."ibmqrepVERTIME" + 00000000000000.000001 
ELSE (CURRENT TIMESTAMP - CURRENT TIMEZONE) 
END, 
new."ibmqrepVERNODE" = 1*4; 
END#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('FILTER0001', 'LDBD', 'FILTER', 'ASN.QM2_TO_QM1.DATAQ', 'P', 'N',
 'N', 'N', 'E', 'I', '000001', 1, 2, 'NNNN', 'N', 'SEG_LHO', 'SEG_LHO'
, 'LDBD', 'FILTER', 1, 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER0001', 'CREATOR_DB', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER0001', 'PROGRAM', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER0001', 'START_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER0001', 'PROCESS_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER0001', 'FILTER_NAME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER0001', 'FILTER_ID', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER0001', 'PARAM_SET', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER0001', 'COMMENT', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER0001', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER0001', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER0001', 'ibmqrepVERNODE', 0)#
ALTER TABLE LDBD.FILTER_PARAMS
 ADD "ibmqrepVERTIME" TIMESTAMP NOT NULL WITH DEFAULT
 '0001-01-01-00.00.00'
 ADD "ibmqrepVERNODE" SMALLINT NOT NULL WITH DEFAULT 0
 DATA CAPTURE CHANGES INCLUDE LONGVAR COLUMNS#
CREATE TRIGGER LDBD.AFILTER_PARAMSAMS NO CASCADE BEFORE INSERT ON
 LDBD.FILTER_PARAMS
 REFERENCING NEW AS new FOR EACH ROW MODE DB2SQL 
 WHEN (new."ibmqrepVERNODE" = 0)
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = (CURRENT TIMESTAMP - CURRENT TIMEZONE), 
new."ibmqrepVERNODE" = 1*4; 
END#
CREATE TRIGGER LDBD.BFILTER_PARAMSAMS NO CASCADE BEFORE UPDATE ON
 LDBD.FILTER_PARAMS
 REFERENCING NEW AS new OLD AS old FOR EACH ROW MODE DB2SQL 
 WHEN ((new."ibmqrepVERTIME" = old."ibmqrepVERTIME")
AND (((new."ibmqrepVERNODE")/4) = ((old."ibmqrepVERNODE")/4))) 
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = 
CASE 
WHEN (CURRENT TIMESTAMP - CURRENT TIMEZONE) < old."ibmqrepVERTIME"
THEN old."ibmqrepVERTIME" + 00000000000000.000001 
ELSE (CURRENT TIMESTAMP - CURRENT TIMEZONE) 
END, 
new."ibmqrepVERNODE" = 1*4; 
END#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('FILTER_PARAMS0001', 'LDBD', 'FILTER_PARAMS', 'ASN.QM2_TO_QM1.DATAQ'
, 'P', 'N', 'N', 'N', 'E', 'I', '000001', 1, 2, 'NNNN', 'N', 'SEG_LHO'
, 'SEG_LHO', 'LDBD', 'FILTER_PARAMS', 1, 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER_PARAMS0001', 'CREATOR_DB', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER_PARAMS0001', 'PROCESS_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER_PARAMS0001', 'FILTER_NAME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER_PARAMS0001', 'FILTER_ID', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER_PARAMS0001', 'PARAM', 3)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER_PARAMS0001', 'TYPE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER_PARAMS0001', 'VALUE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER_PARAMS0001', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER_PARAMS0001', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER_PARAMS0001', 'ibmqrepVERNODE', 0)#
ALTER TABLE LDBD.FRAMESET_CHANLIST
 ADD "ibmqrepVERTIME" TIMESTAMP NOT NULL WITH DEFAULT
 '0001-01-01-00.00.00'
 ADD "ibmqrepVERNODE" SMALLINT NOT NULL WITH DEFAULT 0#
CREATE TRIGGER LDBD.AFRAMESET_CHANIST NO CASCADE BEFORE INSERT ON
 LDBD.FRAMESET_CHANLIST
 REFERENCING NEW AS new FOR EACH ROW MODE DB2SQL 
 WHEN (new."ibmqrepVERNODE" = 0)
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = (CURRENT TIMESTAMP - CURRENT TIMEZONE), 
new."ibmqrepVERNODE" = 1*4; 
END#
CREATE TRIGGER LDBD.BFRAMESET_CHANIST NO CASCADE BEFORE UPDATE ON
 LDBD.FRAMESET_CHANLIST
 REFERENCING NEW AS new OLD AS old FOR EACH ROW MODE DB2SQL 
 WHEN ((new."ibmqrepVERTIME" = old."ibmqrepVERTIME")
AND (((new."ibmqrepVERNODE")/4) = ((old."ibmqrepVERNODE")/4))) 
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = 
CASE 
WHEN (CURRENT TIMESTAMP - CURRENT TIMEZONE) < old."ibmqrepVERTIME"
THEN old."ibmqrepVERTIME" + 00000000000000.000001 
ELSE (CURRENT TIMESTAMP - CURRENT TIMEZONE) 
END, 
new."ibmqrepVERNODE" = 1*4; 
END#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('FRAMESET_CHANLIST0001', 'LDBD', 'FRAMESET_CHANLIST',
 'ASN.QM2_TO_QM1.DATAQ', 'P', 'N', 'N', 'N', 'E', 'I', '000001', 1, 2,
 'NNNN', 'N', 'SEG_LHO', 'SEG_LHO', 'LDBD', 'FRAMESET_CHANLIST', 1,
 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_CHANLIST0001', 'CREATOR_DB', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_CHANLIST0001', 'PROCESS_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_CHANLIST0001', 'FRAMESET_GROUP', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_CHANLIST0001', 'START_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_CHANLIST0001', 'END_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_CHANLIST0001', 'CHANLIST_ID', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_CHANLIST0001', 'CHANLIST', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_CHANLIST0001', 'CHANLIST_LENGTH', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_CHANLIST0001', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_CHANLIST0001', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_CHANLIST0001', 'ibmqrepVERNODE', 0)#
ALTER TABLE LDBD.FRAMESET_WRITER
 ADD "ibmqrepVERTIME" TIMESTAMP NOT NULL WITH DEFAULT
 '0001-01-01-00.00.00'
 ADD "ibmqrepVERNODE" SMALLINT NOT NULL WITH DEFAULT 0
 DATA CAPTURE CHANGES INCLUDE LONGVAR COLUMNS#
CREATE TRIGGER LDBD.AFRAMESET_WRITTER NO CASCADE BEFORE INSERT ON
 LDBD.FRAMESET_WRITER
 REFERENCING NEW AS new FOR EACH ROW MODE DB2SQL 
 WHEN (new."ibmqrepVERNODE" = 0)
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = (CURRENT TIMESTAMP - CURRENT TIMEZONE), 
new."ibmqrepVERNODE" = 1*4; 
END#
CREATE TRIGGER LDBD.BFRAMESET_WRITTER NO CASCADE BEFORE UPDATE ON
 LDBD.FRAMESET_WRITER
 REFERENCING NEW AS new OLD AS old FOR EACH ROW MODE DB2SQL 
 WHEN ((new."ibmqrepVERTIME" = old."ibmqrepVERTIME")
AND (((new."ibmqrepVERNODE")/4) = ((old."ibmqrepVERNODE")/4))) 
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = 
CASE 
WHEN (CURRENT TIMESTAMP - CURRENT TIMEZONE) < old."ibmqrepVERTIME"
THEN old."ibmqrepVERTIME" + 00000000000000.000001 
ELSE (CURRENT TIMESTAMP - CURRENT TIMEZONE) 
END, 
new."ibmqrepVERNODE" = 1*4; 
END#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('FRAMESET_WRITER0001', 'LDBD', 'FRAMESET_WRITER',
 'ASN.QM2_TO_QM1.DATAQ', 'P', 'N', 'N', 'N', 'E', 'I', '000001', 1, 2,
 'NNNN', 'N', 'SEG_LHO', 'SEG_LHO', 'LDBD', 'FRAMESET_WRITER', 1,
 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_WRITER0001', 'CREATOR_DB', 3)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_WRITER0001', 'PROGRAM', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_WRITER0001', 'PROCESS_ID', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_WRITER0001', 'FRAMESET_GROUP', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_WRITER0001', 'DATA_SOURCE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_WRITER0001', 'IFOS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_WRITER0001', 'COMMENT', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_WRITER0001', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_WRITER0001', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_WRITER0001', 'ibmqrepVERNODE', 0)#
ALTER TABLE LDBD.FRAMESET
 ADD "ibmqrepVERTIME" TIMESTAMP NOT NULL WITH DEFAULT
 '0001-01-01-00.00.00'
 ADD "ibmqrepVERNODE" SMALLINT NOT NULL WITH DEFAULT 0
 DATA CAPTURE CHANGES INCLUDE LONGVAR COLUMNS#
CREATE TRIGGER LDBD.AFRAMESETSET NO CASCADE BEFORE INSERT ON
 LDBD.FRAMESET
 REFERENCING NEW AS new FOR EACH ROW MODE DB2SQL 
 WHEN (new."ibmqrepVERNODE" = 0)
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = (CURRENT TIMESTAMP - CURRENT TIMEZONE), 
new."ibmqrepVERNODE" = 1*4; 
END#
CREATE TRIGGER LDBD.BFRAMESETSET NO CASCADE BEFORE UPDATE ON
 LDBD.FRAMESET
 REFERENCING NEW AS new OLD AS old FOR EACH ROW MODE DB2SQL 
 WHEN ((new."ibmqrepVERTIME" = old."ibmqrepVERTIME")
AND (((new."ibmqrepVERNODE")/4) = ((old."ibmqrepVERNODE")/4))) 
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = 
CASE 
WHEN (CURRENT TIMESTAMP - CURRENT TIMEZONE) < old."ibmqrepVERTIME"
THEN old."ibmqrepVERTIME" + 00000000000000.000001 
ELSE (CURRENT TIMESTAMP - CURRENT TIMEZONE) 
END, 
new."ibmqrepVERNODE" = 1*4; 
END#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('FRAMESET0001', 'LDBD', 'FRAMESET', 'ASN.QM2_TO_QM1.DATAQ', 'P', 'N'
, 'N', 'N', 'E', 'I', '000001', 1, 2, 'NNNN', 'N', 'SEG_LHO',
 'SEG_LHO', 'LDBD', 'FRAMESET', 1, 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0001', 'CREATOR_DB', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0001', 'PROCESS_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0001', 'FRAMESET_GROUP', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0001', 'CHANLIST_CDB', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0001', 'CHANLIST_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0001', 'START_TIME', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0001', 'START_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0001', 'END_TIME', 3)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0001', 'END_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0001', 'N_FRAMES', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0001', 'MISSING_FRAMES', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0001', 'N_BYTES', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0001', 'NAME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0001', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0001', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0001', 'ibmqrepVERNODE', 0)#
ALTER TABLE LDBD.FRAMESET_LOC
 ADD "ibmqrepVERTIME" TIMESTAMP NOT NULL WITH DEFAULT
 '0001-01-01-00.00.00'
 ADD "ibmqrepVERNODE" SMALLINT NOT NULL WITH DEFAULT 0
 DATA CAPTURE CHANGES INCLUDE LONGVAR COLUMNS#
CREATE TRIGGER LDBD.AFRAMESET_LOCLOC NO CASCADE BEFORE INSERT ON
 LDBD.FRAMESET_LOC
 REFERENCING NEW AS new FOR EACH ROW MODE DB2SQL 
 WHEN (new."ibmqrepVERNODE" = 0)
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = (CURRENT TIMESTAMP - CURRENT TIMEZONE), 
new."ibmqrepVERNODE" = 1*4; 
END#
CREATE TRIGGER LDBD.BFRAMESET_LOCLOC NO CASCADE BEFORE UPDATE ON
 LDBD.FRAMESET_LOC
 REFERENCING NEW AS new OLD AS old FOR EACH ROW MODE DB2SQL 
 WHEN ((new."ibmqrepVERTIME" = old."ibmqrepVERTIME")
AND (((new."ibmqrepVERNODE")/4) = ((old."ibmqrepVERNODE")/4))) 
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = 
CASE 
WHEN (CURRENT TIMESTAMP - CURRENT TIMEZONE) < old."ibmqrepVERTIME"
THEN old."ibmqrepVERTIME" + 00000000000000.000001 
ELSE (CURRENT TIMESTAMP - CURRENT TIMEZONE) 
END, 
new."ibmqrepVERNODE" = 1*4; 
END#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('FRAMESET_LOC0001', 'LDBD', 'FRAMESET_LOC', 'ASN.QM2_TO_QM1.DATAQ',
 'P', 'N', 'N', 'N', 'E', 'I', '000001', 1, 2, 'NNNN', 'N', 'SEG_LHO',
 'SEG_LHO', 'LDBD', 'FRAMESET_LOC', 1, 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_LOC0001', 'CREATOR_DB', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_LOC0001', 'NAME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_LOC0001', 'MEDIA_TYPE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_LOC0001', 'NODE', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_LOC0001', 'MEDIA_LOC', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_LOC0001', 'MEDIA_STATUS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_LOC0001', 'FULLNAME', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_LOC0001', 'FILENUM', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_LOC0001', 'DECOMPRESS_CMD', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_LOC0001', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_LOC0001', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_LOC0001', 'ibmqrepVERNODE', 0)#
ALTER TABLE LDBD.SEGMENT_DEFINER
 ADD "ibmqrepVERTIME" TIMESTAMP NOT NULL WITH DEFAULT
 '0001-01-01-00.00.00'
 ADD "ibmqrepVERNODE" SMALLINT NOT NULL WITH DEFAULT 0
 DATA CAPTURE CHANGES INCLUDE LONGVAR COLUMNS#
CREATE TRIGGER LDBD.ASEGMENT_DEFINNER NO CASCADE BEFORE INSERT ON
 LDBD.SEGMENT_DEFINER
 REFERENCING NEW AS new FOR EACH ROW MODE DB2SQL 
 WHEN (new."ibmqrepVERNODE" = 0)
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = (CURRENT TIMESTAMP - CURRENT TIMEZONE), 
new."ibmqrepVERNODE" = 1*4; 
END#
CREATE TRIGGER LDBD.BSEGMENT_DEFINNER NO CASCADE BEFORE UPDATE ON
 LDBD.SEGMENT_DEFINER
 REFERENCING NEW AS new OLD AS old FOR EACH ROW MODE DB2SQL 
 WHEN ((new."ibmqrepVERTIME" = old."ibmqrepVERTIME")
AND (((new."ibmqrepVERNODE")/4) = ((old."ibmqrepVERNODE")/4))) 
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = 
CASE 
WHEN (CURRENT TIMESTAMP - CURRENT TIMEZONE) < old."ibmqrepVERTIME"
THEN old."ibmqrepVERTIME" + 00000000000000.000001 
ELSE (CURRENT TIMESTAMP - CURRENT TIMEZONE) 
END, 
new."ibmqrepVERNODE" = 1*4; 
END#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('SEGMENT_DEFINER0001', 'LDBD', 'SEGMENT_DEFINER',
 'ASN.QM2_TO_QM1.DATAQ', 'P', 'N', 'N', 'N', 'E', 'I', '000001', 1, 2,
 'NNNN', 'N', 'SEG_LHO', 'SEG_LHO', 'LDBD', 'SEGMENT_DEFINER', 1,
 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEFINER0001', 'CREATOR_DB', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEFINER0001', 'PROCESS_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEFINER0001', 'SEGMENT_DEF_ID', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEFINER0001', 'RUN', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEFINER0001', 'IFOS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEFINER0001', 'NAME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEFINER0001', 'VERSION', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEFINER0001', 'COMMENT', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEFINER0001', 'STATE_VEC_MAJOR', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEFINER0001', 'STATE_VEC_MINOR', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEFINER0001', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEFINER0001', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEFINER0001', 'ibmqrepVERNODE', 0)#
ALTER TABLE LDBD.SEGMENT
 ADD "ibmqrepVERTIME" TIMESTAMP NOT NULL WITH DEFAULT
 '0001-01-01-00.00.00'
 ADD "ibmqrepVERNODE" SMALLINT NOT NULL WITH DEFAULT 0
 DATA CAPTURE CHANGES INCLUDE LONGVAR COLUMNS#
CREATE TRIGGER LDBD.ASEGMENTENT NO CASCADE BEFORE INSERT ON
 LDBD.SEGMENT
 REFERENCING NEW AS new FOR EACH ROW MODE DB2SQL 
 WHEN (new."ibmqrepVERNODE" = 0)
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = (CURRENT TIMESTAMP - CURRENT TIMEZONE), 
new."ibmqrepVERNODE" = 1*4; 
END#
CREATE TRIGGER LDBD.BSEGMENTENT NO CASCADE BEFORE UPDATE ON
 LDBD.SEGMENT
 REFERENCING NEW AS new OLD AS old FOR EACH ROW MODE DB2SQL 
 WHEN ((new."ibmqrepVERTIME" = old."ibmqrepVERTIME")
AND (((new."ibmqrepVERNODE")/4) = ((old."ibmqrepVERNODE")/4))) 
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = 
CASE 
WHEN (CURRENT TIMESTAMP - CURRENT TIMEZONE) < old."ibmqrepVERTIME"
THEN old."ibmqrepVERTIME" + 00000000000000.000001 
ELSE (CURRENT TIMESTAMP - CURRENT TIMEZONE) 
END, 
new."ibmqrepVERNODE" = 1*4; 
END#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('SEGMENT0001', 'LDBD', 'SEGMENT', 'ASN.QM2_TO_QM1.DATAQ', 'P', 'N',
 'N', 'N', 'E', 'I', '000001', 1, 2, 'NNNN', 'N', 'SEG_LHO', 'SEG_LHO'
, 'LDBD', 'SEGMENT', 1, 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT0001', 'CREATOR_DB', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT0001', 'PROCESS_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT0001', 'SEGMENT_ID', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT0001', 'START_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT0001', 'START_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT0001', 'END_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT0001', 'END_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT0001', 'ACTIVE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT0001', 'SEGNUM', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT0001', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT0001', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT0001', 'ibmqrepVERNODE', 0)#
ALTER TABLE LDBD.SEGMENT_DEF_MAP
 ADD "ibmqrepVERTIME" TIMESTAMP NOT NULL WITH DEFAULT
 '0001-01-01-00.00.00'
 ADD "ibmqrepVERNODE" SMALLINT NOT NULL WITH DEFAULT 0
 DATA CAPTURE CHANGES INCLUDE LONGVAR COLUMNS#
CREATE TRIGGER LDBD.ASEGMENT_DEF_MMAP NO CASCADE BEFORE INSERT ON
 LDBD.SEGMENT_DEF_MAP
 REFERENCING NEW AS new FOR EACH ROW MODE DB2SQL 
 WHEN (new."ibmqrepVERNODE" = 0)
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = (CURRENT TIMESTAMP - CURRENT TIMEZONE), 
new."ibmqrepVERNODE" = 1*4; 
END#
CREATE TRIGGER LDBD.BSEGMENT_DEF_MMAP NO CASCADE BEFORE UPDATE ON
 LDBD.SEGMENT_DEF_MAP
 REFERENCING NEW AS new OLD AS old FOR EACH ROW MODE DB2SQL 
 WHEN ((new."ibmqrepVERTIME" = old."ibmqrepVERTIME")
AND (((new."ibmqrepVERNODE")/4) = ((old."ibmqrepVERNODE")/4))) 
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = 
CASE 
WHEN (CURRENT TIMESTAMP - CURRENT TIMEZONE) < old."ibmqrepVERTIME"
THEN old."ibmqrepVERTIME" + 00000000000000.000001 
ELSE (CURRENT TIMESTAMP - CURRENT TIMEZONE) 
END, 
new."ibmqrepVERNODE" = 1*4; 
END#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('SEGMENT_DEF_MAP0001', 'LDBD', 'SEGMENT_DEF_MAP',
 'ASN.QM2_TO_QM1.DATAQ', 'P', 'N', 'N', 'N', 'E', 'I', '000001', 1, 2,
 'NNNN', 'N', 'SEG_LHO', 'SEG_LHO', 'LDBD', 'SEGMENT_DEF_MAP', 1,
 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEF_MAP0001', 'CREATOR_DB', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEF_MAP0001', 'PROCESS_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEF_MAP0001', 'SEG_DEF_MAP_ID', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEF_MAP0001', 'SEGMENT_CDB', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEF_MAP0001', 'SEGMENT_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEF_MAP0001', 'SEGMENT_DEF_CDB', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEF_MAP0001', 'SEGMENT_DEF_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEF_MAP0001', 'STATE_VEC_MAP', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEF_MAP0001', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEF_MAP0001', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEF_MAP0001', 'ibmqrepVERNODE', 0)#
ALTER TABLE LDBD.SEGMENT_LFN_MAP
 ADD "ibmqrepVERTIME" TIMESTAMP NOT NULL WITH DEFAULT
 '0001-01-01-00.00.00'
 ADD "ibmqrepVERNODE" SMALLINT NOT NULL WITH DEFAULT 0
 DATA CAPTURE CHANGES INCLUDE LONGVAR COLUMNS#
CREATE TRIGGER LDBD.ASEGMENT_LFN_MMAP NO CASCADE BEFORE INSERT ON
 LDBD.SEGMENT_LFN_MAP
 REFERENCING NEW AS new FOR EACH ROW MODE DB2SQL 
 WHEN (new."ibmqrepVERNODE" = 0)
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = (CURRENT TIMESTAMP - CURRENT TIMEZONE), 
new."ibmqrepVERNODE" = 1*4; 
END#
CREATE TRIGGER LDBD.BSEGMENT_LFN_MMAP NO CASCADE BEFORE UPDATE ON
 LDBD.SEGMENT_LFN_MAP
 REFERENCING NEW AS new OLD AS old FOR EACH ROW MODE DB2SQL 
 WHEN ((new."ibmqrepVERTIME" = old."ibmqrepVERTIME")
AND (((new."ibmqrepVERNODE")/4) = ((old."ibmqrepVERNODE")/4))) 
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = 
CASE 
WHEN (CURRENT TIMESTAMP - CURRENT TIMEZONE) < old."ibmqrepVERTIME"
THEN old."ibmqrepVERTIME" + 00000000000000.000001 
ELSE (CURRENT TIMESTAMP - CURRENT TIMEZONE) 
END, 
new."ibmqrepVERNODE" = 1*4; 
END#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('SEGMENT_LFN_MAP0001', 'LDBD', 'SEGMENT_LFN_MAP',
 'ASN.QM2_TO_QM1.DATAQ', 'P', 'N', 'N', 'N', 'E', 'I', '000001', 1, 2,
 'NNNN', 'N', 'SEG_LHO', 'SEG_LHO', 'LDBD', 'SEGMENT_LFN_MAP', 1,
 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_LFN_MAP0001', 'CREATOR_DB', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_LFN_MAP0001', 'PROCESS_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_LFN_MAP0001', 'SEG_LFN_MAP_ID', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_LFN_MAP0001', 'SEGMENT_CDB', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_LFN_MAP0001', 'SEGMENT_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_LFN_MAP0001', 'LFN_CDB', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_LFN_MAP0001', 'LFN_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_LFN_MAP0001', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_LFN_MAP0001', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_LFN_MAP0001', 'ibmqrepVERNODE', 0)#
ALTER TABLE LDBD.SUMM_VALUE
 ADD "ibmqrepVERTIME" TIMESTAMP NOT NULL WITH DEFAULT
 '0001-01-01-00.00.00'
 ADD "ibmqrepVERNODE" SMALLINT NOT NULL WITH DEFAULT 0
 DATA CAPTURE CHANGES INCLUDE LONGVAR COLUMNS#
CREATE TRIGGER LDBD.ASUMM_VALUELUE NO CASCADE BEFORE INSERT ON
 LDBD.SUMM_VALUE
 REFERENCING NEW AS new FOR EACH ROW MODE DB2SQL 
 WHEN (new."ibmqrepVERNODE" = 0)
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = (CURRENT TIMESTAMP - CURRENT TIMEZONE), 
new."ibmqrepVERNODE" = 1*4; 
END#
CREATE TRIGGER LDBD.BSUMM_VALUELUE NO CASCADE BEFORE UPDATE ON
 LDBD.SUMM_VALUE
 REFERENCING NEW AS new OLD AS old FOR EACH ROW MODE DB2SQL 
 WHEN ((new."ibmqrepVERTIME" = old."ibmqrepVERTIME")
AND (((new."ibmqrepVERNODE")/4) = ((old."ibmqrepVERNODE")/4))) 
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = 
CASE 
WHEN (CURRENT TIMESTAMP - CURRENT TIMEZONE) < old."ibmqrepVERTIME"
THEN old."ibmqrepVERTIME" + 00000000000000.000001 
ELSE (CURRENT TIMESTAMP - CURRENT TIMEZONE) 
END, 
new."ibmqrepVERNODE" = 1*4; 
END#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('SUMM_VALUE0001', 'LDBD', 'SUMM_VALUE', 'ASN.QM2_TO_QM1.DATAQ', 'P',
 'N', 'N', 'N', 'E', 'I', '000001', 1, 2, 'NNNN', 'N', 'SEG_LHO',
 'SEG_LHO', 'LDBD', 'SUMM_VALUE', 1, 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0001', 'CREATOR_DB', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0001', 'SUMM_VALUE_ID', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0001', 'PROGRAM', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0001', 'PROCESS_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0001', 'FRAMESET_GROUP', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0001', 'SEGMENT_DEF_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0001', 'START_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0001', 'START_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0001', 'END_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0001', 'END_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0001', 'IFO', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0001', 'NAME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0001', 'VALUE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0001', 'ERROR', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0001', 'INTVALUE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0001', 'COMMENT', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0001', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0001', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0001', 'ibmqrepVERNODE', 0)#
ALTER TABLE LDBD.SUMM_STATISTICS
 ADD "ibmqrepVERTIME" TIMESTAMP NOT NULL WITH DEFAULT
 '0001-01-01-00.00.00'
 ADD "ibmqrepVERNODE" SMALLINT NOT NULL WITH DEFAULT 0
 DATA CAPTURE CHANGES INCLUDE LONGVAR COLUMNS#
CREATE TRIGGER LDBD.ASUMM_STATISTIICS NO CASCADE BEFORE INSERT ON
 LDBD.SUMM_STATISTICS
 REFERENCING NEW AS new FOR EACH ROW MODE DB2SQL 
 WHEN (new."ibmqrepVERNODE" = 0)
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = (CURRENT TIMESTAMP - CURRENT TIMEZONE), 
new."ibmqrepVERNODE" = 1*4; 
END#
CREATE TRIGGER LDBD.BSUMM_STATISTIICS NO CASCADE BEFORE UPDATE ON
 LDBD.SUMM_STATISTICS
 REFERENCING NEW AS new OLD AS old FOR EACH ROW MODE DB2SQL 
 WHEN ((new."ibmqrepVERTIME" = old."ibmqrepVERTIME")
AND (((new."ibmqrepVERNODE")/4) = ((old."ibmqrepVERNODE")/4))) 
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = 
CASE 
WHEN (CURRENT TIMESTAMP - CURRENT TIMEZONE) < old."ibmqrepVERTIME"
THEN old."ibmqrepVERTIME" + 00000000000000.000001 
ELSE (CURRENT TIMESTAMP - CURRENT TIMEZONE) 
END, 
new."ibmqrepVERNODE" = 1*4; 
END#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('SUMM_STATISTICS0001', 'LDBD', 'SUMM_STATISTICS',
 'ASN.QM2_TO_QM1.DATAQ', 'P', 'N', 'N', 'N', 'E', 'I', '000001', 1, 2,
 'NNNN', 'N', 'SEG_LHO', 'SEG_LHO', 'LDBD', 'SUMM_STATISTICS', 1,
 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0001', 'CREATOR_DB', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0001', 'PROGRAM', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0001', 'PROCESS_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0001', 'FRAMESET_GROUP', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0001', 'SEGMENT_DEF_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0001', 'START_TIME', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0001', 'START_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0001', 'END_TIME', 3)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0001', 'END_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0001', 'FRAMES_USED', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0001', 'SAMPLES', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0001', 'CHANNEL', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0001', 'MIN_VALUE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0001', 'MAX_VALUE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0001', 'MIN_DELTA', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0001', 'MAX_DELTA', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0001', 'MIN_DELTADELTA', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0001', 'MAX_DELTADELTA', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0001', 'MEAN', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0001', 'VARIANCE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0001', 'RMS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0001', 'SKEWNESS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0001', 'KURTOSIS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0001', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0001', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0001', 'ibmqrepVERNODE', 0)#
ALTER TABLE LDBD.SUMM_SPECTRUM
 ADD "ibmqrepVERTIME" TIMESTAMP NOT NULL WITH DEFAULT
 '0001-01-01-00.00.00'
 ADD "ibmqrepVERNODE" SMALLINT NOT NULL WITH DEFAULT 0
 DATA CAPTURE CHANGES INCLUDE LONGVAR COLUMNS#
CREATE TRIGGER LDBD.ASUMM_SPECTRUMRUM NO CASCADE BEFORE INSERT ON
 LDBD.SUMM_SPECTRUM
 REFERENCING NEW AS new FOR EACH ROW MODE DB2SQL 
 WHEN (new."ibmqrepVERNODE" = 0)
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = (CURRENT TIMESTAMP - CURRENT TIMEZONE), 
new."ibmqrepVERNODE" = 1*4; 
END#
CREATE TRIGGER LDBD.BSUMM_SPECTRUMRUM NO CASCADE BEFORE UPDATE ON
 LDBD.SUMM_SPECTRUM
 REFERENCING NEW AS new OLD AS old FOR EACH ROW MODE DB2SQL 
 WHEN ((new."ibmqrepVERTIME" = old."ibmqrepVERTIME")
AND (((new."ibmqrepVERNODE")/4) = ((old."ibmqrepVERNODE")/4))) 
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = 
CASE 
WHEN (CURRENT TIMESTAMP - CURRENT TIMEZONE) < old."ibmqrepVERTIME"
THEN old."ibmqrepVERTIME" + 00000000000000.000001 
ELSE (CURRENT TIMESTAMP - CURRENT TIMEZONE) 
END, 
new."ibmqrepVERNODE" = 1*4; 
END#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('SUMM_SPECTRUM0001', 'LDBD', 'SUMM_SPECTRUM', 'ASN.QM2_TO_QM1.DATAQ'
, 'P', 'N', 'N', 'N', 'E', 'I', '000001', 1, 2, 'NNNN', 'N', 'SEG_LHO'
, 'SEG_LHO', 'LDBD', 'SUMM_SPECTRUM', 1, 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0001', 'CREATOR_DB', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0001', 'SUMM_SPECTRUM_ID', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0001', 'PROGRAM', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0001', 'PROCESS_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0001', 'FRAMESET_GROUP', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0001', 'SEGMENT_DEF_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0001', 'START_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0001', 'START_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0001', 'END_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0001', 'END_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0001', 'FRAMES_USED', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0001', 'START_FREQUENCY', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0001', 'DELTA_FREQUENCY', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0001', 'MIMETYPE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0001', 'CHANNEL', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0001', 'SPECTRUM_TYPE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0001', 'SPECTRUM', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0001', 'SPECTRUM_LENGTH', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0001', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0001', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0001', 'ibmqrepVERNODE', 0)#
ALTER TABLE LDBD.SUMM_CSD
 ADD "ibmqrepVERTIME" TIMESTAMP NOT NULL WITH DEFAULT
 '0001-01-01-00.00.00'
 ADD "ibmqrepVERNODE" SMALLINT NOT NULL WITH DEFAULT 0
 DATA CAPTURE CHANGES INCLUDE LONGVAR COLUMNS#
CREATE TRIGGER LDBD.ASUMM_CSDCSD NO CASCADE BEFORE INSERT ON
 LDBD.SUMM_CSD
 REFERENCING NEW AS new FOR EACH ROW MODE DB2SQL 
 WHEN (new."ibmqrepVERNODE" = 0)
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = (CURRENT TIMESTAMP - CURRENT TIMEZONE), 
new."ibmqrepVERNODE" = 1*4; 
END#
CREATE TRIGGER LDBD.BSUMM_CSDCSD NO CASCADE BEFORE UPDATE ON
 LDBD.SUMM_CSD
 REFERENCING NEW AS new OLD AS old FOR EACH ROW MODE DB2SQL 
 WHEN ((new."ibmqrepVERTIME" = old."ibmqrepVERTIME")
AND (((new."ibmqrepVERNODE")/4) = ((old."ibmqrepVERNODE")/4))) 
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = 
CASE 
WHEN (CURRENT TIMESTAMP - CURRENT TIMEZONE) < old."ibmqrepVERTIME"
THEN old."ibmqrepVERTIME" + 00000000000000.000001 
ELSE (CURRENT TIMESTAMP - CURRENT TIMEZONE) 
END, 
new."ibmqrepVERNODE" = 1*4; 
END#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('SUMM_CSD0001', 'LDBD', 'SUMM_CSD', 'ASN.QM2_TO_QM1.DATAQ', 'P', 'N'
, 'N', 'N', 'E', 'I', '000001', 1, 2, 'NNNN', 'N', 'SEG_LHO',
 'SEG_LHO', 'LDBD', 'SUMM_CSD', 1, 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0001', 'CREATOR_DB', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0001', 'SUMM_CSD_ID', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0001', 'PROGRAM', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0001', 'PROCESS_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0001', 'FRAMESET_GROUP', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0001', 'SEGMENT_DEF_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0001', 'START_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0001', 'START_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0001', 'END_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0001', 'END_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0001', 'FRAMES_USED', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0001', 'START_FREQUENCY', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0001', 'DELTA_FREQUENCY', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0001', 'MIMETYPE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0001', 'CHANNEL1', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0001', 'CHANNEL2', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0001', 'SPECTRUM_TYPE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0001', 'SPECTRUM', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0001', 'SPECTRUM_LENGTH', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0001', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0001', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0001', 'ibmqrepVERNODE', 0)#
ALTER TABLE LDBD.SUMM_COMMENT
 ADD "ibmqrepVERTIME" TIMESTAMP NOT NULL WITH DEFAULT
 '0001-01-01-00.00.00'
 ADD "ibmqrepVERNODE" SMALLINT NOT NULL WITH DEFAULT 0
 DATA CAPTURE CHANGES INCLUDE LONGVAR COLUMNS#
CREATE TRIGGER LDBD.ASUMM_COMMENTENT NO CASCADE BEFORE INSERT ON
 LDBD.SUMM_COMMENT
 REFERENCING NEW AS new FOR EACH ROW MODE DB2SQL 
 WHEN (new."ibmqrepVERNODE" = 0)
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = (CURRENT TIMESTAMP - CURRENT TIMEZONE), 
new."ibmqrepVERNODE" = 1*4; 
END#
CREATE TRIGGER LDBD.BSUMM_COMMENTENT NO CASCADE BEFORE UPDATE ON
 LDBD.SUMM_COMMENT
 REFERENCING NEW AS new OLD AS old FOR EACH ROW MODE DB2SQL 
 WHEN ((new."ibmqrepVERTIME" = old."ibmqrepVERTIME")
AND (((new."ibmqrepVERNODE")/4) = ((old."ibmqrepVERNODE")/4))) 
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = 
CASE 
WHEN (CURRENT TIMESTAMP - CURRENT TIMEZONE) < old."ibmqrepVERTIME"
THEN old."ibmqrepVERTIME" + 00000000000000.000001 
ELSE (CURRENT TIMESTAMP - CURRENT TIMEZONE) 
END, 
new."ibmqrepVERNODE" = 1*4; 
END#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('SUMM_COMMENT0001', 'LDBD', 'SUMM_COMMENT', 'ASN.QM2_TO_QM1.DATAQ',
 'P', 'N', 'N', 'N', 'E', 'I', '000001', 1, 2, 'NNNN', 'N', 'SEG_LHO',
 'SEG_LHO', 'LDBD', 'SUMM_COMMENT', 1, 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0001', 'CREATOR_DB', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0001', 'PROGRAM', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0001', 'PROCESS_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0001', 'SUBMITTER', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0001', 'FRAMESET_GROUP', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0001', 'SEGMENT_DEF_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0001', 'START_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0001', 'START_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0001', 'END_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0001', 'END_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0001', 'IFO', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0001', 'TEXT', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0001', 'SUMM_COMMENT_ID', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0001', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0001', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0001', 'ibmqrepVERNODE', 0)#
ALTER TABLE LDBD.SUMM_MIME
 ADD "ibmqrepVERTIME" TIMESTAMP NOT NULL WITH DEFAULT
 '0001-01-01-00.00.00'
 ADD "ibmqrepVERNODE" SMALLINT NOT NULL WITH DEFAULT 0
 DATA CAPTURE CHANGES INCLUDE LONGVAR COLUMNS#
CREATE TRIGGER LDBD.ASUMM_MIMEIME NO CASCADE BEFORE INSERT ON
 LDBD.SUMM_MIME
 REFERENCING NEW AS new FOR EACH ROW MODE DB2SQL 
 WHEN (new."ibmqrepVERNODE" = 0)
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = (CURRENT TIMESTAMP - CURRENT TIMEZONE), 
new."ibmqrepVERNODE" = 1*4; 
END#
CREATE TRIGGER LDBD.BSUMM_MIMEIME NO CASCADE BEFORE UPDATE ON
 LDBD.SUMM_MIME
 REFERENCING NEW AS new OLD AS old FOR EACH ROW MODE DB2SQL 
 WHEN ((new."ibmqrepVERTIME" = old."ibmqrepVERTIME")
AND (((new."ibmqrepVERNODE")/4) = ((old."ibmqrepVERNODE")/4))) 
BEGIN ATOMIC 
SET new."ibmqrepVERTIME" = 
CASE 
WHEN (CURRENT TIMESTAMP - CURRENT TIMEZONE) < old."ibmqrepVERTIME"
THEN old."ibmqrepVERTIME" + 00000000000000.000001 
ELSE (CURRENT TIMESTAMP - CURRENT TIMEZONE) 
END, 
new."ibmqrepVERNODE" = 1*4; 
END#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('SUMM_MIME0001', 'LDBD', 'SUMM_MIME', 'ASN.QM2_TO_QM1.DATAQ', 'P',
 'N', 'N', 'N', 'E', 'I', '000001', 1, 2, 'NNNN', 'N', 'SEG_LHO',
 'SEG_LHO', 'LDBD', 'SUMM_MIME', 1, 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0001', 'CREATOR_DB', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0001', 'ORIGIN', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0001', 'PROCESS_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0001', 'FILENAME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0001', 'SUBMITTER', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0001', 'SUBMIT_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0001', 'FRAMESET_GROUP', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0001', 'SEGMENT_DEF_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0001', 'START_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0001', 'START_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0001', 'END_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0001', 'END_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0001', 'CHANNEL', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0001', 'DESCRIP', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0001', 'MIMEDATA', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0001', 'MIMEDATA_LENGTH', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0001', 'MIMETYPE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0001', 'COMMENT', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0001', 'SUMM_MIME_ID', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0001', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0001', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0001', 'ibmqrepVERNODE', 0)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('PROCESS0002', 'ASN.QM1_TO_QM2.DATAQ', 'LDBD', 'PROCESS', 'LDBD',
 'PROCESS', 'SEG_LHO', 'SEG_LHO', 1, 'I', 'P', 'V', 'F', 'Q', '000001'
, 2, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0002', 'ASN.QM1_TO_QM2.DATAQ', 'CREATOR_DB', 'CREATOR_DB',
 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0002', 'ASN.QM1_TO_QM2.DATAQ', 'PROGRAM', 'PROGRAM', 'N', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0002', 'ASN.QM1_TO_QM2.DATAQ', 'VERSION', 'VERSION', 'N', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0002', 'ASN.QM1_TO_QM2.DATAQ', 'CVS_REPOSITORY',
 'CVS_REPOSITORY', 'N', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0002', 'ASN.QM1_TO_QM2.DATAQ', 'CVS_ENTRY_TIME',
 'CVS_ENTRY_TIME', 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0002', 'ASN.QM1_TO_QM2.DATAQ', 'COMMENT', 'COMMENT', 'N', 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0002', 'ASN.QM1_TO_QM2.DATAQ', 'IS_ONLINE', 'IS_ONLINE', 'N'
, 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0002', 'ASN.QM1_TO_QM2.DATAQ', 'NODE', 'NODE', 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0002', 'ASN.QM1_TO_QM2.DATAQ', 'USERNAME', 'USERNAME', 'N',
 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0002', 'ASN.QM1_TO_QM2.DATAQ', 'UNIX_PROCID', 'UNIX_PROCID',
 'N', 9)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0002', 'ASN.QM1_TO_QM2.DATAQ', 'START_TIME', 'START_TIME',
 'N', 10)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0002', 'ASN.QM1_TO_QM2.DATAQ', 'END_TIME', 'END_TIME', 'N',
 11)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0002', 'ASN.QM1_TO_QM2.DATAQ', 'JOBID', 'JOBID', 'N', 12)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0002', 'ASN.QM1_TO_QM2.DATAQ', 'DOMAIN', 'DOMAIN', 'N', 13)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0002', 'ASN.QM1_TO_QM2.DATAQ', 'PROCESS_ID', 'PROCESS_ID',
 'Y', 14)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0002', 'ASN.QM1_TO_QM2.DATAQ', 'PARAM_SET', 'PARAM_SET', 'N'
, 15)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0002', 'ASN.QM1_TO_QM2.DATAQ', 'IFOS', 'IFOS', 'N', 16)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0002', 'ASN.QM1_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 17)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 18)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 19)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('PROCESS_PARAMS0002', 'ASN.QM1_TO_QM2.DATAQ', 'LDBD',
 'PROCESS_PARAMS', 'LDBD', 'PROCESS_PARAMS', 'SEG_LHO', 'SEG_LHO', 1,
 'I', 'P', 'V', 'F', 'Q', '000001', 2, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS_PARAMS0002', 'ASN.QM1_TO_QM2.DATAQ', 'CREATOR_DB',
 'CREATOR_DB', 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS_PARAMS0002', 'ASN.QM1_TO_QM2.DATAQ', 'PROGRAM', 'PROGRAM',
 'N', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS_PARAMS0002', 'ASN.QM1_TO_QM2.DATAQ', 'PROCESS_ID',
 'PROCESS_ID', 'Y', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS_PARAMS0002', 'ASN.QM1_TO_QM2.DATAQ', 'PARAM', 'PARAM', 'Y',
 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS_PARAMS0002', 'ASN.QM1_TO_QM2.DATAQ', 'TYPE', 'TYPE', 'N', 4
)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS_PARAMS0002', 'ASN.QM1_TO_QM2.DATAQ', 'VALUE', 'VALUE', 'N',
 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS_PARAMS0002', 'ASN.QM1_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS_PARAMS0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS_PARAMS0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 8)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('LFN0002', 'ASN.QM1_TO_QM2.DATAQ', 'LDBD', 'LFN', 'LDBD', 'LFN',
 'SEG_LHO', 'SEG_LHO', 1, 'I', 'P', 'V', 'F', 'Q', '000001', 2, 1, 0,
 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('LFN0002', 'ASN.QM1_TO_QM2.DATAQ', 'CREATOR_DB', 'CREATOR_DB', 'Y',
 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('LFN0002', 'ASN.QM1_TO_QM2.DATAQ', 'PROCESS_ID', 'PROCESS_ID', 'N',
 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('LFN0002', 'ASN.QM1_TO_QM2.DATAQ', 'LFN_ID', 'LFN_ID', 'Y', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('LFN0002', 'ASN.QM1_TO_QM2.DATAQ', 'NAME', 'NAME', 'N', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('LFN0002', 'ASN.QM1_TO_QM2.DATAQ', 'COMMENT', 'COMMENT', 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('LFN0002', 'ASN.QM1_TO_QM2.DATAQ', 'START_TIME', 'START_TIME', 'N',
 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('LFN0002', 'ASN.QM1_TO_QM2.DATAQ', 'END_TIME', 'END_TIME', 'N', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('LFN0002', 'ASN.QM1_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('LFN0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('LFN0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 9)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('GRIDCERT0002', 'ASN.QM1_TO_QM2.DATAQ', 'LDBD', 'GRIDCERT', 'LDBD',
 'GRIDCERT', 'SEG_LHO', 'SEG_LHO', 1, 'I', 'P', 'V', 'F', 'Q',
 '000001', 2, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('GRIDCERT0002', 'ASN.QM1_TO_QM2.DATAQ', 'CREATOR_DB', 'CREATOR_DB',
 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('GRIDCERT0002', 'ASN.QM1_TO_QM2.DATAQ', 'PROCESS_ID', 'PROCESS_ID',
 'Y', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('GRIDCERT0002', 'ASN.QM1_TO_QM2.DATAQ', 'DN', 'DN', 'N', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('GRIDCERT0002', 'ASN.QM1_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('GRIDCERT0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('GRIDCERT0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 5)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('FILTER0002', 'ASN.QM1_TO_QM2.DATAQ', 'LDBD', 'FILTER', 'LDBD',
 'FILTER', 'SEG_LHO', 'SEG_LHO', 1, 'I', 'P', 'V', 'F', 'Q', '000001',
 2, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER0002', 'ASN.QM1_TO_QM2.DATAQ', 'CREATOR_DB', 'CREATOR_DB',
 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER0002', 'ASN.QM1_TO_QM2.DATAQ', 'PROGRAM', 'PROGRAM', 'N', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER0002', 'ASN.QM1_TO_QM2.DATAQ', 'START_TIME', 'START_TIME',
 'N', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER0002', 'ASN.QM1_TO_QM2.DATAQ', 'PROCESS_ID', 'PROCESS_ID',
 'N', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER0002', 'ASN.QM1_TO_QM2.DATAQ', 'FILTER_NAME', 'FILTER_NAME',
 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER0002', 'ASN.QM1_TO_QM2.DATAQ', 'FILTER_ID', 'FILTER_ID', 'Y',
 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER0002', 'ASN.QM1_TO_QM2.DATAQ', 'PARAM_SET', 'PARAM_SET', 'N',
 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER0002', 'ASN.QM1_TO_QM2.DATAQ', 'COMMENT', 'COMMENT', 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER0002', 'ASN.QM1_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 9)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 10)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('FILTER_PARAMS0002', 'ASN.QM1_TO_QM2.DATAQ', 'LDBD', 'FILTER_PARAMS'
, 'LDBD', 'FILTER_PARAMS', 'SEG_LHO', 'SEG_LHO', 1, 'I', 'P', 'V', 'F'
, 'Q', '000001', 2, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER_PARAMS0002', 'ASN.QM1_TO_QM2.DATAQ', 'CREATOR_DB',
 'CREATOR_DB', 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER_PARAMS0002', 'ASN.QM1_TO_QM2.DATAQ', 'PROCESS_ID',
 'PROCESS_ID', 'N', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER_PARAMS0002', 'ASN.QM1_TO_QM2.DATAQ', 'FILTER_NAME',
 'FILTER_NAME', 'N', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER_PARAMS0002', 'ASN.QM1_TO_QM2.DATAQ', 'FILTER_ID',
 'FILTER_ID', 'Y', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER_PARAMS0002', 'ASN.QM1_TO_QM2.DATAQ', 'PARAM', 'PARAM', 'Y',
 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER_PARAMS0002', 'ASN.QM1_TO_QM2.DATAQ', 'TYPE', 'TYPE', 'N', 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER_PARAMS0002', 'ASN.QM1_TO_QM2.DATAQ', 'VALUE', 'VALUE', 'N',
 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER_PARAMS0002', 'ASN.QM1_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER_PARAMS0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER_PARAMS0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 9)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('FRAMESET_CHANLIST0002', 'ASN.QM1_TO_QM2.DATAQ', 'LDBD',
 'FRAMESET_CHANLIST', 'LDBD', 'FRAMESET_CHANLIST', 'SEG_LHO',
 'SEG_LHO', 1, 'I', 'P', 'V', 'F', 'Q', '000001', 2, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_CHANLIST0002', 'ASN.QM1_TO_QM2.DATAQ', 'CREATOR_DB',
 'CREATOR_DB', 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_CHANLIST0002', 'ASN.QM1_TO_QM2.DATAQ', 'PROCESS_ID',
 'PROCESS_ID', 'N', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_CHANLIST0002', 'ASN.QM1_TO_QM2.DATAQ', 'FRAMESET_GROUP',
 'FRAMESET_GROUP', 'N', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_CHANLIST0002', 'ASN.QM1_TO_QM2.DATAQ', 'START_TIME',
 'START_TIME', 'N', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_CHANLIST0002', 'ASN.QM1_TO_QM2.DATAQ', 'END_TIME',
 'END_TIME', 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_CHANLIST0002', 'ASN.QM1_TO_QM2.DATAQ', 'CHANLIST_ID',
 'CHANLIST_ID', 'Y', 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_CHANLIST0002', 'ASN.QM1_TO_QM2.DATAQ', 'CHANLIST',
 'CHANLIST', 'N', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_CHANLIST0002', 'ASN.QM1_TO_QM2.DATAQ', 'CHANLIST_LENGTH',
 'CHANLIST_LENGTH', 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_CHANLIST0002', 'ASN.QM1_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_CHANLIST0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 9)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_CHANLIST0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 10)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('FRAMESET_WRITER0002', 'ASN.QM1_TO_QM2.DATAQ', 'LDBD',
 'FRAMESET_WRITER', 'LDBD', 'FRAMESET_WRITER', 'SEG_LHO', 'SEG_LHO', 1
, 'I', 'P', 'V', 'F', 'Q', '000001', 2, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_WRITER0002', 'ASN.QM1_TO_QM2.DATAQ', 'CREATOR_DB',
 'CREATOR_DB', 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_WRITER0002', 'ASN.QM1_TO_QM2.DATAQ', 'PROGRAM', 'PROGRAM',
 'N', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_WRITER0002', 'ASN.QM1_TO_QM2.DATAQ', 'PROCESS_ID',
 'PROCESS_ID', 'Y', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_WRITER0002', 'ASN.QM1_TO_QM2.DATAQ', 'FRAMESET_GROUP',
 'FRAMESET_GROUP', 'Y', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_WRITER0002', 'ASN.QM1_TO_QM2.DATAQ', 'DATA_SOURCE',
 'DATA_SOURCE', 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_WRITER0002', 'ASN.QM1_TO_QM2.DATAQ', 'IFOS', 'IFOS', 'N',
 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_WRITER0002', 'ASN.QM1_TO_QM2.DATAQ', 'COMMENT', 'COMMENT',
 'N', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_WRITER0002', 'ASN.QM1_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_WRITER0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_WRITER0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 9)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('FRAMESET0002', 'ASN.QM1_TO_QM2.DATAQ', 'LDBD', 'FRAMESET', 'LDBD',
 'FRAMESET', 'SEG_LHO', 'SEG_LHO', 1, 'I', 'P', 'V', 'F', 'Q',
 '000001', 2, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0002', 'ASN.QM1_TO_QM2.DATAQ', 'CREATOR_DB', 'CREATOR_DB',
 'N', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0002', 'ASN.QM1_TO_QM2.DATAQ', 'PROCESS_ID', 'PROCESS_ID',
 'N', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0002', 'ASN.QM1_TO_QM2.DATAQ', 'FRAMESET_GROUP',
 'FRAMESET_GROUP', 'Y', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0002', 'ASN.QM1_TO_QM2.DATAQ', 'CHANLIST_CDB',
 'CHANLIST_CDB', 'N', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0002', 'ASN.QM1_TO_QM2.DATAQ', 'CHANLIST_ID', 'CHANLIST_ID'
, 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0002', 'ASN.QM1_TO_QM2.DATAQ', 'START_TIME', 'START_TIME',
 'Y', 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0002', 'ASN.QM1_TO_QM2.DATAQ', 'START_TIME_NS',
 'START_TIME_NS', 'N', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0002', 'ASN.QM1_TO_QM2.DATAQ', 'END_TIME', 'END_TIME', 'Y',
 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0002', 'ASN.QM1_TO_QM2.DATAQ', 'END_TIME_NS', 'END_TIME_NS'
, 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0002', 'ASN.QM1_TO_QM2.DATAQ', 'N_FRAMES', 'N_FRAMES', 'N',
 9)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0002', 'ASN.QM1_TO_QM2.DATAQ', 'MISSING_FRAMES',
 'MISSING_FRAMES', 'N', 10)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0002', 'ASN.QM1_TO_QM2.DATAQ', 'N_BYTES', 'N_BYTES', 'N',
 11)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0002', 'ASN.QM1_TO_QM2.DATAQ', 'NAME', 'NAME', 'N', 12)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0002', 'ASN.QM1_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 13)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 14)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 15)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('FRAMESET_LOC0002', 'ASN.QM1_TO_QM2.DATAQ', 'LDBD', 'FRAMESET_LOC',
 'LDBD', 'FRAMESET_LOC', 'SEG_LHO', 'SEG_LHO', 1, 'I', 'P', 'V', 'F',
 'Q', '000001', 2, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_LOC0002', 'ASN.QM1_TO_QM2.DATAQ', 'CREATOR_DB',
 'CREATOR_DB', 'N', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_LOC0002', 'ASN.QM1_TO_QM2.DATAQ', 'NAME', 'NAME', 'N', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_LOC0002', 'ASN.QM1_TO_QM2.DATAQ', 'MEDIA_TYPE',
 'MEDIA_TYPE', 'N', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_LOC0002', 'ASN.QM1_TO_QM2.DATAQ', 'NODE', 'NODE', 'Y', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_LOC0002', 'ASN.QM1_TO_QM2.DATAQ', 'MEDIA_LOC', 'MEDIA_LOC'
, 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_LOC0002', 'ASN.QM1_TO_QM2.DATAQ', 'MEDIA_STATUS',
 'MEDIA_STATUS', 'N', 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_LOC0002', 'ASN.QM1_TO_QM2.DATAQ', 'FULLNAME', 'FULLNAME',
 'Y', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_LOC0002', 'ASN.QM1_TO_QM2.DATAQ', 'FILENUM', 'FILENUM',
 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_LOC0002', 'ASN.QM1_TO_QM2.DATAQ', 'DECOMPRESS_CMD',
 'DECOMPRESS_CMD', 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_LOC0002', 'ASN.QM1_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 9)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_LOC0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 10)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_LOC0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 11)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('SEGMENT_DEFINER0002', 'ASN.QM1_TO_QM2.DATAQ', 'LDBD',
 'SEGMENT_DEFINER', 'LDBD', 'SEGMENT_DEFINER', 'SEG_LHO', 'SEG_LHO', 1
, 'I', 'P', 'V', 'F', 'Q', '000001', 2, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEFINER0002', 'ASN.QM1_TO_QM2.DATAQ', 'CREATOR_DB',
 'CREATOR_DB', 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEFINER0002', 'ASN.QM1_TO_QM2.DATAQ', 'PROCESS_ID',
 'PROCESS_ID', 'N', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEFINER0002', 'ASN.QM1_TO_QM2.DATAQ', 'SEGMENT_DEF_ID',
 'SEGMENT_DEF_ID', 'Y', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEFINER0002', 'ASN.QM1_TO_QM2.DATAQ', 'RUN', 'RUN', 'N', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEFINER0002', 'ASN.QM1_TO_QM2.DATAQ', 'IFOS', 'IFOS', 'N',
 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEFINER0002', 'ASN.QM1_TO_QM2.DATAQ', 'NAME', 'NAME', 'N',
 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEFINER0002', 'ASN.QM1_TO_QM2.DATAQ', 'VERSION', 'VERSION',
 'N', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEFINER0002', 'ASN.QM1_TO_QM2.DATAQ', 'COMMENT', 'COMMENT',
 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEFINER0002', 'ASN.QM1_TO_QM2.DATAQ', 'STATE_VEC_MAJOR',
 'STATE_VEC_MAJOR', 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEFINER0002', 'ASN.QM1_TO_QM2.DATAQ', 'STATE_VEC_MINOR',
 'STATE_VEC_MINOR', 'N', 9)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEFINER0002', 'ASN.QM1_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 10)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEFINER0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 11)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEFINER0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 12)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('SEGMENT0002', 'ASN.QM1_TO_QM2.DATAQ', 'LDBD', 'SEGMENT', 'LDBD',
 'SEGMENT', 'SEG_LHO', 'SEG_LHO', 1, 'I', 'P', 'V', 'F', 'Q', '000001'
, 2, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT0002', 'ASN.QM1_TO_QM2.DATAQ', 'CREATOR_DB', 'CREATOR_DB',
 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT0002', 'ASN.QM1_TO_QM2.DATAQ', 'PROCESS_ID', 'PROCESS_ID',
 'N', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT0002', 'ASN.QM1_TO_QM2.DATAQ', 'SEGMENT_ID', 'SEGMENT_ID',
 'Y', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT0002', 'ASN.QM1_TO_QM2.DATAQ', 'START_TIME', 'START_TIME',
 'N', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT0002', 'ASN.QM1_TO_QM2.DATAQ', 'START_TIME_NS',
 'START_TIME_NS', 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT0002', 'ASN.QM1_TO_QM2.DATAQ', 'END_TIME', 'END_TIME', 'N',
 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT0002', 'ASN.QM1_TO_QM2.DATAQ', 'END_TIME_NS', 'END_TIME_NS',
 'N', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT0002', 'ASN.QM1_TO_QM2.DATAQ', 'ACTIVE', 'ACTIVE', 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT0002', 'ASN.QM1_TO_QM2.DATAQ', 'SEGNUM', 'SEGNUM', 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT0002', 'ASN.QM1_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 9)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 10)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 11)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('SEGMENT_DEF_MAP0002', 'ASN.QM1_TO_QM2.DATAQ', 'LDBD',
 'SEGMENT_DEF_MAP', 'LDBD', 'SEGMENT_DEF_MAP', 'SEG_LHO', 'SEG_LHO', 1
, 'I', 'P', 'V', 'F', 'Q', '000001', 2, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEF_MAP0002', 'ASN.QM1_TO_QM2.DATAQ', 'CREATOR_DB',
 'CREATOR_DB', 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEF_MAP0002', 'ASN.QM1_TO_QM2.DATAQ', 'PROCESS_ID',
 'PROCESS_ID', 'N', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEF_MAP0002', 'ASN.QM1_TO_QM2.DATAQ', 'SEG_DEF_MAP_ID',
 'SEG_DEF_MAP_ID', 'Y', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEF_MAP0002', 'ASN.QM1_TO_QM2.DATAQ', 'SEGMENT_CDB',
 'SEGMENT_CDB', 'N', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEF_MAP0002', 'ASN.QM1_TO_QM2.DATAQ', 'SEGMENT_ID',
 'SEGMENT_ID', 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEF_MAP0002', 'ASN.QM1_TO_QM2.DATAQ', 'SEGMENT_DEF_CDB',
 'SEGMENT_DEF_CDB', 'N', 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEF_MAP0002', 'ASN.QM1_TO_QM2.DATAQ', 'SEGMENT_DEF_ID',
 'SEGMENT_DEF_ID', 'N', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEF_MAP0002', 'ASN.QM1_TO_QM2.DATAQ', 'STATE_VEC_MAP',
 'STATE_VEC_MAP', 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEF_MAP0002', 'ASN.QM1_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEF_MAP0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 9)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEF_MAP0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 10)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('SEGMENT_LFN_MAP0002', 'ASN.QM1_TO_QM2.DATAQ', 'LDBD',
 'SEGMENT_LFN_MAP', 'LDBD', 'SEGMENT_LFN_MAP', 'SEG_LHO', 'SEG_LHO', 1
, 'I', 'P', 'V', 'F', 'Q', '000001', 2, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_LFN_MAP0002', 'ASN.QM1_TO_QM2.DATAQ', 'CREATOR_DB',
 'CREATOR_DB', 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_LFN_MAP0002', 'ASN.QM1_TO_QM2.DATAQ', 'PROCESS_ID',
 'PROCESS_ID', 'N', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_LFN_MAP0002', 'ASN.QM1_TO_QM2.DATAQ', 'SEG_LFN_MAP_ID',
 'SEG_LFN_MAP_ID', 'Y', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_LFN_MAP0002', 'ASN.QM1_TO_QM2.DATAQ', 'SEGMENT_CDB',
 'SEGMENT_CDB', 'N', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_LFN_MAP0002', 'ASN.QM1_TO_QM2.DATAQ', 'SEGMENT_ID',
 'SEGMENT_ID', 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_LFN_MAP0002', 'ASN.QM1_TO_QM2.DATAQ', 'LFN_CDB', 'LFN_CDB',
 'N', 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_LFN_MAP0002', 'ASN.QM1_TO_QM2.DATAQ', 'LFN_ID', 'LFN_ID',
 'N', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_LFN_MAP0002', 'ASN.QM1_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_LFN_MAP0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_LFN_MAP0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 9)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('SUMM_VALUE0002', 'ASN.QM1_TO_QM2.DATAQ', 'LDBD', 'SUMM_VALUE',
 'LDBD', 'SUMM_VALUE', 'SEG_LHO', 'SEG_LHO', 1, 'I', 'P', 'V', 'F',
 'Q', '000001', 2, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0002', 'ASN.QM1_TO_QM2.DATAQ', 'CREATOR_DB', 'CREATOR_DB'
, 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0002', 'ASN.QM1_TO_QM2.DATAQ', 'SUMM_VALUE_ID',
 'SUMM_VALUE_ID', 'Y', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0002', 'ASN.QM1_TO_QM2.DATAQ', 'PROGRAM', 'PROGRAM', 'N',
 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0002', 'ASN.QM1_TO_QM2.DATAQ', 'PROCESS_ID', 'PROCESS_ID'
, 'N', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0002', 'ASN.QM1_TO_QM2.DATAQ', 'FRAMESET_GROUP',
 'FRAMESET_GROUP', 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0002', 'ASN.QM1_TO_QM2.DATAQ', 'SEGMENT_DEF_ID',
 'SEGMENT_DEF_ID', 'N', 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0002', 'ASN.QM1_TO_QM2.DATAQ', 'START_TIME', 'START_TIME'
, 'N', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0002', 'ASN.QM1_TO_QM2.DATAQ', 'START_TIME_NS',
 'START_TIME_NS', 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0002', 'ASN.QM1_TO_QM2.DATAQ', 'END_TIME', 'END_TIME',
 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0002', 'ASN.QM1_TO_QM2.DATAQ', 'END_TIME_NS',
 'END_TIME_NS', 'N', 9)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0002', 'ASN.QM1_TO_QM2.DATAQ', 'IFO', 'IFO', 'N', 10)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0002', 'ASN.QM1_TO_QM2.DATAQ', 'NAME', 'NAME', 'N', 11)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0002', 'ASN.QM1_TO_QM2.DATAQ', 'VALUE', 'VALUE', 'N', 12)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0002', 'ASN.QM1_TO_QM2.DATAQ', 'ERROR', 'ERROR', 'N', 13)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0002', 'ASN.QM1_TO_QM2.DATAQ', 'INTVALUE', 'INTVALUE',
 'N', 14)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0002', 'ASN.QM1_TO_QM2.DATAQ', 'COMMENT', 'COMMENT', 'N',
 15)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0002', 'ASN.QM1_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 16)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 17)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 18)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('SUMM_STATISTICS0002', 'ASN.QM1_TO_QM2.DATAQ', 'LDBD',
 'SUMM_STATISTICS', 'LDBD', 'SUMM_STATISTICS', 'SEG_LHO', 'SEG_LHO', 1
, 'I', 'P', 'V', 'F', 'Q', '000001', 2, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0002', 'ASN.QM1_TO_QM2.DATAQ', 'CREATOR_DB',
 'CREATOR_DB', 'N', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0002', 'ASN.QM1_TO_QM2.DATAQ', 'PROGRAM', 'PROGRAM',
 'N', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0002', 'ASN.QM1_TO_QM2.DATAQ', 'PROCESS_ID',
 'PROCESS_ID', 'N', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0002', 'ASN.QM1_TO_QM2.DATAQ', 'FRAMESET_GROUP',
 'FRAMESET_GROUP', 'N', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0002', 'ASN.QM1_TO_QM2.DATAQ', 'SEGMENT_DEF_ID',
 'SEGMENT_DEF_ID', 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0002', 'ASN.QM1_TO_QM2.DATAQ', 'START_TIME',
 'START_TIME', 'Y', 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0002', 'ASN.QM1_TO_QM2.DATAQ', 'START_TIME_NS',
 'START_TIME_NS', 'N', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0002', 'ASN.QM1_TO_QM2.DATAQ', 'END_TIME',
 'END_TIME', 'Y', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0002', 'ASN.QM1_TO_QM2.DATAQ', 'END_TIME_NS',
 'END_TIME_NS', 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0002', 'ASN.QM1_TO_QM2.DATAQ', 'FRAMES_USED',
 'FRAMES_USED', 'N', 9)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0002', 'ASN.QM1_TO_QM2.DATAQ', 'SAMPLES', 'SAMPLES',
 'N', 10)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0002', 'ASN.QM1_TO_QM2.DATAQ', 'CHANNEL', 'CHANNEL',
 'Y', 11)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0002', 'ASN.QM1_TO_QM2.DATAQ', 'MIN_VALUE',
 'MIN_VALUE', 'N', 12)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0002', 'ASN.QM1_TO_QM2.DATAQ', 'MAX_VALUE',
 'MAX_VALUE', 'N', 13)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0002', 'ASN.QM1_TO_QM2.DATAQ', 'MIN_DELTA',
 'MIN_DELTA', 'N', 14)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0002', 'ASN.QM1_TO_QM2.DATAQ', 'MAX_DELTA',
 'MAX_DELTA', 'N', 15)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0002', 'ASN.QM1_TO_QM2.DATAQ', 'MIN_DELTADELTA',
 'MIN_DELTADELTA', 'N', 16)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0002', 'ASN.QM1_TO_QM2.DATAQ', 'MAX_DELTADELTA',
 'MAX_DELTADELTA', 'N', 17)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0002', 'ASN.QM1_TO_QM2.DATAQ', 'MEAN', 'MEAN', 'N',
 18)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0002', 'ASN.QM1_TO_QM2.DATAQ', 'VARIANCE',
 'VARIANCE', 'N', 19)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0002', 'ASN.QM1_TO_QM2.DATAQ', 'RMS', 'RMS', 'N', 20
)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0002', 'ASN.QM1_TO_QM2.DATAQ', 'SKEWNESS',
 'SKEWNESS', 'N', 21)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0002', 'ASN.QM1_TO_QM2.DATAQ', 'KURTOSIS',
 'KURTOSIS', 'N', 22)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0002', 'ASN.QM1_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 23)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 24)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 25)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('SUMM_SPECTRUM0002', 'ASN.QM1_TO_QM2.DATAQ', 'LDBD', 'SUMM_SPECTRUM'
, 'LDBD', 'SUMM_SPECTRUM', 'SEG_LHO', 'SEG_LHO', 1, 'I', 'P', 'V', 'F'
, 'Q', '000001', 2, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0002', 'ASN.QM1_TO_QM2.DATAQ', 'CREATOR_DB',
 'CREATOR_DB', 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0002', 'ASN.QM1_TO_QM2.DATAQ', 'SUMM_SPECTRUM_ID',
 'SUMM_SPECTRUM_ID', 'Y', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0002', 'ASN.QM1_TO_QM2.DATAQ', 'PROGRAM', 'PROGRAM',
 'N', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0002', 'ASN.QM1_TO_QM2.DATAQ', 'PROCESS_ID',
 'PROCESS_ID', 'N', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0002', 'ASN.QM1_TO_QM2.DATAQ', 'FRAMESET_GROUP',
 'FRAMESET_GROUP', 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0002', 'ASN.QM1_TO_QM2.DATAQ', 'SEGMENT_DEF_ID',
 'SEGMENT_DEF_ID', 'N', 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0002', 'ASN.QM1_TO_QM2.DATAQ', 'START_TIME',
 'START_TIME', 'N', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0002', 'ASN.QM1_TO_QM2.DATAQ', 'START_TIME_NS',
 'START_TIME_NS', 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0002', 'ASN.QM1_TO_QM2.DATAQ', 'END_TIME', 'END_TIME',
 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0002', 'ASN.QM1_TO_QM2.DATAQ', 'END_TIME_NS',
 'END_TIME_NS', 'N', 9)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0002', 'ASN.QM1_TO_QM2.DATAQ', 'FRAMES_USED',
 'FRAMES_USED', 'N', 10)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0002', 'ASN.QM1_TO_QM2.DATAQ', 'START_FREQUENCY',
 'START_FREQUENCY', 'N', 11)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0002', 'ASN.QM1_TO_QM2.DATAQ', 'DELTA_FREQUENCY',
 'DELTA_FREQUENCY', 'N', 12)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0002', 'ASN.QM1_TO_QM2.DATAQ', 'MIMETYPE', 'MIMETYPE',
 'N', 13)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0002', 'ASN.QM1_TO_QM2.DATAQ', 'CHANNEL', 'CHANNEL',
 'N', 14)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0002', 'ASN.QM1_TO_QM2.DATAQ', 'SPECTRUM_TYPE',
 'SPECTRUM_TYPE', 'N', 15)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0002', 'ASN.QM1_TO_QM2.DATAQ', 'SPECTRUM', 'SPECTRUM',
 'N', 16)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0002', 'ASN.QM1_TO_QM2.DATAQ', 'SPECTRUM_LENGTH',
 'SPECTRUM_LENGTH', 'N', 17)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0002', 'ASN.QM1_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 18)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 19)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 20)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('SUMM_CSD0002', 'ASN.QM1_TO_QM2.DATAQ', 'LDBD', 'SUMM_CSD', 'LDBD',
 'SUMM_CSD', 'SEG_LHO', 'SEG_LHO', 1, 'I', 'P', 'V', 'F', 'Q',
 '000001', 2, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0002', 'ASN.QM1_TO_QM2.DATAQ', 'CREATOR_DB', 'CREATOR_DB',
 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0002', 'ASN.QM1_TO_QM2.DATAQ', 'SUMM_CSD_ID', 'SUMM_CSD_ID'
, 'Y', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0002', 'ASN.QM1_TO_QM2.DATAQ', 'PROGRAM', 'PROGRAM', 'N', 2
)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0002', 'ASN.QM1_TO_QM2.DATAQ', 'PROCESS_ID', 'PROCESS_ID',
 'N', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0002', 'ASN.QM1_TO_QM2.DATAQ', 'FRAMESET_GROUP',
 'FRAMESET_GROUP', 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0002', 'ASN.QM1_TO_QM2.DATAQ', 'SEGMENT_DEF_ID',
 'SEGMENT_DEF_ID', 'N', 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0002', 'ASN.QM1_TO_QM2.DATAQ', 'START_TIME', 'START_TIME',
 'N', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0002', 'ASN.QM1_TO_QM2.DATAQ', 'START_TIME_NS',
 'START_TIME_NS', 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0002', 'ASN.QM1_TO_QM2.DATAQ', 'END_TIME', 'END_TIME', 'N',
 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0002', 'ASN.QM1_TO_QM2.DATAQ', 'END_TIME_NS', 'END_TIME_NS'
, 'N', 9)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0002', 'ASN.QM1_TO_QM2.DATAQ', 'FRAMES_USED', 'FRAMES_USED'
, 'N', 10)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0002', 'ASN.QM1_TO_QM2.DATAQ', 'START_FREQUENCY',
 'START_FREQUENCY', 'N', 11)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0002', 'ASN.QM1_TO_QM2.DATAQ', 'DELTA_FREQUENCY',
 'DELTA_FREQUENCY', 'N', 12)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0002', 'ASN.QM1_TO_QM2.DATAQ', 'MIMETYPE', 'MIMETYPE', 'N',
 13)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0002', 'ASN.QM1_TO_QM2.DATAQ', 'CHANNEL1', 'CHANNEL1', 'N',
 14)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0002', 'ASN.QM1_TO_QM2.DATAQ', 'CHANNEL2', 'CHANNEL2', 'N',
 15)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0002', 'ASN.QM1_TO_QM2.DATAQ', 'SPECTRUM_TYPE',
 'SPECTRUM_TYPE', 'N', 16)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0002', 'ASN.QM1_TO_QM2.DATAQ', 'SPECTRUM', 'SPECTRUM', 'N',
 17)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0002', 'ASN.QM1_TO_QM2.DATAQ', 'SPECTRUM_LENGTH',
 'SPECTRUM_LENGTH', 'N', 18)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0002', 'ASN.QM1_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 19)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 20)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 21)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('SUMM_COMMENT0002', 'ASN.QM1_TO_QM2.DATAQ', 'LDBD', 'SUMM_COMMENT',
 'LDBD', 'SUMM_COMMENT', 'SEG_LHO', 'SEG_LHO', 1, 'I', 'P', 'V', 'F',
 'Q', '000001', 2, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0002', 'ASN.QM1_TO_QM2.DATAQ', 'CREATOR_DB',
 'CREATOR_DB', 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0002', 'ASN.QM1_TO_QM2.DATAQ', 'PROGRAM', 'PROGRAM',
 'N', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0002', 'ASN.QM1_TO_QM2.DATAQ', 'PROCESS_ID',
 'PROCESS_ID', 'N', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0002', 'ASN.QM1_TO_QM2.DATAQ', 'SUBMITTER', 'SUBMITTER'
, 'N', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0002', 'ASN.QM1_TO_QM2.DATAQ', 'FRAMESET_GROUP',
 'FRAMESET_GROUP', 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0002', 'ASN.QM1_TO_QM2.DATAQ', 'SEGMENT_DEF_ID',
 'SEGMENT_DEF_ID', 'N', 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0002', 'ASN.QM1_TO_QM2.DATAQ', 'START_TIME',
 'START_TIME', 'N', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0002', 'ASN.QM1_TO_QM2.DATAQ', 'START_TIME_NS',
 'START_TIME_NS', 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0002', 'ASN.QM1_TO_QM2.DATAQ', 'END_TIME', 'END_TIME',
 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0002', 'ASN.QM1_TO_QM2.DATAQ', 'END_TIME_NS',
 'END_TIME_NS', 'N', 9)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0002', 'ASN.QM1_TO_QM2.DATAQ', 'IFO', 'IFO', 'N', 10)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0002', 'ASN.QM1_TO_QM2.DATAQ', 'TEXT', 'TEXT', 'N', 11)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0002', 'ASN.QM1_TO_QM2.DATAQ', 'SUMM_COMMENT_ID',
 'SUMM_COMMENT_ID', 'Y', 12)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0002', 'ASN.QM1_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 13)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 14)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 15)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('SUMM_MIME0002', 'ASN.QM1_TO_QM2.DATAQ', 'LDBD', 'SUMM_MIME', 'LDBD'
, 'SUMM_MIME', 'SEG_LHO', 'SEG_LHO', 1, 'I', 'P', 'V', 'F', 'Q',
 '000001', 2, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0002', 'ASN.QM1_TO_QM2.DATAQ', 'CREATOR_DB', 'CREATOR_DB',
 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0002', 'ASN.QM1_TO_QM2.DATAQ', 'ORIGIN', 'ORIGIN', 'N', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0002', 'ASN.QM1_TO_QM2.DATAQ', 'PROCESS_ID', 'PROCESS_ID',
 'N', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0002', 'ASN.QM1_TO_QM2.DATAQ', 'FILENAME', 'FILENAME', 'N'
, 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0002', 'ASN.QM1_TO_QM2.DATAQ', 'SUBMITTER', 'SUBMITTER',
 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0002', 'ASN.QM1_TO_QM2.DATAQ', 'SUBMIT_TIME',
 'SUBMIT_TIME', 'N', 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0002', 'ASN.QM1_TO_QM2.DATAQ', 'FRAMESET_GROUP',
 'FRAMESET_GROUP', 'N', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0002', 'ASN.QM1_TO_QM2.DATAQ', 'SEGMENT_DEF_ID',
 'SEGMENT_DEF_ID', 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0002', 'ASN.QM1_TO_QM2.DATAQ', 'START_TIME', 'START_TIME',
 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0002', 'ASN.QM1_TO_QM2.DATAQ', 'START_TIME_NS',
 'START_TIME_NS', 'N', 9)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0002', 'ASN.QM1_TO_QM2.DATAQ', 'END_TIME', 'END_TIME', 'N'
, 10)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0002', 'ASN.QM1_TO_QM2.DATAQ', 'END_TIME_NS',
 'END_TIME_NS', 'N', 11)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0002', 'ASN.QM1_TO_QM2.DATAQ', 'CHANNEL', 'CHANNEL', 'N',
 12)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0002', 'ASN.QM1_TO_QM2.DATAQ', 'DESCRIP', 'DESCRIP', 'N',
 13)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0002', 'ASN.QM1_TO_QM2.DATAQ', 'MIMEDATA', 'MIMEDATA', 'N'
, 14)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0002', 'ASN.QM1_TO_QM2.DATAQ', 'MIMEDATA_LENGTH',
 'MIMEDATA_LENGTH', 'N', 15)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0002', 'ASN.QM1_TO_QM2.DATAQ', 'MIMETYPE', 'MIMETYPE', 'N'
, 16)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0002', 'ASN.QM1_TO_QM2.DATAQ', 'COMMENT', 'COMMENT', 'N',
 17)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0002', 'ASN.QM1_TO_QM2.DATAQ', 'SUMM_MIME_ID',
 'SUMM_MIME_ID', 'Y', 18)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0002', 'ASN.QM1_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 19)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 20)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0002', 'ASN.QM1_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 21)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('PROCESS0005', 'ASN.QM3_TO_QM2.DATAQ', 'LDBD', 'PROCESS', 'LDBD',
 'PROCESS', 'SEG_CIT', 'SEG_CIT', 1, 'I', 'P', 'V', 'F', 'Q', '000001'
, 3, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0005', 'ASN.QM3_TO_QM2.DATAQ', 'CREATOR_DB', 'CREATOR_DB',
 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0005', 'ASN.QM3_TO_QM2.DATAQ', 'PROGRAM', 'PROGRAM', 'N', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0005', 'ASN.QM3_TO_QM2.DATAQ', 'VERSION', 'VERSION', 'N', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0005', 'ASN.QM3_TO_QM2.DATAQ', 'CVS_REPOSITORY',
 'CVS_REPOSITORY', 'N', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0005', 'ASN.QM3_TO_QM2.DATAQ', 'CVS_ENTRY_TIME',
 'CVS_ENTRY_TIME', 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0005', 'ASN.QM3_TO_QM2.DATAQ', 'COMMENT', 'COMMENT', 'N', 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0005', 'ASN.QM3_TO_QM2.DATAQ', 'IS_ONLINE', 'IS_ONLINE', 'N'
, 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0005', 'ASN.QM3_TO_QM2.DATAQ', 'NODE', 'NODE', 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0005', 'ASN.QM3_TO_QM2.DATAQ', 'USERNAME', 'USERNAME', 'N',
 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0005', 'ASN.QM3_TO_QM2.DATAQ', 'UNIX_PROCID', 'UNIX_PROCID',
 'N', 9)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0005', 'ASN.QM3_TO_QM2.DATAQ', 'START_TIME', 'START_TIME',
 'N', 10)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0005', 'ASN.QM3_TO_QM2.DATAQ', 'END_TIME', 'END_TIME', 'N',
 11)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0005', 'ASN.QM3_TO_QM2.DATAQ', 'JOBID', 'JOBID', 'N', 12)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0005', 'ASN.QM3_TO_QM2.DATAQ', 'DOMAIN', 'DOMAIN', 'N', 13)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0005', 'ASN.QM3_TO_QM2.DATAQ', 'PROCESS_ID', 'PROCESS_ID',
 'Y', 14)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0005', 'ASN.QM3_TO_QM2.DATAQ', 'PARAM_SET', 'PARAM_SET', 'N'
, 15)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0005', 'ASN.QM3_TO_QM2.DATAQ', 'IFOS', 'IFOS', 'N', 16)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0005', 'ASN.QM3_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 17)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 18)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 19)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('PROCESS_PARAMS0005', 'ASN.QM3_TO_QM2.DATAQ', 'LDBD',
 'PROCESS_PARAMS', 'LDBD', 'PROCESS_PARAMS', 'SEG_CIT', 'SEG_CIT', 1,
 'I', 'P', 'V', 'F', 'Q', '000001', 3, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS_PARAMS0005', 'ASN.QM3_TO_QM2.DATAQ', 'CREATOR_DB',
 'CREATOR_DB', 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS_PARAMS0005', 'ASN.QM3_TO_QM2.DATAQ', 'PROGRAM', 'PROGRAM',
 'N', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS_PARAMS0005', 'ASN.QM3_TO_QM2.DATAQ', 'PROCESS_ID',
 'PROCESS_ID', 'Y', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS_PARAMS0005', 'ASN.QM3_TO_QM2.DATAQ', 'PARAM', 'PARAM', 'Y',
 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS_PARAMS0005', 'ASN.QM3_TO_QM2.DATAQ', 'TYPE', 'TYPE', 'N', 4
)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS_PARAMS0005', 'ASN.QM3_TO_QM2.DATAQ', 'VALUE', 'VALUE', 'N',
 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS_PARAMS0005', 'ASN.QM3_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS_PARAMS0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('PROCESS_PARAMS0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 8)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('LFN0005', 'ASN.QM3_TO_QM2.DATAQ', 'LDBD', 'LFN', 'LDBD', 'LFN',
 'SEG_CIT', 'SEG_CIT', 1, 'I', 'P', 'V', 'F', 'Q', '000001', 3, 1, 0,
 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('LFN0005', 'ASN.QM3_TO_QM2.DATAQ', 'CREATOR_DB', 'CREATOR_DB', 'Y',
 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('LFN0005', 'ASN.QM3_TO_QM2.DATAQ', 'PROCESS_ID', 'PROCESS_ID', 'N',
 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('LFN0005', 'ASN.QM3_TO_QM2.DATAQ', 'LFN_ID', 'LFN_ID', 'Y', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('LFN0005', 'ASN.QM3_TO_QM2.DATAQ', 'NAME', 'NAME', 'N', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('LFN0005', 'ASN.QM3_TO_QM2.DATAQ', 'COMMENT', 'COMMENT', 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('LFN0005', 'ASN.QM3_TO_QM2.DATAQ', 'START_TIME', 'START_TIME', 'N',
 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('LFN0005', 'ASN.QM3_TO_QM2.DATAQ', 'END_TIME', 'END_TIME', 'N', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('LFN0005', 'ASN.QM3_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('LFN0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('LFN0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 9)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('GRIDCERT0005', 'ASN.QM3_TO_QM2.DATAQ', 'LDBD', 'GRIDCERT', 'LDBD',
 'GRIDCERT', 'SEG_CIT', 'SEG_CIT', 1, 'I', 'P', 'V', 'F', 'Q',
 '000001', 3, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('GRIDCERT0005', 'ASN.QM3_TO_QM2.DATAQ', 'CREATOR_DB', 'CREATOR_DB',
 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('GRIDCERT0005', 'ASN.QM3_TO_QM2.DATAQ', 'PROCESS_ID', 'PROCESS_ID',
 'Y', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('GRIDCERT0005', 'ASN.QM3_TO_QM2.DATAQ', 'DN', 'DN', 'N', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('GRIDCERT0005', 'ASN.QM3_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('GRIDCERT0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('GRIDCERT0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 5)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('FILTER0005', 'ASN.QM3_TO_QM2.DATAQ', 'LDBD', 'FILTER', 'LDBD',
 'FILTER', 'SEG_CIT', 'SEG_CIT', 1, 'I', 'P', 'V', 'F', 'Q', '000001',
 3, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER0005', 'ASN.QM3_TO_QM2.DATAQ', 'CREATOR_DB', 'CREATOR_DB',
 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER0005', 'ASN.QM3_TO_QM2.DATAQ', 'PROGRAM', 'PROGRAM', 'N', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER0005', 'ASN.QM3_TO_QM2.DATAQ', 'START_TIME', 'START_TIME',
 'N', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER0005', 'ASN.QM3_TO_QM2.DATAQ', 'PROCESS_ID', 'PROCESS_ID',
 'N', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER0005', 'ASN.QM3_TO_QM2.DATAQ', 'FILTER_NAME', 'FILTER_NAME',
 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER0005', 'ASN.QM3_TO_QM2.DATAQ', 'FILTER_ID', 'FILTER_ID', 'Y',
 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER0005', 'ASN.QM3_TO_QM2.DATAQ', 'PARAM_SET', 'PARAM_SET', 'N',
 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER0005', 'ASN.QM3_TO_QM2.DATAQ', 'COMMENT', 'COMMENT', 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER0005', 'ASN.QM3_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 9)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 10)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('FILTER_PARAMS0005', 'ASN.QM3_TO_QM2.DATAQ', 'LDBD', 'FILTER_PARAMS'
, 'LDBD', 'FILTER_PARAMS', 'SEG_CIT', 'SEG_CIT', 1, 'I', 'P', 'V', 'F'
, 'Q', '000001', 3, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER_PARAMS0005', 'ASN.QM3_TO_QM2.DATAQ', 'CREATOR_DB',
 'CREATOR_DB', 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER_PARAMS0005', 'ASN.QM3_TO_QM2.DATAQ', 'PROCESS_ID',
 'PROCESS_ID', 'N', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER_PARAMS0005', 'ASN.QM3_TO_QM2.DATAQ', 'FILTER_NAME',
 'FILTER_NAME', 'N', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER_PARAMS0005', 'ASN.QM3_TO_QM2.DATAQ', 'FILTER_ID',
 'FILTER_ID', 'Y', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER_PARAMS0005', 'ASN.QM3_TO_QM2.DATAQ', 'PARAM', 'PARAM', 'Y',
 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER_PARAMS0005', 'ASN.QM3_TO_QM2.DATAQ', 'TYPE', 'TYPE', 'N', 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER_PARAMS0005', 'ASN.QM3_TO_QM2.DATAQ', 'VALUE', 'VALUE', 'N',
 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER_PARAMS0005', 'ASN.QM3_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER_PARAMS0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FILTER_PARAMS0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 9)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('FRAMESET_CHANLIST0005', 'ASN.QM3_TO_QM2.DATAQ', 'LDBD',
 'FRAMESET_CHANLIST', 'LDBD', 'FRAMESET_CHANLIST', 'SEG_CIT',
 'SEG_CIT', 1, 'I', 'P', 'V', 'F', 'Q', '000001', 3, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_CHANLIST0005', 'ASN.QM3_TO_QM2.DATAQ', 'CREATOR_DB',
 'CREATOR_DB', 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_CHANLIST0005', 'ASN.QM3_TO_QM2.DATAQ', 'PROCESS_ID',
 'PROCESS_ID', 'N', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_CHANLIST0005', 'ASN.QM3_TO_QM2.DATAQ', 'FRAMESET_GROUP',
 'FRAMESET_GROUP', 'N', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_CHANLIST0005', 'ASN.QM3_TO_QM2.DATAQ', 'START_TIME',
 'START_TIME', 'N', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_CHANLIST0005', 'ASN.QM3_TO_QM2.DATAQ', 'END_TIME',
 'END_TIME', 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_CHANLIST0005', 'ASN.QM3_TO_QM2.DATAQ', 'CHANLIST_ID',
 'CHANLIST_ID', 'Y', 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_CHANLIST0005', 'ASN.QM3_TO_QM2.DATAQ', 'CHANLIST',
 'CHANLIST', 'N', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_CHANLIST0005', 'ASN.QM3_TO_QM2.DATAQ', 'CHANLIST_LENGTH',
 'CHANLIST_LENGTH', 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_CHANLIST0005', 'ASN.QM3_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_CHANLIST0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 9)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_CHANLIST0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 10)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('FRAMESET_WRITER0005', 'ASN.QM3_TO_QM2.DATAQ', 'LDBD',
 'FRAMESET_WRITER', 'LDBD', 'FRAMESET_WRITER', 'SEG_CIT', 'SEG_CIT', 1
, 'I', 'P', 'V', 'F', 'Q', '000001', 3, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_WRITER0005', 'ASN.QM3_TO_QM2.DATAQ', 'CREATOR_DB',
 'CREATOR_DB', 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_WRITER0005', 'ASN.QM3_TO_QM2.DATAQ', 'PROGRAM', 'PROGRAM',
 'N', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_WRITER0005', 'ASN.QM3_TO_QM2.DATAQ', 'PROCESS_ID',
 'PROCESS_ID', 'Y', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_WRITER0005', 'ASN.QM3_TO_QM2.DATAQ', 'FRAMESET_GROUP',
 'FRAMESET_GROUP', 'Y', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_WRITER0005', 'ASN.QM3_TO_QM2.DATAQ', 'DATA_SOURCE',
 'DATA_SOURCE', 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_WRITER0005', 'ASN.QM3_TO_QM2.DATAQ', 'IFOS', 'IFOS', 'N',
 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_WRITER0005', 'ASN.QM3_TO_QM2.DATAQ', 'COMMENT', 'COMMENT',
 'N', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_WRITER0005', 'ASN.QM3_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_WRITER0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_WRITER0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 9)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('FRAMESET0005', 'ASN.QM3_TO_QM2.DATAQ', 'LDBD', 'FRAMESET', 'LDBD',
 'FRAMESET', 'SEG_CIT', 'SEG_CIT', 1, 'I', 'P', 'V', 'F', 'Q',
 '000001', 3, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0005', 'ASN.QM3_TO_QM2.DATAQ', 'CREATOR_DB', 'CREATOR_DB',
 'N', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0005', 'ASN.QM3_TO_QM2.DATAQ', 'PROCESS_ID', 'PROCESS_ID',
 'N', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0005', 'ASN.QM3_TO_QM2.DATAQ', 'FRAMESET_GROUP',
 'FRAMESET_GROUP', 'Y', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0005', 'ASN.QM3_TO_QM2.DATAQ', 'CHANLIST_CDB',
 'CHANLIST_CDB', 'N', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0005', 'ASN.QM3_TO_QM2.DATAQ', 'CHANLIST_ID', 'CHANLIST_ID'
, 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0005', 'ASN.QM3_TO_QM2.DATAQ', 'START_TIME', 'START_TIME',
 'Y', 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0005', 'ASN.QM3_TO_QM2.DATAQ', 'START_TIME_NS',
 'START_TIME_NS', 'N', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0005', 'ASN.QM3_TO_QM2.DATAQ', 'END_TIME', 'END_TIME', 'Y',
 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0005', 'ASN.QM3_TO_QM2.DATAQ', 'END_TIME_NS', 'END_TIME_NS'
, 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0005', 'ASN.QM3_TO_QM2.DATAQ', 'N_FRAMES', 'N_FRAMES', 'N',
 9)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0005', 'ASN.QM3_TO_QM2.DATAQ', 'MISSING_FRAMES',
 'MISSING_FRAMES', 'N', 10)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0005', 'ASN.QM3_TO_QM2.DATAQ', 'N_BYTES', 'N_BYTES', 'N',
 11)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0005', 'ASN.QM3_TO_QM2.DATAQ', 'NAME', 'NAME', 'N', 12)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0005', 'ASN.QM3_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 13)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 14)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 15)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('FRAMESET_LOC0005', 'ASN.QM3_TO_QM2.DATAQ', 'LDBD', 'FRAMESET_LOC',
 'LDBD', 'FRAMESET_LOC', 'SEG_CIT', 'SEG_CIT', 1, 'I', 'P', 'V', 'F',
 'Q', '000001', 3, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_LOC0005', 'ASN.QM3_TO_QM2.DATAQ', 'CREATOR_DB',
 'CREATOR_DB', 'N', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_LOC0005', 'ASN.QM3_TO_QM2.DATAQ', 'NAME', 'NAME', 'N', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_LOC0005', 'ASN.QM3_TO_QM2.DATAQ', 'MEDIA_TYPE',
 'MEDIA_TYPE', 'N', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_LOC0005', 'ASN.QM3_TO_QM2.DATAQ', 'NODE', 'NODE', 'Y', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_LOC0005', 'ASN.QM3_TO_QM2.DATAQ', 'MEDIA_LOC', 'MEDIA_LOC'
, 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_LOC0005', 'ASN.QM3_TO_QM2.DATAQ', 'MEDIA_STATUS',
 'MEDIA_STATUS', 'N', 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_LOC0005', 'ASN.QM3_TO_QM2.DATAQ', 'FULLNAME', 'FULLNAME',
 'Y', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_LOC0005', 'ASN.QM3_TO_QM2.DATAQ', 'FILENUM', 'FILENUM',
 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_LOC0005', 'ASN.QM3_TO_QM2.DATAQ', 'DECOMPRESS_CMD',
 'DECOMPRESS_CMD', 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_LOC0005', 'ASN.QM3_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 9)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_LOC0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 10)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('FRAMESET_LOC0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 11)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('SEGMENT_DEFINER0005', 'ASN.QM3_TO_QM2.DATAQ', 'LDBD',
 'SEGMENT_DEFINER', 'LDBD', 'SEGMENT_DEFINER', 'SEG_CIT', 'SEG_CIT', 1
, 'I', 'P', 'V', 'F', 'Q', '000001', 3, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEFINER0005', 'ASN.QM3_TO_QM2.DATAQ', 'CREATOR_DB',
 'CREATOR_DB', 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEFINER0005', 'ASN.QM3_TO_QM2.DATAQ', 'PROCESS_ID',
 'PROCESS_ID', 'N', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEFINER0005', 'ASN.QM3_TO_QM2.DATAQ', 'SEGMENT_DEF_ID',
 'SEGMENT_DEF_ID', 'Y', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEFINER0005', 'ASN.QM3_TO_QM2.DATAQ', 'RUN', 'RUN', 'N', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEFINER0005', 'ASN.QM3_TO_QM2.DATAQ', 'IFOS', 'IFOS', 'N',
 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEFINER0005', 'ASN.QM3_TO_QM2.DATAQ', 'NAME', 'NAME', 'N',
 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEFINER0005', 'ASN.QM3_TO_QM2.DATAQ', 'VERSION', 'VERSION',
 'N', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEFINER0005', 'ASN.QM3_TO_QM2.DATAQ', 'COMMENT', 'COMMENT',
 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEFINER0005', 'ASN.QM3_TO_QM2.DATAQ', 'STATE_VEC_MAJOR',
 'STATE_VEC_MAJOR', 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEFINER0005', 'ASN.QM3_TO_QM2.DATAQ', 'STATE_VEC_MINOR',
 'STATE_VEC_MINOR', 'N', 9)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEFINER0005', 'ASN.QM3_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 10)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEFINER0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 11)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEFINER0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 12)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('SEGMENT0005', 'ASN.QM3_TO_QM2.DATAQ', 'LDBD', 'SEGMENT', 'LDBD',
 'SEGMENT', 'SEG_CIT', 'SEG_CIT', 1, 'I', 'P', 'V', 'F', 'Q', '000001'
, 3, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT0005', 'ASN.QM3_TO_QM2.DATAQ', 'CREATOR_DB', 'CREATOR_DB',
 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT0005', 'ASN.QM3_TO_QM2.DATAQ', 'PROCESS_ID', 'PROCESS_ID',
 'N', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT0005', 'ASN.QM3_TO_QM2.DATAQ', 'SEGMENT_ID', 'SEGMENT_ID',
 'Y', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT0005', 'ASN.QM3_TO_QM2.DATAQ', 'START_TIME', 'START_TIME',
 'N', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT0005', 'ASN.QM3_TO_QM2.DATAQ', 'START_TIME_NS',
 'START_TIME_NS', 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT0005', 'ASN.QM3_TO_QM2.DATAQ', 'END_TIME', 'END_TIME', 'N',
 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT0005', 'ASN.QM3_TO_QM2.DATAQ', 'END_TIME_NS', 'END_TIME_NS',
 'N', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT0005', 'ASN.QM3_TO_QM2.DATAQ', 'ACTIVE', 'ACTIVE', 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT0005', 'ASN.QM3_TO_QM2.DATAQ', 'SEGNUM', 'SEGNUM', 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT0005', 'ASN.QM3_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 9)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 10)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 11)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('SEGMENT_DEF_MAP0005', 'ASN.QM3_TO_QM2.DATAQ', 'LDBD',
 'SEGMENT_DEF_MAP', 'LDBD', 'SEGMENT_DEF_MAP', 'SEG_CIT', 'SEG_CIT', 1
, 'I', 'P', 'V', 'F', 'Q', '000001', 3, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEF_MAP0005', 'ASN.QM3_TO_QM2.DATAQ', 'CREATOR_DB',
 'CREATOR_DB', 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEF_MAP0005', 'ASN.QM3_TO_QM2.DATAQ', 'PROCESS_ID',
 'PROCESS_ID', 'N', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEF_MAP0005', 'ASN.QM3_TO_QM2.DATAQ', 'SEG_DEF_MAP_ID',
 'SEG_DEF_MAP_ID', 'Y', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEF_MAP0005', 'ASN.QM3_TO_QM2.DATAQ', 'SEGMENT_CDB',
 'SEGMENT_CDB', 'N', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEF_MAP0005', 'ASN.QM3_TO_QM2.DATAQ', 'SEGMENT_ID',
 'SEGMENT_ID', 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEF_MAP0005', 'ASN.QM3_TO_QM2.DATAQ', 'SEGMENT_DEF_CDB',
 'SEGMENT_DEF_CDB', 'N', 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEF_MAP0005', 'ASN.QM3_TO_QM2.DATAQ', 'SEGMENT_DEF_ID',
 'SEGMENT_DEF_ID', 'N', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEF_MAP0005', 'ASN.QM3_TO_QM2.DATAQ', 'STATE_VEC_MAP',
 'STATE_VEC_MAP', 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEF_MAP0005', 'ASN.QM3_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEF_MAP0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 9)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_DEF_MAP0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 10)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('SEGMENT_LFN_MAP0005', 'ASN.QM3_TO_QM2.DATAQ', 'LDBD',
 'SEGMENT_LFN_MAP', 'LDBD', 'SEGMENT_LFN_MAP', 'SEG_CIT', 'SEG_CIT', 1
, 'I', 'P', 'V', 'F', 'Q', '000001', 3, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_LFN_MAP0005', 'ASN.QM3_TO_QM2.DATAQ', 'CREATOR_DB',
 'CREATOR_DB', 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_LFN_MAP0005', 'ASN.QM3_TO_QM2.DATAQ', 'PROCESS_ID',
 'PROCESS_ID', 'N', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_LFN_MAP0005', 'ASN.QM3_TO_QM2.DATAQ', 'SEG_LFN_MAP_ID',
 'SEG_LFN_MAP_ID', 'Y', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_LFN_MAP0005', 'ASN.QM3_TO_QM2.DATAQ', 'SEGMENT_CDB',
 'SEGMENT_CDB', 'N', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_LFN_MAP0005', 'ASN.QM3_TO_QM2.DATAQ', 'SEGMENT_ID',
 'SEGMENT_ID', 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_LFN_MAP0005', 'ASN.QM3_TO_QM2.DATAQ', 'LFN_CDB', 'LFN_CDB',
 'N', 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_LFN_MAP0005', 'ASN.QM3_TO_QM2.DATAQ', 'LFN_ID', 'LFN_ID',
 'N', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_LFN_MAP0005', 'ASN.QM3_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_LFN_MAP0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SEGMENT_LFN_MAP0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 9)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('SUMM_VALUE0005', 'ASN.QM3_TO_QM2.DATAQ', 'LDBD', 'SUMM_VALUE',
 'LDBD', 'SUMM_VALUE', 'SEG_CIT', 'SEG_CIT', 1, 'I', 'P', 'V', 'F',
 'Q', '000001', 3, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0005', 'ASN.QM3_TO_QM2.DATAQ', 'CREATOR_DB', 'CREATOR_DB'
, 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0005', 'ASN.QM3_TO_QM2.DATAQ', 'SUMM_VALUE_ID',
 'SUMM_VALUE_ID', 'Y', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0005', 'ASN.QM3_TO_QM2.DATAQ', 'PROGRAM', 'PROGRAM', 'N',
 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0005', 'ASN.QM3_TO_QM2.DATAQ', 'PROCESS_ID', 'PROCESS_ID'
, 'N', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0005', 'ASN.QM3_TO_QM2.DATAQ', 'FRAMESET_GROUP',
 'FRAMESET_GROUP', 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0005', 'ASN.QM3_TO_QM2.DATAQ', 'SEGMENT_DEF_ID',
 'SEGMENT_DEF_ID', 'N', 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0005', 'ASN.QM3_TO_QM2.DATAQ', 'START_TIME', 'START_TIME'
, 'N', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0005', 'ASN.QM3_TO_QM2.DATAQ', 'START_TIME_NS',
 'START_TIME_NS', 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0005', 'ASN.QM3_TO_QM2.DATAQ', 'END_TIME', 'END_TIME',
 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0005', 'ASN.QM3_TO_QM2.DATAQ', 'END_TIME_NS',
 'END_TIME_NS', 'N', 9)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0005', 'ASN.QM3_TO_QM2.DATAQ', 'IFO', 'IFO', 'N', 10)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0005', 'ASN.QM3_TO_QM2.DATAQ', 'NAME', 'NAME', 'N', 11)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0005', 'ASN.QM3_TO_QM2.DATAQ', 'VALUE', 'VALUE', 'N', 12)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0005', 'ASN.QM3_TO_QM2.DATAQ', 'ERROR', 'ERROR', 'N', 13)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0005', 'ASN.QM3_TO_QM2.DATAQ', 'INTVALUE', 'INTVALUE',
 'N', 14)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0005', 'ASN.QM3_TO_QM2.DATAQ', 'COMMENT', 'COMMENT', 'N',
 15)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0005', 'ASN.QM3_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 16)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 17)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_VALUE0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 18)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('SUMM_STATISTICS0005', 'ASN.QM3_TO_QM2.DATAQ', 'LDBD',
 'SUMM_STATISTICS', 'LDBD', 'SUMM_STATISTICS', 'SEG_CIT', 'SEG_CIT', 1
, 'I', 'P', 'V', 'F', 'Q', '000001', 3, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0005', 'ASN.QM3_TO_QM2.DATAQ', 'CREATOR_DB',
 'CREATOR_DB', 'N', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0005', 'ASN.QM3_TO_QM2.DATAQ', 'PROGRAM', 'PROGRAM',
 'N', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0005', 'ASN.QM3_TO_QM2.DATAQ', 'PROCESS_ID',
 'PROCESS_ID', 'N', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0005', 'ASN.QM3_TO_QM2.DATAQ', 'FRAMESET_GROUP',
 'FRAMESET_GROUP', 'N', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0005', 'ASN.QM3_TO_QM2.DATAQ', 'SEGMENT_DEF_ID',
 'SEGMENT_DEF_ID', 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0005', 'ASN.QM3_TO_QM2.DATAQ', 'START_TIME',
 'START_TIME', 'Y', 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0005', 'ASN.QM3_TO_QM2.DATAQ', 'START_TIME_NS',
 'START_TIME_NS', 'N', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0005', 'ASN.QM3_TO_QM2.DATAQ', 'END_TIME',
 'END_TIME', 'Y', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0005', 'ASN.QM3_TO_QM2.DATAQ', 'END_TIME_NS',
 'END_TIME_NS', 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0005', 'ASN.QM3_TO_QM2.DATAQ', 'FRAMES_USED',
 'FRAMES_USED', 'N', 9)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0005', 'ASN.QM3_TO_QM2.DATAQ', 'SAMPLES', 'SAMPLES',
 'N', 10)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0005', 'ASN.QM3_TO_QM2.DATAQ', 'CHANNEL', 'CHANNEL',
 'Y', 11)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0005', 'ASN.QM3_TO_QM2.DATAQ', 'MIN_VALUE',
 'MIN_VALUE', 'N', 12)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0005', 'ASN.QM3_TO_QM2.DATAQ', 'MAX_VALUE',
 'MAX_VALUE', 'N', 13)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0005', 'ASN.QM3_TO_QM2.DATAQ', 'MIN_DELTA',
 'MIN_DELTA', 'N', 14)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0005', 'ASN.QM3_TO_QM2.DATAQ', 'MAX_DELTA',
 'MAX_DELTA', 'N', 15)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0005', 'ASN.QM3_TO_QM2.DATAQ', 'MIN_DELTADELTA',
 'MIN_DELTADELTA', 'N', 16)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0005', 'ASN.QM3_TO_QM2.DATAQ', 'MAX_DELTADELTA',
 'MAX_DELTADELTA', 'N', 17)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0005', 'ASN.QM3_TO_QM2.DATAQ', 'MEAN', 'MEAN', 'N',
 18)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0005', 'ASN.QM3_TO_QM2.DATAQ', 'VARIANCE',
 'VARIANCE', 'N', 19)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0005', 'ASN.QM3_TO_QM2.DATAQ', 'RMS', 'RMS', 'N', 20
)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0005', 'ASN.QM3_TO_QM2.DATAQ', 'SKEWNESS',
 'SKEWNESS', 'N', 21)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0005', 'ASN.QM3_TO_QM2.DATAQ', 'KURTOSIS',
 'KURTOSIS', 'N', 22)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0005', 'ASN.QM3_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 23)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 24)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_STATISTICS0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 25)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('SUMM_SPECTRUM0005', 'ASN.QM3_TO_QM2.DATAQ', 'LDBD', 'SUMM_SPECTRUM'
, 'LDBD', 'SUMM_SPECTRUM', 'SEG_CIT', 'SEG_CIT', 1, 'I', 'P', 'V', 'F'
, 'Q', '000001', 3, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0005', 'ASN.QM3_TO_QM2.DATAQ', 'CREATOR_DB',
 'CREATOR_DB', 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0005', 'ASN.QM3_TO_QM2.DATAQ', 'SUMM_SPECTRUM_ID',
 'SUMM_SPECTRUM_ID', 'Y', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0005', 'ASN.QM3_TO_QM2.DATAQ', 'PROGRAM', 'PROGRAM',
 'N', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0005', 'ASN.QM3_TO_QM2.DATAQ', 'PROCESS_ID',
 'PROCESS_ID', 'N', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0005', 'ASN.QM3_TO_QM2.DATAQ', 'FRAMESET_GROUP',
 'FRAMESET_GROUP', 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0005', 'ASN.QM3_TO_QM2.DATAQ', 'SEGMENT_DEF_ID',
 'SEGMENT_DEF_ID', 'N', 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0005', 'ASN.QM3_TO_QM2.DATAQ', 'START_TIME',
 'START_TIME', 'N', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0005', 'ASN.QM3_TO_QM2.DATAQ', 'START_TIME_NS',
 'START_TIME_NS', 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0005', 'ASN.QM3_TO_QM2.DATAQ', 'END_TIME', 'END_TIME',
 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0005', 'ASN.QM3_TO_QM2.DATAQ', 'END_TIME_NS',
 'END_TIME_NS', 'N', 9)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0005', 'ASN.QM3_TO_QM2.DATAQ', 'FRAMES_USED',
 'FRAMES_USED', 'N', 10)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0005', 'ASN.QM3_TO_QM2.DATAQ', 'START_FREQUENCY',
 'START_FREQUENCY', 'N', 11)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0005', 'ASN.QM3_TO_QM2.DATAQ', 'DELTA_FREQUENCY',
 'DELTA_FREQUENCY', 'N', 12)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0005', 'ASN.QM3_TO_QM2.DATAQ', 'MIMETYPE', 'MIMETYPE',
 'N', 13)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0005', 'ASN.QM3_TO_QM2.DATAQ', 'CHANNEL', 'CHANNEL',
 'N', 14)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0005', 'ASN.QM3_TO_QM2.DATAQ', 'SPECTRUM_TYPE',
 'SPECTRUM_TYPE', 'N', 15)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0005', 'ASN.QM3_TO_QM2.DATAQ', 'SPECTRUM', 'SPECTRUM',
 'N', 16)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0005', 'ASN.QM3_TO_QM2.DATAQ', 'SPECTRUM_LENGTH',
 'SPECTRUM_LENGTH', 'N', 17)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0005', 'ASN.QM3_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 18)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 19)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_SPECTRUM0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 20)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('SUMM_CSD0005', 'ASN.QM3_TO_QM2.DATAQ', 'LDBD', 'SUMM_CSD', 'LDBD',
 'SUMM_CSD', 'SEG_CIT', 'SEG_CIT', 1, 'I', 'P', 'V', 'F', 'Q',
 '000001', 3, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0005', 'ASN.QM3_TO_QM2.DATAQ', 'CREATOR_DB', 'CREATOR_DB',
 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0005', 'ASN.QM3_TO_QM2.DATAQ', 'SUMM_CSD_ID', 'SUMM_CSD_ID'
, 'Y', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0005', 'ASN.QM3_TO_QM2.DATAQ', 'PROGRAM', 'PROGRAM', 'N', 2
)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0005', 'ASN.QM3_TO_QM2.DATAQ', 'PROCESS_ID', 'PROCESS_ID',
 'N', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0005', 'ASN.QM3_TO_QM2.DATAQ', 'FRAMESET_GROUP',
 'FRAMESET_GROUP', 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0005', 'ASN.QM3_TO_QM2.DATAQ', 'SEGMENT_DEF_ID',
 'SEGMENT_DEF_ID', 'N', 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0005', 'ASN.QM3_TO_QM2.DATAQ', 'START_TIME', 'START_TIME',
 'N', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0005', 'ASN.QM3_TO_QM2.DATAQ', 'START_TIME_NS',
 'START_TIME_NS', 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0005', 'ASN.QM3_TO_QM2.DATAQ', 'END_TIME', 'END_TIME', 'N',
 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0005', 'ASN.QM3_TO_QM2.DATAQ', 'END_TIME_NS', 'END_TIME_NS'
, 'N', 9)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0005', 'ASN.QM3_TO_QM2.DATAQ', 'FRAMES_USED', 'FRAMES_USED'
, 'N', 10)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0005', 'ASN.QM3_TO_QM2.DATAQ', 'START_FREQUENCY',
 'START_FREQUENCY', 'N', 11)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0005', 'ASN.QM3_TO_QM2.DATAQ', 'DELTA_FREQUENCY',
 'DELTA_FREQUENCY', 'N', 12)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0005', 'ASN.QM3_TO_QM2.DATAQ', 'MIMETYPE', 'MIMETYPE', 'N',
 13)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0005', 'ASN.QM3_TO_QM2.DATAQ', 'CHANNEL1', 'CHANNEL1', 'N',
 14)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0005', 'ASN.QM3_TO_QM2.DATAQ', 'CHANNEL2', 'CHANNEL2', 'N',
 15)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0005', 'ASN.QM3_TO_QM2.DATAQ', 'SPECTRUM_TYPE',
 'SPECTRUM_TYPE', 'N', 16)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0005', 'ASN.QM3_TO_QM2.DATAQ', 'SPECTRUM', 'SPECTRUM', 'N',
 17)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0005', 'ASN.QM3_TO_QM2.DATAQ', 'SPECTRUM_LENGTH',
 'SPECTRUM_LENGTH', 'N', 18)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0005', 'ASN.QM3_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 19)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 20)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_CSD0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 21)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('SUMM_COMMENT0005', 'ASN.QM3_TO_QM2.DATAQ', 'LDBD', 'SUMM_COMMENT',
 'LDBD', 'SUMM_COMMENT', 'SEG_CIT', 'SEG_CIT', 1, 'I', 'P', 'V', 'F',
 'Q', '000001', 3, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0005', 'ASN.QM3_TO_QM2.DATAQ', 'CREATOR_DB',
 'CREATOR_DB', 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0005', 'ASN.QM3_TO_QM2.DATAQ', 'PROGRAM', 'PROGRAM',
 'N', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0005', 'ASN.QM3_TO_QM2.DATAQ', 'PROCESS_ID',
 'PROCESS_ID', 'N', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0005', 'ASN.QM3_TO_QM2.DATAQ', 'SUBMITTER', 'SUBMITTER'
, 'N', 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0005', 'ASN.QM3_TO_QM2.DATAQ', 'FRAMESET_GROUP',
 'FRAMESET_GROUP', 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0005', 'ASN.QM3_TO_QM2.DATAQ', 'SEGMENT_DEF_ID',
 'SEGMENT_DEF_ID', 'N', 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0005', 'ASN.QM3_TO_QM2.DATAQ', 'START_TIME',
 'START_TIME', 'N', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0005', 'ASN.QM3_TO_QM2.DATAQ', 'START_TIME_NS',
 'START_TIME_NS', 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0005', 'ASN.QM3_TO_QM2.DATAQ', 'END_TIME', 'END_TIME',
 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0005', 'ASN.QM3_TO_QM2.DATAQ', 'END_TIME_NS',
 'END_TIME_NS', 'N', 9)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0005', 'ASN.QM3_TO_QM2.DATAQ', 'IFO', 'IFO', 'N', 10)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0005', 'ASN.QM3_TO_QM2.DATAQ', 'TEXT', 'TEXT', 'N', 11)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0005', 'ASN.QM3_TO_QM2.DATAQ', 'SUMM_COMMENT_ID',
 'SUMM_COMMENT_ID', 'Y', 12)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0005', 'ASN.QM3_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 13)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 14)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_COMMENT0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 15)#
INSERT INTO ASN.IBMQREP_TARGETS
 (subname, recvq, source_owner, source_name, target_owner, target_name
, source_server, source_alias, target_type, state, subtype,
 conflict_rule, conflict_action, error_action, subgroup, source_node,
 target_node, load_type, has_loadphase)
 VALUES
 ('SUMM_MIME0005', 'ASN.QM3_TO_QM2.DATAQ', 'LDBD', 'SUMM_MIME', 'LDBD'
, 'SUMM_MIME', 'SEG_CIT', 'SEG_CIT', 1, 'I', 'P', 'V', 'F', 'Q',
 '000001', 3, 1, 0, 'E')#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0005', 'ASN.QM3_TO_QM2.DATAQ', 'CREATOR_DB', 'CREATOR_DB',
 'Y', 0)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0005', 'ASN.QM3_TO_QM2.DATAQ', 'ORIGIN', 'ORIGIN', 'N', 1)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0005', 'ASN.QM3_TO_QM2.DATAQ', 'PROCESS_ID', 'PROCESS_ID',
 'N', 2)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0005', 'ASN.QM3_TO_QM2.DATAQ', 'FILENAME', 'FILENAME', 'N'
, 3)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0005', 'ASN.QM3_TO_QM2.DATAQ', 'SUBMITTER', 'SUBMITTER',
 'N', 4)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0005', 'ASN.QM3_TO_QM2.DATAQ', 'SUBMIT_TIME',
 'SUBMIT_TIME', 'N', 5)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0005', 'ASN.QM3_TO_QM2.DATAQ', 'FRAMESET_GROUP',
 'FRAMESET_GROUP', 'N', 6)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0005', 'ASN.QM3_TO_QM2.DATAQ', 'SEGMENT_DEF_ID',
 'SEGMENT_DEF_ID', 'N', 7)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0005', 'ASN.QM3_TO_QM2.DATAQ', 'START_TIME', 'START_TIME',
 'N', 8)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0005', 'ASN.QM3_TO_QM2.DATAQ', 'START_TIME_NS',
 'START_TIME_NS', 'N', 9)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0005', 'ASN.QM3_TO_QM2.DATAQ', 'END_TIME', 'END_TIME', 'N'
, 10)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0005', 'ASN.QM3_TO_QM2.DATAQ', 'END_TIME_NS',
 'END_TIME_NS', 'N', 11)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0005', 'ASN.QM3_TO_QM2.DATAQ', 'CHANNEL', 'CHANNEL', 'N',
 12)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0005', 'ASN.QM3_TO_QM2.DATAQ', 'DESCRIP', 'DESCRIP', 'N',
 13)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0005', 'ASN.QM3_TO_QM2.DATAQ', 'MIMEDATA', 'MIMEDATA', 'N'
, 14)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0005', 'ASN.QM3_TO_QM2.DATAQ', 'MIMEDATA_LENGTH',
 'MIMEDATA_LENGTH', 'N', 15)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0005', 'ASN.QM3_TO_QM2.DATAQ', 'MIMETYPE', 'MIMETYPE', 'N'
, 16)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0005', 'ASN.QM3_TO_QM2.DATAQ', 'COMMENT', 'COMMENT', 'N',
 17)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0005', 'ASN.QM3_TO_QM2.DATAQ', 'SUMM_MIME_ID',
 'SUMM_MIME_ID', 'Y', 18)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0005', 'ASN.QM3_TO_QM2.DATAQ', 'INSERTION_TIME',
 'INSERTION_TIME', 'N', 19)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERTIME',
 'ibmqrepVERTIME', 'N', 20)#
INSERT INTO ASN.IBMQREP_TRG_COLS
 (subname, recvq, target_colname, source_colname, is_key, target_colNo)
 VALUES
 ('SUMM_MIME0005', 'ASN.QM3_TO_QM2.DATAQ', 'ibmqrepVERNODE',
 'ibmqrepVERNODE', 'N', 21)#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('PROCESS0006', 'LDBD', 'PROCESS', 'ASN.QM2_TO_QM3.DATAQ', 'P', 'N',
 'N', 'N', 'E', 'I', '000001', 1, 3, 'NNNN', 'N', 'SEG_CIT', 'SEG_CIT'
, 'LDBD', 'PROCESS', 1, 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0006', 'CREATOR_DB', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0006', 'PROGRAM', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0006', 'VERSION', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0006', 'CVS_REPOSITORY', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0006', 'CVS_ENTRY_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0006', 'COMMENT', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0006', 'IS_ONLINE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0006', 'NODE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0006', 'USERNAME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0006', 'UNIX_PROCID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0006', 'START_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0006', 'END_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0006', 'JOBID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0006', 'DOMAIN', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0006', 'PROCESS_ID', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0006', 'PARAM_SET', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0006', 'IFOS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0006', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0006', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS0006', 'ibmqrepVERNODE', 0)#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('PROCESS_PARAMS0006', 'LDBD', 'PROCESS_PARAMS',
 'ASN.QM2_TO_QM3.DATAQ', 'P', 'N', 'N', 'N', 'E', 'I', '000001', 1, 3,
 'NNNN', 'N', 'SEG_CIT', 'SEG_CIT', 'LDBD', 'PROCESS_PARAMS', 1, 'ASN'
)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS_PARAMS0006', 'CREATOR_DB', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS_PARAMS0006', 'PROGRAM', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS_PARAMS0006', 'PROCESS_ID', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS_PARAMS0006', 'PARAM', 3)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS_PARAMS0006', 'TYPE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS_PARAMS0006', 'VALUE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS_PARAMS0006', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS_PARAMS0006', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('PROCESS_PARAMS0006', 'ibmqrepVERNODE', 0)#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('LFN0006', 'LDBD', 'LFN', 'ASN.QM2_TO_QM3.DATAQ', 'P', 'N', 'N', 'N'
, 'E', 'I', '000001', 1, 3, 'NNNN', 'N', 'SEG_CIT', 'SEG_CIT', 'LDBD',
 'LFN', 1, 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('LFN0006', 'CREATOR_DB', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('LFN0006', 'PROCESS_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('LFN0006', 'LFN_ID', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('LFN0006', 'NAME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('LFN0006', 'COMMENT', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('LFN0006', 'START_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('LFN0006', 'END_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('LFN0006', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('LFN0006', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('LFN0006', 'ibmqrepVERNODE', 0)#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('GRIDCERT0006', 'LDBD', 'GRIDCERT', 'ASN.QM2_TO_QM3.DATAQ', 'P', 'N'
, 'N', 'N', 'E', 'I', '000001', 1, 3, 'NNNN', 'N', 'SEG_CIT',
 'SEG_CIT', 'LDBD', 'GRIDCERT', 1, 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('GRIDCERT0006', 'CREATOR_DB', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('GRIDCERT0006', 'PROCESS_ID', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('GRIDCERT0006', 'DN', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('GRIDCERT0006', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('GRIDCERT0006', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('GRIDCERT0006', 'ibmqrepVERNODE', 0)#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('FILTER0006', 'LDBD', 'FILTER', 'ASN.QM2_TO_QM3.DATAQ', 'P', 'N',
 'N', 'N', 'E', 'I', '000001', 1, 3, 'NNNN', 'N', 'SEG_CIT', 'SEG_CIT'
, 'LDBD', 'FILTER', 1, 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER0006', 'CREATOR_DB', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER0006', 'PROGRAM', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER0006', 'START_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER0006', 'PROCESS_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER0006', 'FILTER_NAME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER0006', 'FILTER_ID', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER0006', 'PARAM_SET', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER0006', 'COMMENT', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER0006', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER0006', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER0006', 'ibmqrepVERNODE', 0)#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('FILTER_PARAMS0006', 'LDBD', 'FILTER_PARAMS', 'ASN.QM2_TO_QM3.DATAQ'
, 'P', 'N', 'N', 'N', 'E', 'I', '000001', 1, 3, 'NNNN', 'N', 'SEG_CIT'
, 'SEG_CIT', 'LDBD', 'FILTER_PARAMS', 1, 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER_PARAMS0006', 'CREATOR_DB', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER_PARAMS0006', 'PROCESS_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER_PARAMS0006', 'FILTER_NAME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER_PARAMS0006', 'FILTER_ID', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER_PARAMS0006', 'PARAM', 3)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER_PARAMS0006', 'TYPE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER_PARAMS0006', 'VALUE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER_PARAMS0006', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER_PARAMS0006', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FILTER_PARAMS0006', 'ibmqrepVERNODE', 0)#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('FRAMESET_CHANLIST0006', 'LDBD', 'FRAMESET_CHANLIST',
 'ASN.QM2_TO_QM3.DATAQ', 'P', 'N', 'N', 'N', 'E', 'I', '000001', 1, 3,
 'NNNN', 'N', 'SEG_CIT', 'SEG_CIT', 'LDBD', 'FRAMESET_CHANLIST', 1,
 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_CHANLIST0006', 'CREATOR_DB', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_CHANLIST0006', 'PROCESS_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_CHANLIST0006', 'FRAMESET_GROUP', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_CHANLIST0006', 'START_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_CHANLIST0006', 'END_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_CHANLIST0006', 'CHANLIST_ID', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_CHANLIST0006', 'CHANLIST', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_CHANLIST0006', 'CHANLIST_LENGTH', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_CHANLIST0006', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_CHANLIST0006', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_CHANLIST0006', 'ibmqrepVERNODE', 0)#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('FRAMESET_WRITER0006', 'LDBD', 'FRAMESET_WRITER',
 'ASN.QM2_TO_QM3.DATAQ', 'P', 'N', 'N', 'N', 'E', 'I', '000001', 1, 3,
 'NNNN', 'N', 'SEG_CIT', 'SEG_CIT', 'LDBD', 'FRAMESET_WRITER', 1,
 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_WRITER0006', 'CREATOR_DB', 3)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_WRITER0006', 'PROGRAM', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_WRITER0006', 'PROCESS_ID', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_WRITER0006', 'FRAMESET_GROUP', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_WRITER0006', 'DATA_SOURCE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_WRITER0006', 'IFOS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_WRITER0006', 'COMMENT', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_WRITER0006', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_WRITER0006', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_WRITER0006', 'ibmqrepVERNODE', 0)#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('FRAMESET0006', 'LDBD', 'FRAMESET', 'ASN.QM2_TO_QM3.DATAQ', 'P', 'N'
, 'N', 'N', 'E', 'I', '000001', 1, 3, 'NNNN', 'N', 'SEG_CIT',
 'SEG_CIT', 'LDBD', 'FRAMESET', 1, 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0006', 'CREATOR_DB', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0006', 'PROCESS_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0006', 'FRAMESET_GROUP', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0006', 'CHANLIST_CDB', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0006', 'CHANLIST_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0006', 'START_TIME', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0006', 'START_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0006', 'END_TIME', 3)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0006', 'END_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0006', 'N_FRAMES', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0006', 'MISSING_FRAMES', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0006', 'N_BYTES', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0006', 'NAME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0006', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0006', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET0006', 'ibmqrepVERNODE', 0)#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('FRAMESET_LOC0006', 'LDBD', 'FRAMESET_LOC', 'ASN.QM2_TO_QM3.DATAQ',
 'P', 'N', 'N', 'N', 'E', 'I', '000001', 1, 3, 'NNNN', 'N', 'SEG_CIT',
 'SEG_CIT', 'LDBD', 'FRAMESET_LOC', 1, 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_LOC0006', 'CREATOR_DB', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_LOC0006', 'NAME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_LOC0006', 'MEDIA_TYPE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_LOC0006', 'NODE', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_LOC0006', 'MEDIA_LOC', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_LOC0006', 'MEDIA_STATUS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_LOC0006', 'FULLNAME', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_LOC0006', 'FILENUM', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_LOC0006', 'DECOMPRESS_CMD', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_LOC0006', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_LOC0006', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('FRAMESET_LOC0006', 'ibmqrepVERNODE', 0)#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('SEGMENT_DEFINER0006', 'LDBD', 'SEGMENT_DEFINER',
 'ASN.QM2_TO_QM3.DATAQ', 'P', 'N', 'N', 'N', 'E', 'I', '000001', 1, 3,
 'NNNN', 'N', 'SEG_CIT', 'SEG_CIT', 'LDBD', 'SEGMENT_DEFINER', 1,
 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEFINER0006', 'CREATOR_DB', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEFINER0006', 'PROCESS_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEFINER0006', 'SEGMENT_DEF_ID', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEFINER0006', 'RUN', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEFINER0006', 'IFOS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEFINER0006', 'NAME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEFINER0006', 'VERSION', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEFINER0006', 'COMMENT', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEFINER0006', 'STATE_VEC_MAJOR', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEFINER0006', 'STATE_VEC_MINOR', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEFINER0006', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEFINER0006', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEFINER0006', 'ibmqrepVERNODE', 0)#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('SEGMENT0006', 'LDBD', 'SEGMENT', 'ASN.QM2_TO_QM3.DATAQ', 'P', 'N',
 'N', 'N', 'E', 'I', '000001', 1, 3, 'NNNN', 'N', 'SEG_CIT', 'SEG_CIT'
, 'LDBD', 'SEGMENT', 1, 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT0006', 'CREATOR_DB', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT0006', 'PROCESS_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT0006', 'SEGMENT_ID', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT0006', 'START_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT0006', 'START_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT0006', 'END_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT0006', 'END_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT0006', 'ACTIVE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT0006', 'SEGNUM', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT0006', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT0006', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT0006', 'ibmqrepVERNODE', 0)#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('SEGMENT_DEF_MAP0006', 'LDBD', 'SEGMENT_DEF_MAP',
 'ASN.QM2_TO_QM3.DATAQ', 'P', 'N', 'N', 'N', 'E', 'I', '000001', 1, 3,
 'NNNN', 'N', 'SEG_CIT', 'SEG_CIT', 'LDBD', 'SEGMENT_DEF_MAP', 1,
 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEF_MAP0006', 'CREATOR_DB', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEF_MAP0006', 'PROCESS_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEF_MAP0006', 'SEG_DEF_MAP_ID', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEF_MAP0006', 'SEGMENT_CDB', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEF_MAP0006', 'SEGMENT_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEF_MAP0006', 'SEGMENT_DEF_CDB', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEF_MAP0006', 'SEGMENT_DEF_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEF_MAP0006', 'STATE_VEC_MAP', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEF_MAP0006', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEF_MAP0006', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_DEF_MAP0006', 'ibmqrepVERNODE', 0)#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('SEGMENT_LFN_MAP0006', 'LDBD', 'SEGMENT_LFN_MAP',
 'ASN.QM2_TO_QM3.DATAQ', 'P', 'N', 'N', 'N', 'E', 'I', '000001', 1, 3,
 'NNNN', 'N', 'SEG_CIT', 'SEG_CIT', 'LDBD', 'SEGMENT_LFN_MAP', 1,
 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_LFN_MAP0006', 'CREATOR_DB', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_LFN_MAP0006', 'PROCESS_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_LFN_MAP0006', 'SEG_LFN_MAP_ID', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_LFN_MAP0006', 'SEGMENT_CDB', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_LFN_MAP0006', 'SEGMENT_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_LFN_MAP0006', 'LFN_CDB', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_LFN_MAP0006', 'LFN_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_LFN_MAP0006', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_LFN_MAP0006', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SEGMENT_LFN_MAP0006', 'ibmqrepVERNODE', 0)#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('SUMM_VALUE0006', 'LDBD', 'SUMM_VALUE', 'ASN.QM2_TO_QM3.DATAQ', 'P',
 'N', 'N', 'N', 'E', 'I', '000001', 1, 3, 'NNNN', 'N', 'SEG_CIT',
 'SEG_CIT', 'LDBD', 'SUMM_VALUE', 1, 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0006', 'CREATOR_DB', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0006', 'SUMM_VALUE_ID', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0006', 'PROGRAM', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0006', 'PROCESS_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0006', 'FRAMESET_GROUP', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0006', 'SEGMENT_DEF_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0006', 'START_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0006', 'START_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0006', 'END_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0006', 'END_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0006', 'IFO', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0006', 'NAME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0006', 'VALUE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0006', 'ERROR', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0006', 'INTVALUE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0006', 'COMMENT', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0006', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0006', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_VALUE0006', 'ibmqrepVERNODE', 0)#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('SUMM_STATISTICS0006', 'LDBD', 'SUMM_STATISTICS',
 'ASN.QM2_TO_QM3.DATAQ', 'P', 'N', 'N', 'N', 'E', 'I', '000001', 1, 3,
 'NNNN', 'N', 'SEG_CIT', 'SEG_CIT', 'LDBD', 'SUMM_STATISTICS', 1,
 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0006', 'CREATOR_DB', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0006', 'PROGRAM', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0006', 'PROCESS_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0006', 'FRAMESET_GROUP', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0006', 'SEGMENT_DEF_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0006', 'START_TIME', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0006', 'START_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0006', 'END_TIME', 3)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0006', 'END_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0006', 'FRAMES_USED', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0006', 'SAMPLES', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0006', 'CHANNEL', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0006', 'MIN_VALUE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0006', 'MAX_VALUE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0006', 'MIN_DELTA', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0006', 'MAX_DELTA', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0006', 'MIN_DELTADELTA', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0006', 'MAX_DELTADELTA', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0006', 'MEAN', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0006', 'VARIANCE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0006', 'RMS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0006', 'SKEWNESS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0006', 'KURTOSIS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0006', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0006', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_STATISTICS0006', 'ibmqrepVERNODE', 0)#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('SUMM_SPECTRUM0006', 'LDBD', 'SUMM_SPECTRUM', 'ASN.QM2_TO_QM3.DATAQ'
, 'P', 'N', 'N', 'N', 'E', 'I', '000001', 1, 3, 'NNNN', 'N', 'SEG_CIT'
, 'SEG_CIT', 'LDBD', 'SUMM_SPECTRUM', 1, 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0006', 'CREATOR_DB', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0006', 'SUMM_SPECTRUM_ID', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0006', 'PROGRAM', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0006', 'PROCESS_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0006', 'FRAMESET_GROUP', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0006', 'SEGMENT_DEF_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0006', 'START_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0006', 'START_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0006', 'END_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0006', 'END_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0006', 'FRAMES_USED', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0006', 'START_FREQUENCY', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0006', 'DELTA_FREQUENCY', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0006', 'MIMETYPE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0006', 'CHANNEL', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0006', 'SPECTRUM_TYPE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0006', 'SPECTRUM', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0006', 'SPECTRUM_LENGTH', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0006', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0006', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_SPECTRUM0006', 'ibmqrepVERNODE', 0)#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('SUMM_CSD0006', 'LDBD', 'SUMM_CSD', 'ASN.QM2_TO_QM3.DATAQ', 'P', 'N'
, 'N', 'N', 'E', 'I', '000001', 1, 3, 'NNNN', 'N', 'SEG_CIT',
 'SEG_CIT', 'LDBD', 'SUMM_CSD', 1, 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0006', 'CREATOR_DB', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0006', 'SUMM_CSD_ID', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0006', 'PROGRAM', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0006', 'PROCESS_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0006', 'FRAMESET_GROUP', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0006', 'SEGMENT_DEF_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0006', 'START_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0006', 'START_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0006', 'END_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0006', 'END_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0006', 'FRAMES_USED', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0006', 'START_FREQUENCY', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0006', 'DELTA_FREQUENCY', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0006', 'MIMETYPE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0006', 'CHANNEL1', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0006', 'CHANNEL2', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0006', 'SPECTRUM_TYPE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0006', 'SPECTRUM', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0006', 'SPECTRUM_LENGTH', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0006', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0006', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_CSD0006', 'ibmqrepVERNODE', 0)#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('SUMM_COMMENT0006', 'LDBD', 'SUMM_COMMENT', 'ASN.QM2_TO_QM3.DATAQ',
 'P', 'N', 'N', 'N', 'E', 'I', '000001', 1, 3, 'NNNN', 'N', 'SEG_CIT',
 'SEG_CIT', 'LDBD', 'SUMM_COMMENT', 1, 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0006', 'CREATOR_DB', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0006', 'PROGRAM', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0006', 'PROCESS_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0006', 'SUBMITTER', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0006', 'FRAMESET_GROUP', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0006', 'SEGMENT_DEF_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0006', 'START_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0006', 'START_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0006', 'END_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0006', 'END_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0006', 'IFO', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0006', 'TEXT', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0006', 'SUMM_COMMENT_ID', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0006', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0006', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_COMMENT0006', 'ibmqrepVERNODE', 0)#
INSERT INTO ASN.IBMQREP_SUBS
 (subname, source_owner, source_name, sendq, subtype, all_changed_rows
, before_values, changed_cols_only, has_loadphase, state, subgroup,
 source_node, target_node, options_flag, suppress_deletes,
 target_server, target_alias, target_owner, target_name, target_type,
 apply_schema)
 VALUES
 ('SUMM_MIME0006', 'LDBD', 'SUMM_MIME', 'ASN.QM2_TO_QM3.DATAQ', 'P',
 'N', 'N', 'N', 'E', 'I', '000001', 1, 3, 'NNNN', 'N', 'SEG_CIT',
 'SEG_CIT', 'LDBD', 'SUMM_MIME', 1, 'ASN')#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0006', 'CREATOR_DB', 2)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0006', 'ORIGIN', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0006', 'PROCESS_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0006', 'FILENAME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0006', 'SUBMITTER', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0006', 'SUBMIT_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0006', 'FRAMESET_GROUP', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0006', 'SEGMENT_DEF_ID', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0006', 'START_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0006', 'START_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0006', 'END_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0006', 'END_TIME_NS', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0006', 'CHANNEL', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0006', 'DESCRIP', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0006', 'MIMEDATA', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0006', 'MIMEDATA_LENGTH', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0006', 'MIMETYPE', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0006', 'COMMENT', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0006', 'SUMM_MIME_ID', 1)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0006', 'INSERTION_TIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0006', 'ibmqrepVERTIME', 0)#
INSERT INTO ASN.IBMQREP_SRC_COLS
 (subname, src_colname, is_key)
 VALUES
 ('SUMM_MIME0006', 'ibmqrepVERNODE', 0)#
-- COMMIT#
