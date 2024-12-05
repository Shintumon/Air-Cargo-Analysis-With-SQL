# Air Cargo Analysis Project

## Overview

The **Air Cargo** project involves developing a database system to manage various aspects of an aviation company that provides air transportation services for both passengers and freight. The company operates with partnerships and alliances with other airlines to provide various services, such as identifying regular passengers, analyzing the busiest routes, and tracking ticket sales.

This project involves several tasks including creating an ER diagram, performing SQL queries, and writing stored procedures to assist the company in improving its operations, enhancing customer service, and optimizing its offerings.

## Problem Statement

The company wants to generate reports on:

- **Regular passengers** for targeted offers
- **Busiest routes** to increase the number of aircraft
- **Ticket sales details** for better operational insights

As a **DBA Expert**, you are responsible for:

- Identifying regular customers to offer promotions
- Analyzing busy routes and aircraft requirements
- Performing detailed analysis on ticket sales data

## Project Objective

You will focus on:

- Creating tables, queries, and stored procedures for tracking passengers, routes, and ticket sales.
- Making sure the system becomes more customer-centric, improving the company’s operability, and positioning it as a favorable choice for air travel.

## Tasks Performed

1. **Database Design & ER Diagram**
   - Developed an ER diagram for the airlines database, illustrating relationships between tables such as `customers`, `routes`, `ticket_details`, and `passengers_on_flights`.

2. **SQL Queries and Operations**
   - **Route Details Table Creation**: Wrote a query to create the `route_details` table with constraints like `check`, `unique`, and validation for `distance_miles`.
   - **Passenger Query**: Retrieved data for passengers who traveled on routes 01 to 25.
   - **Ticket Sales Analysis**: Identified the number of passengers and the total revenue for business class tickets.
   - **Customer Full Name Query**: Extracted the full name (first and last name) of customers from the `customer` table.
   - **Customer and Ticket Data**: Extracted customers who registered and booked tickets.
   - **Emirates Customer Identification**: Identified passengers who traveled with Emirates.
   - **Travel Class Analysis**: Extracted customers who traveled by Economy Plus class.
   - **Revenue Analysis**: Used an `IF` clause to check if total revenue exceeded 10,000.

3. **Stored Procedures & Functions**
   - Created stored procedures to extract details for passengers flying between a range of routes, with error handling for missing tables.
   - Developed procedures for:
     - Extracting route details with distances greater than 2000 miles.
     - Categorizing flights into short, intermediate, and long-distance categories.
     - Determining complimentary services for business and economy plus classes.
   - **Stored Function**: Used a function to check complimentary services based on the class type.

4. **Performance Optimizations**
   - Optimized queries for better performance, especially for high-load queries like extracting passengers based on route ID 4.
   - Analyzed execution plans for complex queries to ensure efficiency.

5. **Other SQL Operations**
   - Used window functions to find the maximum ticket price for each class.
   - Used the `ROLLUP` function to calculate the total price of all tickets booked by a customer.
   - Created views to filter business class customers.
   - Created a cursor to extract the first record of a customer with the last name “Scott”.
