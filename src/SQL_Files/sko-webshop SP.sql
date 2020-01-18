USE webshop_skor;
DROP PROCEDURE IF EXISTS add_to_cart;

DELIMITER //
CREATE PROCEDURE add_to_cart(IN customer_id INT, IN order_id INT, IN shoe_id INT)
BEGIN
IF NOT is_shoe_in_DB(shoe_id) OR NOT is_customer_in_DB(customer_id) THEN
	-- throw error
    LEAVE sp;
ELSE
	IF NOT is_order_in_DB(order_id) OR order_id IS NULL THEN
		INSERT INTO beställning (kund_id, datum) VALUES (customer_id, CURRENT_DATE());
        INSERT INTO beställningsvara (beställning_id, sko_id, antal) VALUES(LAST_INSERT_ID(), shoe_id, 1);
	ELSE -- order exists
		
        -- If order_item doesn't exist
		INSERT INTO beställningsvara (beställning_id, sko_id, antal) VALUES(order_id, shoe_id, 1);
	END IF;
END IF; 

END //

DELIMITER ;