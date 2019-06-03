--1-- practice joins

--1
select * from invoice i
join invoice_line il on il.invoice_id = i.invoice_id
where il.unit_price > 0.99;
--2
select i.invoice_date, c.first_name, c.last_name, i.total
from invoice i 
join customer c on i.customer_id= c.customer_id;

--3
select c.first_name, c.last_name, e.first_name, e.last_name
from customer as c
join employee as e on e.employee_id = c.support_rep_id;

--4
select al.title, ar.name 
from album as al
join artist as ar on ar.artist_id = al.artist_id

--5
select pt.track_id
from playlist_track pt
join playlist p on p.playlist_id = pt.playlist_id
where p.name = 'Music';

--6
select t.name 
from track as t 
join playlist_track as pt on t.track_id = pt.track_id
where pt.playlist_id = 5;

--7
select t.name, p.name 
from track as t 
join playlist_track as pt on t.track_id = pt.track_id
join playlist as p on pt.playlist_id = p.playlist_id;

--8
select t.name, a.title
from track as t
join album as a on t.album_id = a.album_id
join genre as g on g.genre_id = t.genre_id
where g.name = 'Alternative & Punk';


--2-- nested queries

--1
select *
from invoice
where invoice_id in ( select invoice_id from invoice_line where unit_price > .99);

--2
select * 
from playlist_track
where playlist_id in (select playlist_id from playlist where name = 'Music')

--3
select name
from track
where track_id in ( select track_id from playlist_track where playlist_id = 5 );

--4
select *
from track
where genre_id in ( SELECT genre_id from genre where name = 'Comedy' );

--5
select *
from track
where album_id in ( select album_id from album where title = 'Fireball' );

--6
select *
from track
where album_id in ( 
  select album_id from album where artist_id in ( 
    select artist_id from artist where name = 'Queen'
  )
); 

--3-- practice updating rows

--1
update customer 
set fax = null
where fax is not null;

--2
update customer 
set company = 'self'
where company is null;

--3
update customer 
set last_name = 'Thompson'
where first_name = 'Julia' and last_name = 'Barnett'; 

--4

update customer 
set support_rep_id = 4
where email = 'luisrojas@yahoo.cl';

select * from customer 
where support_rep_id = 4;

--5
update track
set composer = 'The darkness around us'
where genre_id = ( select genre_id from genre where name = 'Metal' )
and composer is null;

--4-- group by

--1
select count (*), g.name
from track t
join genre g on t.genre_id = g.genre_id
group by g.name;

--2
select count (*), g.name
from track t
join genre g on t.genre_id = g.genre_id
where g.name = 'Pop' or g.name = 'Rock'
group by g.name;

--3
select ar.name, count(*)
from album al
join artist ar on ar.artist_id = al.artist_id
group by ar.name;

--5-- distinct


--1
select distinct composer 
from track;

--2
select distinct billing_postal_code 
from invoice;

--3
select distinct company 
from customer;

--6-- practice delete

--1
delete from practice_delete 
where type = 'bronze'

--2
delete from practice_delete 
where type = 'silver';

--3
delete from practice_delete 
where value = 150;

---7---eCommerce Simulation

--1 seed

create table users (
user_id serial primary key,  
user_name text,
email text
);
create table products (
product_id serial primary key,
product_name text,
price integer
);
create table orders (
order_id serial primary key,
product_id integer references products(product_id),
quantity integer
);

--2
insert into users (user_name, email)
values ('Curt', 'bro@bro.com'),
('Brog', 'soso@sol.com'),
('Chris', 'nim@min.com');

select * from users;

insert into products (product_name, price)
values ('Arctic Monkeys', 12.99),
('Nirvana', 13.75),
('Justin Bieber', .05);

select * from products;

insert into orders (product_id, quantity)
values (1, 200),
(2,100),
(1, 300);

--3
select p.product_name
from orders as o 
join products p
on p.product_id = o.product_id
where o.product_id = 1;

select * from orders;


--4 

alter table users 
add column order_id integer references orders(order_id);

select * from users;

select sum(quantity)
from orders;

--5
update Users 
set order_id = 1
where user_id = 3;

update Users 
set order_id = 2
where user_id = 2;

update Users 
set order_id = 3
where user_id = 1;

update Users 
set order_id = 3
where user_id = 1;

update orders 
set user_id = 2
where order_id = 2;

update orders 
set user_id = 1
where order_id = 3;

select * from orders;
select * from users;

--6

select * from orders 
where user_id = 1;

--7
