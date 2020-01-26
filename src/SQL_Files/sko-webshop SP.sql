USE fancy_webshop;
DROP PROCEDURE IF EXISTS add_to_cart;

DELIMITER //
CREATE PROCEDURE add_to_cart(IN input_customer_id INT, IN input_order_id INT, IN input_shoe_id INT)
BEGIN

DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		SELECT('SQLEXCEPTION, changes not saved') AS ERROR;
		RESIGNAL;
    END;


START TRANSACTION;
IF NOT shoe_exists(input_shoe_id) THEN
	SELECT 'Shoe not found in database' AS ERROR;
ELSEIF NOT customer_exists(input_customer_id) THEN
	SELECT 'Customer not found in database' AS ERROR;
ELSE -- customer and shoe IDs are in the database

	IF NOT order_exists(input_order_id) THEN
		INSERT INTO orders (customer_id, order_date) VALUES (input_customer_id, CURRENT_DATE());
        INSERT INTO order_item (order_id, shoe_id, quantity) VALUES(LAST_INSERT_ID(), input_shoe_id, 1);
	ELSE -- order exists
		IF order_item_exists(input_order_id, input_shoe_id) THEN
			UPDATE order_item
            SET quantity = quantity + 1
            WHERE order_id = input_order_id AND shoe_id = input_shoe_id;
		ELSE -- If order_item doesn't exist
			INSERT INTO order_item (order_id, shoe_id, quantity) VALUES(input_order_id, input_shoe_id, 1);
        END IF;
	END IF;


    -- Stock quantity decreases by 1 since order item quantity increases by 1
    UPDATE shoe
    SET stock_quantity = stock_quantity - 1
    WHERE shoe_id = input_shoe_id;

END IF;
COMMIT;

END //

DELIMITER ;

DROP PROCEDURE IF EXISTS rate;

DELIMITER //
CREATE PROCEDURE rate(input_customer_id INT, input_shoe_id INT, input_rating_id INT, input_comment VARCHAR(100))
BEGIN

DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
    END;


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



DROP PROCEDURE IF EXISTS attempt_login;

DELIMITER //
CREATE PROCEDURE attempt_login(input_email VARCHAR(50), input_password VARCHAR(50))
BEGIN
DECLARE cust_id int;

-- No exception handler because no rollback is needed for select statement and sql exception stack trace is desired

-- Store customer id
SELECT customer_id
    INTO cust_id
    FROM customer
    WHERE email = input_email AND password = input_password;

IF NOT (customer_exists(cust_id)) THEN
    SELECT 'Email or password is incorrect' AS ERROR;
ELSE
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        c.email,
        cy.city
        FROM customer c
        JOIN city cy USING (city_id);
END IF;

END //

DELIMITER ;