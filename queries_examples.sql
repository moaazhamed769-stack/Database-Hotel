-- Example Queries for Hotel Booking System
USE hotel_booking_system;

-- 1. List all hotels with their star ratings
SELECT Hotel_ID, Name, Address, Star_Rating 
FROM Hotel 
ORDER BY Star_Rating DESC, Name;

-- 2. Find all customers with their phone numbers
SELECT 
    c.Customer_ID,
    c.Name,
    c.Email,
    GROUP_CONCAT(cp.Phone ORDER BY cp.Phone_Type SEPARATOR ', ') AS Phone_Numbers
FROM Customer c
LEFT JOIN Customer_Phone cp ON c.Customer_ID = cp.FK_Customer_ID
GROUP BY c.Customer_ID, c.Name, c.Email;

-- 3. List all rooms for a specific hotel
SELECT 
    r.Room_ID,
    r.Room_Number,
    r.Type,
    r.Price,
    r.Status,
    h.Name AS Hotel_Name
FROM Room r
JOIN Hotel h ON r.FK_Hotel_ID = h.Hotel_ID
WHERE h.Hotel_ID = 1
ORDER BY r.Room_Number;

-- 4. Find all available rooms
SELECT 
    r.Room_ID,
    r.Room_Number,
    r.Type,
    r.Price,
    h.Name AS Hotel_Name,
    h.Address
FROM Room r
JOIN Hotel h ON r.FK_Hotel_ID = h.Hotel_ID
WHERE r.Status = 'Available'
ORDER BY h.Name, r.Price;

-- 5. Show all bookings with customer and room details
SELECT 
    b.Booking_ID,
    c.Name AS Customer_Name,
    c.Email AS Customer_Email,
    h.Name AS Hotel_Name,
    r.Room_Number,
    r.Type AS Room_Type,
    b.Check_in,
    b.Check_out,
    DATEDIFF(b.Check_out, b.Check_in) AS Nights,
    b.Total_Amount,
    b.Status AS Booking_Status
FROM Booking b
JOIN Customer c ON b.FK_Customer_ID = c.Customer_ID
JOIN Room r ON b.FK_Room_ID = r.Room_ID
JOIN Hotel h ON r.FK_Hotel_ID = h.Hotel_ID
ORDER BY b.Check_in DESC;

-- 6. Find bookings for a specific customer
SELECT 
    b.Booking_ID,
    h.Name AS Hotel_Name,
    r.Room_Number,
    r.Type AS Room_Type,
    b.Check_in,
    b.Check_out,
    b.Total_Amount,
    b.Status
FROM Booking b
JOIN Room r ON b.FK_Room_ID = r.Room_ID
JOIN Hotel h ON r.FK_Hotel_ID = h.Hotel_ID
WHERE b.FK_Customer_ID = 1
ORDER BY b.Check_in DESC;

-- 7. Calculate total revenue by hotel
SELECT 
    h.Name AS Hotel_Name,
    COUNT(b.Booking_ID) AS Total_Bookings,
    COALESCE(SUM(b.Total_Amount), 0) AS Total_Revenue
FROM Hotel h
LEFT JOIN Room r ON h.Hotel_ID = r.FK_Hotel_ID
LEFT JOIN Booking b ON r.Room_ID = b.FK_Room_ID AND b.Status IN ('Confirmed', 'Checked-in', 'Checked-out')
GROUP BY h.Hotel_ID, h.Name
ORDER BY Total_Revenue DESC;

-- 8. Find rooms that are currently occupied
SELECT 
    h.Name AS Hotel_Name,
    r.Room_Number,
    r.Type,
    c.Name AS Customer_Name,
    b.Check_in,
    b.Check_out,
    b.Status
FROM Room r
JOIN Hotel h ON r.FK_Hotel_ID = h.Hotel_ID
JOIN Booking b ON r.Room_ID = b.FK_Room_ID
JOIN Customer c ON b.FK_Customer_ID = c.Customer_ID
WHERE r.Status = 'Occupied' 
  AND b.Status IN ('Checked-in', 'Confirmed')
  AND CURDATE() BETWEEN b.Check_in AND b.Check_out;

-- 9. List all 5-star hotels with their room counts
SELECT 
    h.Name,
    h.Address,
    COUNT(r.Room_ID) AS Total_Rooms,
    COUNT(CASE WHEN r.Status = 'Available' THEN 1 END) AS Available_Rooms
FROM Hotel h
LEFT JOIN Room r ON h.Hotel_ID = r.FK_Hotel_ID
WHERE h.Star_Rating = 5
GROUP BY h.Hotel_ID, h.Name, h.Address;

-- 10. Find customers who have multiple bookings
SELECT 
    c.Customer_ID,
    c.Name,
    c.Email,
    COUNT(b.Booking_ID) AS Booking_Count,
    SUM(b.Total_Amount) AS Total_Spent
FROM Customer c
JOIN Booking b ON c.Customer_ID = b.FK_Customer_ID
GROUP BY c.Customer_ID, c.Name, c.Email
HAVING COUNT(b.Booking_ID) > 1
ORDER BY Booking_Count DESC, Total_Spent DESC;

