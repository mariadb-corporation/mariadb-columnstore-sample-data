use loans;

drop table if exists states_d;

create table states_d (
 id int,
 name varchar(14),
 abbreviation char(2) primary key,
 assoc_press varchar(6),
 census_region tinyint,
 cension_region_name varchar(9),
 census_division tinyint,
 census_division_name varchar(18),
 circuit_court tinyint
) engine=InnoDB;
