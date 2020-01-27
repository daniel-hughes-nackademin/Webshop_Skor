USE fancy_webshop;
DROP PROCEDURE IF EXISTS add_to_cart;

DELIMITER //
CREATE PROCEDURE add_to_cart(IN input_customer_id INT, IN input_order_id INT, IN input_shoe_id INT)
cart_sp: BEGIN

DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		SELECT('SQLEXCEPTION, changes not saved') AS ERROR;
    END;

SET AUTOCOMMIT = 0;
START TRANSACTION;

IF NOT shoe_exists(input_shoe_id) THEN
	SELECT 'Shoe not found in database' AS ERROR;
ELSEIF NOT customer_exists(input_customer_id) THEN
	SELECT 'Customer not found in database' AS ERROR;
ELSE
	
	IF NOT order_exits(input_order_id) OR input_order_id IS NULL THEN -- Is the null check necessary? null counts should be 0 as well
		INSERT INTO orders (customer_id, order_date) VALUES (input_customer_id, CURRENT_DATE());
        INSERT INTO order_item (order_id, shoe_id, quantity) VALUES(LAST_INSERT_ID(), input_shoe_id, 1);
	ELSE -- order exists

        -- If order_item doesn't exist
		INSERT INTO order_item (order_id, shoe_id, quantity) VALUES(input_order_id, input_shoe_id, 1);
	END IF;
END IF;

COMMIT;

END //

DELIMITER ;


DELIMITER //
CREATE PROCEDURE rate(input_customer_id INT, input_shoe_id INT, input_rating_id INT, input_comment VARCHAR(100))
BEGIN

DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		SELECT('SQLEXCEPTION, changes not saved') AS ERROR;
    END;

SET AUTOCOMMIT = 0;
START TRANSACTION;

IF NOT customer_exists(input_customer_id) THEN
	SELECT 'Customer does not exist in the database' AS ERROR;
ELSEIF NOT shoe_exists(input_shoe_id) THEN
	SELECT 'Shoe does not exist in the database' AS ERROR;
ELSEIF NOT rating_exists(input_rating_id) THEN
	SELECT 'Rating does not exist in the database' AS ERROR;
ELSE
	INSERT INTO review (customer_id, shoe_id, rating_id, comment) VALUES (input_customer_id, input_shoe_id, input_rating_id, input_comment);
END IF;

COMMIT;
END //

DELIMITER ;