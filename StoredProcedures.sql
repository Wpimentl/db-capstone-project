######################################
#PROCEDURES
DELIMITER //

CREATE PROCEDURE GetMaxQuantity(OUT max_quantity INT)
BEGIN
    SELECT MAX(Quantity) INTO max_quantity
    FROM littlelemondb.Orders;
END //

DELIMITER ;
DELIMITER $$
#
CREATE PROCEDURE CancelOrder(IN order_id INT)
BEGIN
    DECLARE order_exists INT;
    
    -- Check if the order exists
    SELECT COUNT(*) INTO order_exists
    FROM Orders
    WHERE idorders = order_id;

    IF order_exists = 0 THEN
        SELECT CONCAT('No order found with OrderID = ', order_id) AS Message;
    ELSE
        -- Delete the order
        DELETE FROM Orders
        WHERE idorders = order_id;
        
        SELECT CONCAT('Order ', order_id, ' has been canceled.') AS Message;
    END IF;
END$$

DELIMITER ;



DELIMITER $$

CREATE PROCEDURE CheckBooking(IN booking_date DATE, IN table_number INT)
BEGIN
    DECLARE booking_status INT;

    -- Check if the table is booked
    SELECT COUNT(*) INTO booking_status
    FROM Bookings
    WHERE bookingslot = booking_date 
    AND tableno = table_number;

    -- Return the booking status
    IF booking_status = 0 THEN
        SELECT concat('The table ', table_number,' is available for this date.') Booking_status;
    ELSE
        SELECT concat('The table ', table_number,' is already booked for this date.') Booking_status;
    END IF;
END$$

DELIMITER ;


###########

DELIMITER //

CREATE PROCEDURE AddValidBooking(IN booking_date DATE,  IN table_number INT)
BEGIN
  DECLARE existing_booking INT;

  START TRANSACTION;

  SELECT COUNT(*) INTO existing_booking
  FROM bookings
  WHERE bookingslot = booking_date 
  AND tableno = table_number;

  IF existing_booking > 0 THEN
    ROLLBACK;
    #SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Table is already booked on the given date.';
    SELECT 'Table is already booked on the given date. -booking cancelled' booking_status;
  ELSE
    INSERT INTO bookings (bookingslot, tableno)
    VALUES (booking_date, table_number);
    COMMIT;
    SELECT 'New booking successfully added' as "Booking status";
  END IF;
END //

DELIMITER ;


#########
DELIMITER //

CREATE PROCEDURE AddBooking (IN booking_id INT,IN customer_id INT,  IN table_number INT,IN booking_date DATE)
BEGIN

	INSERT INTO bookings (idbookings,customerid, tableno, bookingslot)
    VALUES (booking_id, customer_id, table_number,booking_date);
    COMMIT;
    SELECT 'New booking successfully added' as "Booking status";

END //

DELIMITER ;

###########
DROP PROCEDURE `littlelemondb`.`UpdateBooking`;

DELIMITER //

CREATE PROCEDURE UpdateBooking  (IN booking_id INT,IN booking_date DATE)
BEGIN

	UPDATE Bookings
    SET bookingslot = booking_date
    WHERE idbookings = booking_id;
    COMMIT;
    SELECT concat('Booking ', booking_id,' has been updated.') as "Booking status";

END //

DELIMITER ;





############################################
#PREPARED STATEMENT

PREPARE GetOrderDetail FROM 
'select idorders OrderID, Quantity, billamount Cost
from bookings b, orders o
where  bookingid = b.idbookings 
and b.customerid = ?';



######################################
CREATE VIEW `littlelemondb`.`ordersview` AS
    SELECT 
        `littlelemondb`.`orders`.`idorders` AS `OrderID`,
        `littlelemondb`.`orders`.`quantity` AS `Quantity`,
        `littlelemondb`.`orders`.`billamount` AS `Cost`
    FROM
        `littlelemondb`.`orders`
    WHERE
        (`littlelemondb`.`orders`.`quantity` > 2);

##############################
#JOIN STATEMENT
select idcustomers CustomerID, c.name Full_Name, o.idorders Order_ID, billamount Cost, m.cusine Menu_Name, mi.name Course_name
from Orders o, bookings b, customers c, menu m, menu_items mi
where o.bookingid = b.idbookings
and o.menuid = m.idmenu
and m.itemid = mi.iditems
and b.customerid = c.idcustomers;

##################################
#SUBQUERY
select cusine
from menu
where idmenu = ANY (
					select menuid
					from orders
					where quantity >2);

