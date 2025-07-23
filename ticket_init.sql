CREATE DATABASE TICKETBOOKINGSYSTEM;
USE TICKETBOOKINGSYSTEM;
-- Creating tables
CREATE TABLE Customer (
  `customer_ID` varchar(200) NOT NULL,
  `fname` varchar(45) NOT NULL,
  `lname` varchar(45) NOT NULL,
  `DOB` date NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(100) NOT NULL,
  PRIMARY KEY (`customer_ID`)
);

CREATE TABLE eventLocation (
  `eventLocation_ID` varchar(45) NOT NULL,
  `eventLocationName` varchar(100) NOT NULL,
  PRIMARY KEY (`eventLocation_ID`)
);

CREATE TABLE Event_ (
  `event_ID` varchar(200) NOT NULL,
  `eventLocation_ID` varchar(45) NOT NULL,
  `eventName` varchar(100) NOT NULL,
  `eventType` varchar(45) NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date NOT NULL,
  `startTime` time NOT NULL,
  `endTime` time NOT NULL,
  `eventDuration` decimal(8,2) NOT NULL,
  `eventDescription` varchar(250) NOT NULL,
  `totalTickets` int NOT NULL,
  PRIMARY KEY (`event_ID`),
  KEY `eventLocation_ID` (`eventLocation_ID`),
  CONSTRAINT `FK_EventLocation_ID` FOREIGN KEY (`eventLocation_ID`) REFERENCES `eventLocation` (`eventLocation_ID`)
);

CREATE TABLE Booking (
  `booking_ID` varchar(100) NOT NULL,
  `paymentStatus` tinyint NOT NULL,
  `numOfTickets` int NOT NULL,
  `cost` decimal(10,2) NOT NULL,
  `bookingQuantity` int NOT NULL,
  `event_ID` varchar(200) NOT NULL,
  `customer_ID` varchar(200) NOT NULL,
  PRIMARY KEY (`booking_ID`),
  KEY `FK_Customer_ID` (`customer_ID`),
  KEY `FK_Event_ID` (`event_ID`),
  CONSTRAINT `FK_Customer_ID` FOREIGN KEY (`customer_ID`) REFERENCES `Customer` (`customer_ID`),
  CONSTRAINT `FK_Event_ID` FOREIGN KEY (`event_ID`) REFERENCES `Event_` (`event_ID`)
);

CREATE TABLE voucherCode (
  `voucherCode_ID` varchar(200) NOT NULL,
  `uniqueCode` varchar(100) NOT NULL,
  `discount` decimal(4,3) NOT NULL,
  `isActive` tinyint(1) NOT NULL,
  `event_ID` varchar(200) NOT NULL,
  PRIMARY KEY (`voucherCode_ID`),
  KEY `FK_EventVC_ID` (`event_ID`),
  CONSTRAINT `FK_EventVC_ID` FOREIGN KEY (`event_ID`) REFERENCES `Event_` (`event_ID`)
);

CREATE TABLE Payment (
  `payment_ID` varchar(200) NOT NULL,
  `booking_ID` varchar(200) NOT NULL,
  `customer_ID` varchar(200) NOT NULL,
  `cardType` varchar(20) NOT NULL,
  `cardNo` bigint NOT NULL,
  `cardCVC` int NOT NULL,
  `expiryDate` date NOT NULL,
  `voucherCode_ID` varchar(200) DEFAULT NULL,
  `finalCost` decimal(10,2) NOT NULL,
  `paymentDate` date DEFAULT NULL,
  PRIMARY KEY (`payment_ID`),
  KEY `FK_BookingP_ID` (`booking_ID`),
  KEY `FK_CustomerP_ID` (`customer_ID`),
  KEY `FK_VoucherCode_ID` (`voucherCode_ID`),
  CONSTRAINT `FK_BookingP_ID` FOREIGN KEY (`booking_ID`) REFERENCES `Booking` (`booking_ID`),
  CONSTRAINT `FK_CustomerP_ID` FOREIGN KEY (`customer_ID`) REFERENCES `Customer` (`customer_ID`),
  CONSTRAINT `FK_VoucherCode_ID` FOREIGN KEY (`voucherCode_ID`) REFERENCES `voucherCode` (`voucherCode_ID`)
);

CREATE TABLE ticketDelivery (
  `ticketDelivery_ID` varchar(200) NOT NULL,
  `booking_ID` varchar(200) NOT NULL,
  `emailDelivery` tinyint(1) NOT NULL,
  `pickUp` tinyint(1) NOT NULL,
  PRIMARY KEY (`ticketDelivery_ID`),
  KEY `FK_Booking_ID` (`booking_ID`),
  CONSTRAINT `FK_Booking_ID` FOREIGN KEY (`booking_ID`) REFERENCES `Booking` (`booking_ID`)
);

CREATE TABLE ticketType (
  `ticketType_ID` varchar(200) NOT NULL,
  `event_ID` varchar(200) NOT NULL,
  `ticketTypeName` varchar(150) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `ticketTypeQuantity` int NOT NULL,
  PRIMARY KEY (`ticketType_ID`),
  KEY `FK_EventTT_ID` (`event_ID`),
  CONSTRAINT `FK_EventTT_ID` FOREIGN KEY (`event_ID`) REFERENCES `Event_` (`event_ID`)
);

CREATE TABLE Ticket (
  `ticket_ID` varchar(200) NOT NULL,
  `booking_ID` varchar(200) NOT NULL,
  `ticketType_ID` varchar(200) NOT NULL,
  `ticketQuantity` int NOT NULL,
  PRIMARY KEY (`ticket_ID`),
  KEY `FK_BookingT_ID` (`booking_ID`),
  KEY `FK_TicketType_ID` (`ticketType_ID`),
  CONSTRAINT `FK_BookingT_ID` FOREIGN KEY (`booking_ID`) REFERENCES `Booking` (`booking_ID`),
  CONSTRAINT `FK_TicketType_ID` FOREIGN KEY (`ticketType_ID`) REFERENCES `ticketType` (`ticketType_ID`)
);

CREATE TABLE bookingCancellation (
  `bookingCancellation_ID` varchar(200) NOT NULL,
  `booking_ID` varchar(200) DEFAULT NULL,
  `cancellationDate` date DEFAULT NULL,
  `refundStatus` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`bookingCancellation_ID`),
  KEY `FK_BookingBK_ID` (`booking_ID`),
  CONSTRAINT `FK_BookingBK_ID` FOREIGN KEY (`booking_ID`) REFERENCES `Booking` (`booking_ID`)
);
-- Populating tables with sufficient data
INSERT INTO eventLocation (eventLocation_ID, eventLocationName)
VALUES 
    ('EX4-3SA','Northernhay Gardens'),
    ('EX8-1NZ','Manor Gardens'),
    ('EX1-1HS','Exeter Cathedral');

INSERT INTO Event_ (event_ID, eventLocation_ID, eventName, eventType, startDate, endDate, startTime, endTime, eventDuration, eventDescription, totalTickets)
VALUES 
    ('EFF23', 'EX4-3SA', 'EXETER FOOD FESTIVAL 2023', 'Food', '2023-05-08', '2023-05-10','10:00','17:00',55,'An outdoor food event held in the centre of the thriving town of Exeter',300),
    ('EXMF23', 'EX8-1NZ','EXMOUTH MUSIC FESTIVAL 2023', 'Music', '2023-07-28','2023-07-31', '9:00:00','18:30:00',153.5,'One of the most popular music festivals in the south west',2000),
    ('EXCF', 'EX1-1HS','EXETER CRAFT FESTIVAL 2023', 'Art', '2023-07-04','2023-07-06', '9:30:00','18:00:00',105,'An annual gathering to celebrate arts and crafts',500);

INSERT INTO ticketType (ticketType_ID, event_ID, ticketTypeName, price, ticketTypeQuantity)
VALUES 
    ('EFF23ADULT', 'EFF23', 'ADULT 16+', 10.00, 200),
    ('EFF23CHILD', 'EFF23', 'CHILD 5-15', 5.00, 100),
	('EXMF23G','EXMF23', 'GOLD', 50.00, 200),
    ('EXMF23S','EXMF23', 'SILVER', 25.00, 200),
    ('EXMF23B','EXMF23', 'BRONZE', 10.00, 600),
    ('EXCFVIP', 'EXCF', 'VIP', 20.00, 50),
    ('EXCFS', 'EXCF', 'STANDARD', 5.00, 450);

INSERT INTO Customer (customer_ID, fname, lname, DOB, email, phone)
VALUES 
    ('C1','James','Smith','2000-02-08','jamessmith@gmail.com','07398543277'),
    ('C2','Irene','Baker','1984-10-21','irenebaker@gmail.com','07864328977'),
    ('C3','Mark','Cole','1998-07-25','markcole@gmail.com','07942312422'),
    ('C4', 'Joe', 'Smiths', '1987-12-02', 'joesmiths@gmail.com', '07788993244');

INSERT INTO Booking (booking_ID, paymentStatus, numOfTickets, cost, bookingQuantity, event_ID, customer_ID)
VALUES 
    ('B1',1,2,100.00,1,'EXMF23','C1'),
    ('B2',0,3,25.00,1,'EFF23','C2'),
    ('B3',1,1,10.00,1,'EXMF23','C2'),
    ('B4',1,5,25.00,1,'EXCF','C3'),
    ('B5',1,1,25.00,1,'EXMF23', 'C4');

INSERT INTO Ticket (ticket_ID, booking_ID, ticketType_ID, ticketQuantity)
VALUES 
	('T1','B1','EXMF23G',2),
    ('T2','B2','EFF23ADULT',2),
    ('T3','B2','EFF23CHILD',1),
    ('T4','B3','EXMF23B',1),
    ('T5','B4','EXCFS',5),
    ('T6','B5','EXMF23S',1);

INSERT INTO voucherCode(voucherCode_ID,uniqueCode,discount,isActive,event_ID)
VALUES
	('V1','10OFF',0.10,1,'EFF23'),
    ('V2', '50OFF',0.5,1,'EXMF23');

INSERT INTO Payment (Payment_ID, booking_ID, customer_ID, cardType,cardNo,cardCVC,expiryDate,voucherCode_ID,finalCost,paymentDate)
VALUES 
	('P1','B1','C1','VISA',6732987645674321,100,'2028-02-12',NULL, 100.00,'2023-01-12'),
	('P2','B2','C2','MASTERCARD',5423167452341769,200,'2030-10-23','V1',22.50,NULL),
    ('P3','B3','C2','MASTERCARD',5423167452341769,200,'2028-02-12',NULL,10.00,'2023-01-28'),
	('P4','B4','C3','VISA',8797543267538765,212,'2027-07-02',NULL,25.00,'2023-02-08'),
    ('P5','B5','C4','AMEX',9875678424336477, 789,'2029-04-10',NULL,25.00,'2023-03-10');

INSERT INTO ticketDelivery (ticketDelivery_ID, booking_ID, emailDelivery, pickup)
VALUES 
	('TD1','B1',1,0),
	('TD2','B2',0,1),
    ('TD3','B3',0,1),
	('TD4','B4',1,0),
    ('TD5','B5',0,1);

INSERT INTO bookingCancellation (bookingCancellation_ID, booking_ID, cancellationDate, refundStatus)
VALUES 
    ('BC1','B4','2023-03-14',0);

