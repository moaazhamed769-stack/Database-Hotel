# Hotel Booking System - MySQL Database

This project contains a MySQL database schema for a hotel booking system based on an Entity-Relationship (ER) diagram.

## Database Structure

The database consists of the following tables:

### 1. **Hotel**
- `Hotel_ID` (Primary Key)
- `Name`
- `Address`
- `Star_Rating` (1-5 stars)
- Timestamps for tracking creation and updates

### 2. **Customer**
- `Customer_ID` (Primary Key)
- `Name`
- `Email` (Unique)
- Timestamps for tracking creation and updates

### 3. **Customer_Phone**
- `Phone_ID` (Primary Key)
- `FK_Customer_ID` (Foreign Key → Customer)
- `Phone` (Multi-valued attribute)
- `Phone_Type` (Primary, Secondary, Mobile, Work, etc.)

### 4. **Room**
- `Room_ID` (Primary Key)
- `Type` (Single, Double, Suite, Deluxe, etc.)
- `Price`
- `Status` (Available, Occupied, Maintenance)
- `FK_Hotel_ID` (Foreign Key → Hotel)
- `Room_Number`
- Timestamps for tracking creation and updates

### 5. **Booking**
- `Booking_ID` (Primary Key)
- `Check_in` (Date)
- `Check_out` (Date)
- `Status` (Pending, Confirmed, Checked-in, Checked-out, Cancelled)
- `FK_Customer_ID` (Foreign Key → Customer)
- `FK_Room_ID` (Foreign Key → Room)
- `Total_Amount`
- Timestamps for tracking creation and updates

## Relationships

1. **Hotel → Room**: One-to-Many (One hotel contains many rooms)
2. **Customer → Booking**: One-to-Many (One customer makes many bookings)
3. **Room → Booking**: One-to-Many (One room can have many bookings over time)

## Installation & Setup

### Prerequisites
- MySQL Server installed and running
- MySQL Command Line Client or MySQL Workbench

### Steps

1. **Create the database and tables:**
   ```bash
   mysql -u root -p < create_database.sql
   ```

2. **Insert sample data (optional):**
   ```bash
   mysql -u root -p < insert_sample_data.sql
   ```

3. **Run example queries:**
   ```bash
   mysql -u root -p < queries_examples.sql
   ```

   Or open `queries_examples.sql` in MySQL Workbench and run individual queries.

## Files Description

- **create_database.sql**: Main script to create the database schema with all tables, foreign keys, indexes, and constraints
- **insert_sample_data.sql**: Sample data for testing and demonstration
- **queries_examples.sql**: Example SQL queries demonstrating various operations on the database
- **README.md**: This file

## Key Features

- ✅ Proper foreign key relationships with CASCADE delete
- ✅ Multi-valued attribute handling (Customer Phone numbers)
- ✅ Data validation constraints (check constraints for dates, prices, ratings)
- ✅ Indexes for improved query performance
- ✅ Timestamps for audit trails
- ✅ Unique constraints where appropriate

## Example Queries

### Find all available rooms:
```sql
SELECT r.*, h.Name AS Hotel_Name
FROM Room r
JOIN Hotel h ON r.FK_Hotel_ID = h.Hotel_ID
WHERE r.Status = 'Available';
```

### View customer bookings:
```sql
SELECT c.Name, b.Check_in, b.Check_out, h.Name AS Hotel
FROM Booking b
JOIN Customer c ON b.FK_Customer_ID = c.Customer_ID
JOIN Room r ON b.FK_Room_ID = r.Room_ID
JOIN Hotel h ON r.FK_Hotel_ID = h.Hotel_ID;
```

## Notes

- The `Customer_Phone` table handles the multi-valued `Phone` attribute from the ER diagram
- All foreign keys use `ON DELETE CASCADE` to maintain referential integrity
- Date validation ensures `Check_out` is always after `Check_in`
- Room prices and star ratings have appropriate constraints

