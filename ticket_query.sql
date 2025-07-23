-- 1 
SELECT 
    e.eventName AS 'Event',
    tt.ticketTypeName as 'Ticket Type',
    CONCAT('£', tt.price) AS 'Price',
    el.eventLocationName AS 'Location Name',
    DATE_FORMAT(e.startDate, '%D %M, %Y') AS 'Start Date',
    DATE_FORMAT(e.endDate, '%D %M, %Y') AS 'End Date',
    DATE_FORMAT(e.startTime, '%h:%i %p') AS 'Starting Time',
    DATE_FORMAT(e.endTime, '%h:%i %p') AS 'Ending Time',
    CONCAT(e.eventDuration, ' Hours') AS 'Duration',
    e.eventDescription as'Description',
    tt.ticketTypeQuantity as 'Quantity',
    e.event_ID as 'Event ID',
    el.eventLocation_ID as 'Location ID'
FROM 
    Event_ e
JOIN 
    eventLocation el ON e.eventLocation_ID = el.eventLocation_ID
JOIN 
    ticketType tt ON e.event_ID = tt.event_ID
WHERE 
    e.eventName = 'Exeter Food Festival 2023';
-- 2
SELECT 
    e.eventName AS 'Event',
    DATE_FORMAT(e.startTime, '%h:%i %p') AS 'Starting Time',
    DATE_FORMAT(e.endTime, '%h:%i %p') AS 'Ending Time',
    e.eventDescription AS 'Description'
FROM 
    Event_ e
WHERE 
    e.startDate >= '2023-07-01' AND e.endDate <= '2023-07-10';
-- 3 
SELECT 
    tt.ticketTypeName AS 'Ticket Type Name', 
    (tt.ticketTypeQuantity - IFNULL(SUM(t.ticketQuantity), 0)) AS 'Available Tickets',
    CONCAT('£', tt.price) AS 'Price'
FROM 
    ticketType tt
LEFT JOIN 
    Ticket t ON tt.ticketType_ID = t.ticketType_ID
WHERE 
    tt.ticketType_ID = 'EXMF23B'
GROUP BY 
    tt.ticketTypeName, 
    tt.price;
-- 4
SELECT 
    c.fname AS 'First Name', 
    c.lname AS 'Last Name', 
    SUM(t.ticketQuantity) AS 'Number Of Gold Tickets'
FROM 
    Customer c
JOIN 
    Booking b ON c.customer_ID = b.customer_ID
JOIN 
    Ticket t ON b.booking_ID = t.booking_ID
JOIN 
    ticketType tt ON t.ticketType_ID = tt.ticketType_ID
JOIN 
    Event_ e ON tt.event_ID = e.event_ID
WHERE 
    e.eventName = 'EXMOUTH MUSIC FESTIVAL 2023' AND tt.ticketTypeName = 'GOLD'
GROUP BY 
    c.fname, 
    c.lname;
-- 5 
SELECT 
    e.eventName AS 'Event', 
    SUM(t.ticketQuantity) AS SoldOutTickets
FROM 
    Event_ e
JOIN 
    ticketType tt ON e.event_ID = tt.event_ID
JOIN 
    Ticket t ON tt.ticketType_ID = t.ticketType_ID
GROUP BY 
    e.eventName
ORDER BY 
    SoldOutTickets DESC;
-- 6 
SELECT 
    b.booking_ID AS 'Booking ID',
    CONCAT(c.fname, ' ', c.lname) AS 'Customer Name',
    DATE_FORMAT(p.paymentDate, '%D %M, %Y') AS 'Payment Date',
    e.eventName AS 'Event',
    CASE 
        WHEN td.emailDelivery = 1 THEN 'Email Delivery'
        WHEN td.pickUp = 1 THEN 'Pick Up'
        ELSE 'No Delivery Option'
    END AS 'Delivery Option',
    CASE 
        WHEN b.paymentStatus = 1 THEN 'Paid'
        ELSE 'Not Paid'
    END AS 'Payment Status',
    tt.ticketTypeName AS 'Ticket Type',
    t.ticketQuantity AS 'Tickets',
    CONCAT('£', b.cost) AS 'Total Cost',
    CONCAT('£', p.finalCost) AS 'Total Payment'
FROM 
    Booking b
JOIN 
    Customer c ON b.customer_ID = c.customer_ID
JOIN 
    Event_ e ON b.event_ID = e.event_ID
JOIN 
    ticketDelivery td ON b.booking_ID = td.booking_ID
JOIN 
    Ticket t ON b.booking_ID = t.booking_ID
JOIN 
    ticketType tt ON t.ticketType_ID = tt.ticketType_ID
LEFT JOIN 
    Payment p ON b.booking_ID = p.booking_ID
WHERE 
    b.booking_ID = 'B1';  
-- 7 
SELECT 
    e.eventName AS 'Event With Max Income', 
    CONCAT('£', FORMAT(SUM(p.finalCost), 2)) AS 'Income'
FROM 
    Event_ e
JOIN 
    Booking b ON e.event_ID = b.event_ID
JOIN 
    Payment p ON b.booking_ID = p.booking_ID
GROUP BY 
    e.eventName
ORDER BY 
    SUM(p.finalCost) DESC
LIMIT 1;


