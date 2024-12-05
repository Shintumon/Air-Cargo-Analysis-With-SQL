/*  1.	Create an ER diagram for the given airlines database.

Steps to create the ER diagram for the given airlines database:

Open MySQL Workbench:
	Launch MySQL Workbench and connect to your MySQL server.
	Create a new EER Diagram:
	Go to File > New Model.
	In the new model window, go to Model > Add Diagram.

Create Tables:
	In the EER Diagram window, use the table tool (found in the toolbar) to create new tables.
	Double-click each table to open the table editor and define the columns (attributes), setting primary keys and foreign keys as needed.

Define the Tables:
Customer Table:
	customer_id (PK)
	first_name
	last_name
	date_of_birth
	gender

Passengers_on_flights Table:
	aircraft_id
	route_id
	customer_id (FK)
	depart
	arrival
	seat_num
	class_id
	travel_date
	flight_num

Ticket_details Table:
	p_date
	customer_id (FK)
	aircraft_id
	class_id
	no_of_tickets
	a_code
	price_per_ticket
	brand

Routes Table:
	route_id (PK)
	flight_num
	origin_airport
	destination_airport
	aircraft_id
	distance_miles

Set Primary and Foreign Keys:
Customer Table: 
	Set customer_id as the Primary Key.
Passengers_on_flights Table:
	Set customer_id as a Foreign Key that references Customer.customer_id.
Ticket_details Table:
	Set customer_id as a Foreign Key that references Customer.customer_id.
Routes Table:
	Set route_id as the Primary Key.

Create Relationships:
Customer - Passengers_on_flights:
	Create a one-to-many relationship between Customer.customer_id and Passengers_on_flights.customer_id.
Customer - Ticket_details:
	Create a one-to-many relationship between Customer.customer_id and Ticket_details.customer_id.
Passengers_on_flights - Routes:
	Create a one-to-many relationship between Routes.route_id and Passengers_on_flights.route_id.
Routes - Ticket_details:
	This relationship is indirect through the aircraft and flight number, but for simplicity, you can create an indirect relationship through aircraft_id.

Steps in MySQL Workbench:
Adding Tables:
	Click on the Add Table button (table icon) and place the table on the diagram.
	Double-click the table to open the editor and add columns.
	Define the data types for each column (e.g., INT, VARCHAR, DATE).

Defining Primary Keys:
	In the table editor, select the column and check the PK checkbox to set it as the primary key.

Defining Foreign Keys:
	In the table editor, go to the Foreign Keys tab.
	Add a new foreign key, specify the column, and set the referenced table and column.

Creating Relationships:
	Use the Place a Relationship tools (one-to-many and many-to-many) to draw lines between related tables.
	Click on a primary key in one table and drag to the foreign key in another table to create the relationship.
*/

/* 2.  Write a query to create route_details table using suitable data types for the fields, such as route_id, 
flight_num, origin_airport, destination_airport, aircraft_id, and distance_miles. Implement the check constraint 
for the flight number and unique constraint for the route_id fields. Also, make sure that the distance miles field is greater than 0. */

create database aircargo;
 
use aircargo;
 
create table if not exists customer(
	customer_id int not null auto_increment primary key,
    first_name varchar(20) not null,
    last_name varchar(20) not null,
    date_of_birth date not null,
    gender char(1) not null
    );

 
-- Preprocess the data: change date format in the CSV file (12-01-1989), to the standard MySQL date format (YYYY-MM-DD).
-- Load data into customer and validate the data 

describe customer;
select * from customer;
    
create table if not exists routes(
	route_id int not null unique primary key,
	flight_num int constraint chk_1 check (flight_num is not null),
	origin_airport char(3) not null,
	destination_airport char(3) not null,
	aircraft_id varchar(10) not null,
	distance_miles int not null constraint check_2 check (distance_miles > 0) );

-- Load data into routes and validate the data         
select * from routes;
    
create  table if not exists passengers_on_flights(
    passengers_on_flights_id int auto_increment primary key,
    customer_id int not null,
    aircraft_id varchar(10) not null,
    route_id int not null,
    depart char(3) not null,
    arrival char(3) not null,
    seat_num char(4) not null,
    class_id varchar(15) not null,
    travel_date date not null,
    flight_num int not null,
    constraint fk_passengers_on_flights foreign key (customer_id) references customer(customer_id)
    );

-- Preprocess the data: change date format in the CSV file (12-01-1989), to the standard MySQL date format (YYYY-MM-DD).
-- Load data into passengers_on_flights and validate the data         
select * from passengers_on_flights;
         
create table if not exists ticket_details(
	tkt_id int auto_increment primary key,
    p_date date not null,
    customer_id int not null,
    aircraft_id varchar(10) not null,
    class_id varchar(15) not null,
    no_of_tkts int not null,
    a_code char(3) not null,
    price_per_tkt decimal(5,2) not null,
    brand varchar(30) not null,
    constraint fk_tkt_dts foreign key (customer_id) references customer(customer_id)
    );

-- Preprocess the data: change date format in the CSV file (12-01-1989), to the standard MySQL date format (YYYY-MM-DD).
-- Select appropriate columns to be inserted into the respective columns in the table accordingly while loading the data
-- Load data into passengers_on_flights and validate the data 
select * from ticket_details;
         
 /* 3.  Write a query to display all the passengers (customers) who have travelled in routes 01 to 25. 
Take data from the passengers_on_flights table. */        
         
select * from customer 
where customer_id in (select distinct customer_id from passengers_on_flights where route_id between 1 and 25) 
order by customer_id;
    
 /* 4.  Write a query to identify the number of passengers and total revenue in business class from the ticket_details table. */   

select count(distinct customer_id) as num_passgengers, sum(no_of_tkts * price_per_tkt) as total_revenue
from ticket_details
where class_id = "BUSSINESS";

/* 5.  Write a query to display the full name of the customer by extracting the first name and last name from the customer table.*/

SELECT CONCAT(first_name," ",last_name ) as full_name from customer;

/* 6.  Write a query to extract the customers who have registered and booked a ticket. Use data from 
the customer and ticket_details tables.*/

select first_name, Last_name  from customer 
where customer_id in (select distinct b.customer_id from customer a, ticket_details b);

/* 7.  Write a query to identify the customer’s first name and last name based on their customer ID 
and brand (Emirates) from the ticket_details table. */

select first_name, Last_name  from customer 
where customer_id in (select distinct customer_id from ticket_details where brand = 'Emirates');

/* 8. Write a query to identify the customers who have travelled by Economy Plus class using Group By
 and Having clause on the passengers_on_flights table. */
 
 /*
 select class_id, count(distinct customer_id) as num_passengers 
 from passengers_on_flights group by class_id having class_id = 'Economy Plus';
 */
 
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.date_of_birth,
    c.gender
FROM
    customer c
INNER JOIN (
    SELECT
        customer_id
    FROM
        passengers_on_flights
    WHERE
        class_id = 'Economy Plus'
    GROUP BY
        customer_id
    HAVING
        COUNT(*) > 0
) p
ON c.customer_id = p.customer_id;


/*
 select * from customer a
 inner join (select distinct customer_id from passengers_on_flights where class_id = 'Economy Plus') b
 on a.customer_id = b.customer_id;
*/
 /* 9.  Write a query to identify whether the revenue has crossed 10000 using the IF clause on the ticket_details table. */
 
select if ((select sum(no_of_tkts * price_per_tkt) as total_revenue from ticket_details)> 10000, 'Crossed 10K', 'Not Crossed 10K') as revenue_check;
 
 /* 10.  Write a query to create and grant access to a new user to perform operations on a database. */
 
 create user if not exists 'john'@'127.0.0.1' identified by 'Password1234';
 grant all privileges on aircargo to john@127.0.0.1 ;
 
 /* 11.  Write a query to find the maximum ticket price for each class using window functions on the ticket_details table. */
 
 select class_id, max(price_per_tkt) 
 from ticket_details 
 group by class_id;
 
/* 
select distinct class_id, max(price_per_tkt) over (partition by class_id) as max_price 
 from ticket_details 
 order by max_price; 
 */
 
 /* 12.  Write a query to extract the passengers whose route ID is 4 by improving the speed 
 and performance of the passengers_on_flights table. */
 
 create index idx_rid on passengers_on_flights (route_id);
 explain select * from passengers_on_flights where route_id = 4;
 
 /*13. For the route ID 4, write a query to view the execution plan of the passengers_on_flights table.*/
 
 explain select * from passengers_on_flights where route_id = 4;
 
 /* 14. Write a query to calculate the total price of all tickets booked by a customer across different aircraft IDs using rollup function. */
 
/* 
SELECT customer_id, aircraft_id,
    SUM(price_per_tkt * no_of_tkts) AS total_price
FROM ticket_details
GROUP BY customer_id , aircraft_id
ORDER BY customer_id , aircraft_id;
 */
 
SELECT customer_id, aircraft_id,
    SUM(price_per_tkt * no_of_tkts) AS total_price
FROM ticket_details
GROUP BY customer_id , aircraft_id
WITH ROLLUP ORDER BY customer_id , aircraft_id;
 
 
 /* 15. Write a query to create a view with only business class customers along with the brand of airlines. */
 
 create view buss_class_customers as
 select a.*, b.brand from customer a
 inner join (select distinct customer_id, brand from ticket_details where class_id = 'Bussiness' order by customer_id) b
 on a.customer_id = b.customer_id;
 
 select * from buss_class_customers;
 
 
 /* 16.  Write a query to create a stored procedure to get the details of all passengers flying between a range of routes defined in run time.
 Also, return an error message if the table doesn't exist. */
 
 -- select * from customer where customer_id in (select distinct customer_id from passengers_on_flights where route_id in (1,5));
 
 delimiter //
 create procedure check_route (in rid varchar(255))
 begin
	declare TableNotFound condition for 1146;
    declare exit handler for TableNotFound
		select 'Please check if table customer/route id are created - onr/both are missing' Message;
        set @query = concat('select * from customer where customer_id in ( select distinct customer_id from passengers_on_flights where route_id in (',rid,'));');
        prepare sql_query from@query;
        execute sql_query;
        end//
        delimiter ;
        call check_route("1,5");
        
        
/*17.  Write a query to create a stored procedure that extracts all the details from the routes table where the travelled distance is more than 2000 miles.*/

delimiter //
create procedure check_dist()
begin
	select * from routes where distance_miles > 2000;
    end //
    delimiter ;
    
    call check_dist;

/*18. Write a query to create a stored procedure that groups the distance travelled by each flight into three categories.
 The categories are, short distance travel (SDT) for >=0 AND <= 2000 miles, intermediate distance travel (IDT) for >2000 AND <=6500, 
 and long-distance travel (LDT) for >6500.*/

DELIMITER //

CREATE PROCEDURE categorize_flight_distances()
BEGIN
    SELECT 
        flight_num,
        aircraft_id,
        route_id,
        distance_miles,
        CASE
            WHEN distance_miles BETWEEN 0 AND 2000 THEN 'SDT'
            WHEN distance_miles > 2000 AND distance_miles <= 6500 THEN 'IDT'
            WHEN distance_miles > 6500 THEN 'LDT'
            ELSE 'Unknown'
        END AS distance_category
    FROM routes;
END //

DELIMITER ;


CALL categorize_flight_distances();

/* 19. Write a query to extract ticket purchase date, customer ID, class ID and specify if the complimentary services 
are provided for the specific class using a stored function in stored procedure on the ticket_details table. 
Condition:
	If the class is Business and Economy Plus, then complimentary services are given as Yes, else it is No
*/

/*
select p_date, customer_id, class_id, case
										when class_id in ('Bussiness','Economy Plus') then "Yes"
										else "No"
										end as complimentary_service from ticket_details;

*/

DELIMITER //
CREATE FUNCTION check_complimentary_services(class VARCHAR(15))
RETURNS VARCHAR(3)
DETERMINISTIC
BEGIN
    RETURN CASE
        WHEN class = 'Business' OR class = 'Economy Plus' THEN 'Yes'
        ELSE 'No'
    END;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE get_ticket_details_with_complimentary()
BEGIN
    SELECT 
        p_date AS ticket_purchase_date,
        customer_id,
        class_id,
        check_complimentary_services(class_id) AS complimentary_services
    FROM 
        ticket_details;
END //
DELIMITER ;

CALL get_ticket_details_with_complimentary();

/* 20. Write a query to extract the first record of the customer whose last name ends with Scott using a cursor from the customer table. */

-- select * from customer where last_name = 'Scott' limit 1;

delimiter //
create procedure cust_lname_Scott()
begin
	declare c_id int;
    declare f_name varchar (20);
    declare l_name varchar(20);
    declare dob date;
    declare gen char(1);
    declare cust_rec cursor 
    for
    select * from customer where last_name = "Scott";
    create table if not exists cursor_table(
		c_id int,
        f_name varchar(20),
        l_name varchar(20),
        dob date,
        gen char (1) );
    open cust_rec;
    fetch cust_rec into c_id, f_name, l_name, dob, gen;
    insert into cursor_table(c_id, f_name, l_name, dob, gen) values (c_id, f_name, l_name, dob, gen);
    close cust_rec;

    select * from cursor_table;
end //
delimiter ;
call cust_lname_scott();