connect / as sysdba

begin
  for ses in (select sid, serial# from v$session where username = 'PLSQL_PKG_OWNER') loop
      dbms_output.put_line('sid = ' || ses.sid || ', serial# = ' || ses.serial#);
      execute immediate 'alter system kill session ''' || ses.sid || ', ' || ses.serial# || ''' immediate';
  end loop;
end;
/


drop   user PLSQL_PKG_OWNER cascade;
drop   user PLSQL_PKG_USER  cascade;

create user PLSQL_PKG_OWNER
   identified by PLSQL_PKG_OWNER_PW
   default    tablespace   data
   quota      unlimited on data;


create user PLSQL_PKG_USER
   identified by PLSQL_PKG_USER_PW
   default    tablespace   data
   quota      unlimited on data;

grant
   create     procedure,
   create any directory,
   drop   any directory,
   create     sequence,
   create     session,
   create     table,
   create     type,
   create     view
to
   PLSQL_PKG_OWNER;

--
-- Test case for SQL_STMT
--
-- grant select on user_objects to PLSQL_PKG_OWNER;

grant
   create session,
   create table
to
   PLSQL_PKG_USER;

prompt ses
@ ses/_install

prompt tim
@ tim/_install

--
-- jsn uses tim.iso_8601
--
prompt jsn
@ jsn/_install

prompt task
@ task/_install

prompt log
@ log/_install

prompt assert
@ assert/spec
@ assert/body

@ txt/types
@ txt/spec
@ txt/body
@ txt/_test/run

@ sql_stmt/_install

promp blob_wrapper
@ blob_wrapper/spec.plsql
@ blob_wrapper/body.plsql

define test_dir=blob_wrapper\_test
@ blob_wrapper/_test/all.sql

promp zipper
@ zipper/spec.plsql
@ zipper/body.plsql
@ zipper/test.plsql

exit
