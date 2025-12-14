-- Sample Data for Hotel Booking System
USE hotel_booking_system;

-- Insert Hotels
INSERT INTO Hotel (Name, Address, Star_Rating) VALUES
('Grand Plaza Hotel', '123 Main Street, New York, NY 10001', 5),
('Ocean View Resort', '456 Beach Boulevard, Miami, FL 33139', 4),
('Mountain Lodge', '789 Hill Road, Denver, CO 80202', 3),
('City Center Inn', '321 Downtown Avenue, Chicago, IL 60601', 3),
('Luxury Suites', '654 Premium Drive, Los Angeles, CA 90001', 5);

-- Insert Customers
INSERT INTO Customer (Name, Email) VALUES
('John Smith', 'john.smith@email.com'),
('Emily Johnson', 'emily.j@email.com'),
('Michael Brown', 'michael.brown@email.com'),
('Sarah Davis', 'sarah.davis@email.com'),
('David Wilson', 'david.wilson@email.com'),
('Lisa Anderson', 'lisa.anderson@email.com');

-- Insert Customer Phones (multi-valued attribute)
INSERT INTO Customer_Phone (FK_Customer_ID, Phone, Phone_Type) VALUES
(1, '555-0101', 'Primary'),
(1, '555-0102', 'Mobile'),
(2, '555-0201', 'Primary'),
(3, '555-0301', 'Primary'),
(3, '555-0302', 'Work'),
(4, '555-0401', 'Primary'),
(5, '555-0501', 'Primary'),
(5, '555-0502', 'Mobile'),
(6, '555-0601', 'Primary');

-- Insert Rooms
INSERT INTO Room (Type, Price, Status, FK_Hotel_ID, Room_Number) VALUES
-- Grand Plaza Hotel (Hotel_ID = 1)
('Deluxe Suite', 299.99, 'Available', 1, '101'),
('Standard Room', 149.99, 'Available', 1, '102'),
('Deluxe Suite', 299.99, 'Occupied', 1, '103'),
('Standard Room', 149.99, 'Available', 1, '104'),
('Presidential Suite', 599.99, 'Available', 1, '201'),

-- Ocean View Resort (Hotel_ID = 2)
('Ocean View', 249.99, 'Available', 2, '101'),
('Standard Room', 129.99, 'Available', 2, '102'),
('Ocean View', 249.99, 'Available', 2, '103'),
('Beachfront Suite', 399.99, 'Occupied', 2, '201'),

-- Mountain Lodge (Hotel_ID = 3)
('Cabin', 99.99, 'Available', 3, 'C1'),
('Standard Room', 79.99, 'Available', 3, '101'),
('Cabin', 99.99, 'Maintenance', 3, 'C2'),
('Standard Room', 79.99, 'Available', 3, '102'),

-- City Center Inn (Hotel_ID = 4)
('Standard Room', 89.99, 'Available', 4, '101'),
('Standard Room', 89.99, 'Available', 4, '102'),
('Double Room', 119.99, 'Available', 4, '201'),

-- Luxury Suites (Hotel_ID = 5)
('Penthouse', 799.99, 'Available', 5, 'PH1'),
('Executive Suite', 449.99, 'Available', 5, 'ES1'),
('Executive Suite', 449.99, 'Occupied', 5, 'ES2');

-- Insert Bookings
INSERT INTO Booking (Check_in, Check_out, Status, FK_Customer_ID, FK_Room_ID, Total_Amount) VALUES
('2024-01-15', '2024-01-18', 'Confirmed', 1, 3, 899.97),
('2024-02-01', '2024-02-05', 'Pending', 2, 9, 399.96),
('2024-01-20', '2024-01-22', 'Checked-in', 3, 4, 299.98),
('2024-03-10', '2024-03-15', 'Pending', 4, 6, 1249.95),
('2024-02-10', '2024-02-12', 'Confirmed', 5, 18, 899.98),
('2024-01-25', '2024-01-27', 'Checked-out', 6, 11, 159.98),
('2024-02-20', '2024-02-25', 'Pending', 1, 1, 1499.95),
('2024-03-01', '2024-03-03', 'Confirmed', 2, 7, 499.98);

