-- Hotel Booking System Database
-- Created based on ER Diagram

-- Create Database
CREATE DATABASE IF NOT EXISTS hotel_booking_system;
USE hotel_booking_system;

-- Drop tables if they exist (in reverse order of dependencies)
DROP TABLE IF EXISTS Booking;
DROP TABLE IF EXISTS Customer_Phone;
DROP TABLE IF EXISTS Room;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Hotel;

-- Create Hotel Table
CREATE TABLE Hotel (
    Hotel_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Star_Rating INT CHECK (Star_Rating BETWEEN 1 AND 5),
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create Customer Table
CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create Customer_Phone Table (for multi-valued Phone attribute)
CREATE TABLE Customer_Phone (
    Phone_ID INT PRIMARY KEY AUTO_INCREMENT,
    FK_Customer_ID INT NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Phone_Type VARCHAR(20) DEFAULT 'Primary', -- e.g., Primary, Secondary, Mobile, Work
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (FK_Customer_ID) REFERENCES Customer(Customer_ID) ON DELETE CASCADE,
    UNIQUE KEY unique_customer_phone (FK_Customer_ID, Phone)
);

-- Create Room Table
CREATE TABLE Room (
    Room_ID INT PRIMARY KEY AUTO_INCREMENT,
    Type VARCHAR(50) NOT NULL, -- e.g., Single, Double, Suite, Deluxe
    Price DECIMAL(10, 2) NOT NULL CHECK (Price >= 0),
    Status VARCHAR(20) DEFAULT 'Available', -- Available, Occupied, Maintenance
    FK_Hotel_ID INT NOT NULL,
    Room_Number VARCHAR(10),
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (FK_Hotel_ID) REFERENCES Hotel(Hotel_ID) ON DELETE CASCADE,
    INDEX idx_hotel (FK_Hotel_ID),
    INDEX idx_status (Status)
);

-- Create Booking Table
CREATE TABLE Booking (
    Booking_ID INT PRIMARY KEY AUTO_INCREMENT,
    Check_in DATE NOT NULL,
    Check_out DATE NOT NULL,
    Status VARCHAR(20) DEFAULT 'Pending', -- Pending, Confirmed, Checked-in, Checked-out, Cancelled
    FK_Customer_ID INT NOT NULL,
    FK_Room_ID INT NOT NULL,
    Total_Amount DECIMAL(10, 2),
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (FK_Customer_ID) REFERENCES Customer(Customer_ID) ON DELETE CASCADE,
    FOREIGN KEY (FK_Room_ID) REFERENCES Room(Room_ID) ON DELETE CASCADE,
    INDEX idx_customer (FK_Customer_ID),
    INDEX idx_room (FK_Room_ID),
    INDEX idx_dates (Check_in, Check_out),
    CONSTRAINT chk_dates CHECK (Check_out > Check_in)
);

-- Create indexes for better query performance
CREATE INDEX idx_hotel_name ON Hotel(Name);
CREATE INDEX idx_customer_email ON Customer(Email);
CREATE INDEX idx_booking_status ON Booking(Status);

