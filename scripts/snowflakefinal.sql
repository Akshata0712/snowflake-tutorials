CREATE or replace DATABASE snow_akshata_db;

create or replace warehouse snow_akshata_wh;

use WAREHOUSE SNOW_AKSHATA_WH;

use DATABASE SNOW_AKSHATA_DB;

create or replace table emply (
first_name string ,
last_name string ,
email string ,
streetaddress string ,
city string ,
start_date date
);

put file:///Users/akshata/snowflake-tutorials/dataset/employees0*.csv @SNOW_AKSHATA_DB.public.%emply;

list @snow_akshata_db.PUBLIC.%emply;

copy into emply
from @%emply
file_format = (type = csv field_optionally_enclosed_by='"')
pattern = '.*employees0[1-5].csv.gz'
on_error = 'skip_file';

select * from EMPLY;

create or replace function fun_emp()
returns table (email string, city string)
as 
$$
   select email, city from emply
 $$
 ;

 select * from table(fun_emp());

 