create database orders;

use orders;

create table customer
(
  customer_id int not null auto_increment primary key,
  customer_name varchar(20),
  customer_address varchar(80)
) type = InnoDB;

create table orders
(
  order_id int not null auto_increment primary key,  
  order_date date,
  customer_id int not null references customer(customer_id)
) type = InnoDB;

create table item
(
  item_id int not null auto_increment primary key,
  item_name varchar(20)
) type = InnoDB;

create table order_item
(
  order_id int not null references orders(order_id),
  item_id int not null references item(item_id),
  item_quantity int,
  primary key (order_id, item_id)
) type = InnoDB;

alter table orders
add column comment text;

drop database orders;
