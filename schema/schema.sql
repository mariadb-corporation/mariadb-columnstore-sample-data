drop database if exists bts;

create database bts;

use bts;

create table airlines (
iata_code varchar(2),
airline varchar(30)
) engine=columnstore default character set=utf8;

create table airports (
iata_code varchar(3),
airport varchar(80),
city varchar(30),
state varchar(2),
country varchar(30),
latitude decimal(11,4),
longitude decimal(11,4)
) engine=columnstore default character set=utf8;

create table flights (
year smallint,
month tinyint,
day tinyint,
day_of_week tinyint,
fl_date date,
carrier varchar(2),
tail_num varchar(6),
fl_num smallint,
origin varchar(5),
dest varchar(5),
crs_dep_time varchar(4),
dep_time varchar(4),
dep_delay smallint,
taxi_out smallint,
wheels_off varchar(4),
wheels_on varchar(4),
taxi_in smallint,
crs_arr_time varchar(4),
arr_time varchar(4),
arr_delay smallint,
cancelled smallint,
cancellation_code smallint,
diverted smallint,
crs_elapsed_time smallint,
actual_elapsed_time smallint,
air_time smallint,
distance smallint,
carrier_delay smallint,
weather_delay smallint,
nas_delay smallint,
security_delay smallint,
late_aircraft_delay smallint
) engine=columnstore default character set=utf8;
