
DELIMITER //

CREATE PROCEDURE GetMaxQuantity(OUT max_quantity INT)
BEGIN
    SELECT MAX(Quantity) INTO max_quantity
    FROM littlelemondb.Orders;
END //

DELIMITER ;

#PREPARED STATEMENT

PREPARE GetOrderDetail FROM 
'select idorders OrderID, Quantity, billamount Cost
from bookings b, orders o
where  bookingid = b.idbookings 
and b.customerid = ?'


DELIMITER $$

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




