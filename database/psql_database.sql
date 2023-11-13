create database dry_cleaning;
\c dry_cleaning

create table customer_login(
customer_id varchar(10) primary key,
full_name varchar(100),
email varchar(40),
password varchar(30),
mobile_no varchar(10)
);

create table store_login(
store_id varchar(10) primary key,
store_name varchar(100),
email varchar(40),
password varchar(30),
store_address varchar(200),
mobile_no varchar(10),
pincode varchar(6),
admin_approve_flag int
);

create table rate(
rate_id varchar(10) primary key,
saree_wash_amt float,
saree_iron_amt float,
jeans_wash_amt float,
jeans_iron_amt float,
suit_wash_amt float,
suit_iron_amt float,
top_wash_amt float,
top_iron_amt float,
store_id varchar(10) references store_login on delete cascade on update cascade
);

create table pickup_request(
pickup_id varchar(10) primary key,
full_name varchar(100),
pincode varchar(6),
pickup_time varchar(10),
pickup_date varchar(15),
address varchar(150),
saree_wash_qty int,
saree_iron_qty int,
jeans_wash_qty int,
jeans_iron_qty int,
suit_wash_qty int,
suit_iron_qty int,
top_wash_qty int,
top_iron_qty int,
completed_status int,
customer_id varchar(10) references customer_login on delete cascade on update cascade,
store_id varchar(10) references store_login on delete cascade on update cascade
);

create table payment(
payment_id varchar(10) primary key,
payment_amount float,
payment_status int,
pickup_id varchar(10) references pickup_request on delete cascade on update cascade,
payment_date varchar(20),
payment_time varchar(20)
);


-------------------------------------------------------------------------------------------------
Reference Queries: Do not run following queries
-------------------------------------------------------------------------------------------------
select store_name, payment_amount, payment_date, payment_time, payment_status
from pickup_request, payment, store_login
where pickup_request.pickup_id = payment.pickup_id and
store_login.store_id = pickup_request.store_id and
payment_status = 1 and
customer_id = 'C1';

select pickup_request.full_name, pickup_request.address, pickup_request.pincode, payment_amount,
store_name, store_address, store_login.pincode, store_login.mobile_no,

select *
from payment, store_login, pickup_request
where pickup_request.pickup_id = payment.pickup_id and
pickup_request.store_id = store_login.store_id and
customer_id = 'C1' and
payment_status = 1;


select *
from pickup_request
where pickup_id = (select pickup_id from payment
where payment_status = 1) and customer_id = 'C1';


select *
from payment
where pickup_id = (select pickup_id from pickup_request
where customer_id = 'C1') and payment_status = 1;


select *
from rate
where store_id = (select store_id from pickup_request
where pickup_id = (select pickup_id from payment
where payment_status = 1) and customer_id = 'C1');


select *
from store_login
where store_id = (select store_id from pickup_request
where customer_id = 'C1' and pickup_id in (select pickup_id from payment
where payment_status = 1));
