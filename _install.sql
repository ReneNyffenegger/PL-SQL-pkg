connect / as sysdba

begin
  for ses in (select sid, serial# from v$session where username = 'PLSQL_PKG_OWNER') loop
      dbms_output.put_line('sid = ' || ses.sid || ', serial# = ' || ses.serial#);
      execute immediate 'alter system kill session ''' || ses.sid || ', ' || ses.serial# || ''' immediate';
  end loop;
end;
/


drop   user PLSQL_PKG_OWNER cascade;

create user PLSQL_PKG_OWNER
   identified by PLSQL_PKG_OWNER_PW
   default    tablespace   data
   quota      unlimited on data;

grant
   create procedure,
   create sequence,
   create session,
   create table,
   create type,
   create view
to
   PLSQL_PKG_OWNER;


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
