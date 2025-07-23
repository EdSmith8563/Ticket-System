-- 1 
UPDATE ticketType
SET ticketTypeQuantity = ticketTypeQuantity + 100
WHERE ticketType_ID = 'EFF23ADULT';

UPDATE Event_
SET totalTickets = totalTickets + 100
WHERE event_ID = 'EFF23';
-- 2
INSERT INTO Customer (customer_ID, fname, lname, DOB, email, phone)
VALUES 
    ('C5', 'Ian', 'Cooper', '1999-09-18', 'iancooper@gmail.com', '07241234411');
INSERT INTO Booking (booking_ID, paymentStatus, numOfTickets, cost, bookingQuantity, event_ID, customer_ID)
VALUES 
    ('B6', 0, 3, 25.00, 1, 'EFF23', 'C5');
INSERT INTO Ticket (ticket_ID, booking_ID, ticketType_ID, ticketQuantity)
VALUES 
    ('T7', 'B6', 'EFF23ADULT', 2),
    ('T8', 'B6', 'EFF23CHILD', 1);
INSERT INTO voucherCode(voucherCode_ID,uniqueCode,discount,isActive,event_ID)
VALUES
	('V3','FOOD10',0.10,1,'EFF23');

INSERT INTO Payment (Payment_ID, booking_ID, customer_ID, cardType, cardNo, cardCVC, expiryDate, voucherCode_ID, finalCost, paymentDate)
VALUES 
    ('P6', 'B6', 'C5', 'VISA', 1975423145678542, 481, '2032-12-03', 'V3', 22.50, '2023-03-21');

INSERT INTO ticketDelivery (ticketDelivery_ID, booking_ID, emailDelivery, pickUp)
VALUES 
    ('TD6', 'B6', 1, 0);
-- 3
INSERT INTO bookingCancellation (bookingCancellation_ID, booking_ID, cancellationDate, refundStatus)
VALUES 
	('BC2', 'B5', CURRENT_DATE(), 0);
-- 4
INSERT INTO voucherCode(voucherCode_ID,uniqueCode,discount,isActive,event_ID)
VALUES
	('V4', 'SUMMER20',0.2,1,'EXMF23');
