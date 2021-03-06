USE fancy_webshop;
DROP PROCEDURE IF EXISTS add_to_cart;

DELIMITER //
CREATE PROCEDURE add_to_cart(IN input_customer_id INT, IN input_order_id INT, IN input_shoe_id INT)
BEGIN

DECLARE current_order_id INT;

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
		SET current_order_id = LAST_INSERT_ID();
        INSERT INTO order_item (order_id, shoe_id, quantity) VALUES(current_order_id, input_shoe_id, 1);
        SELECT current_order_id;
	ELSE -- order exists
		IF order_item_exists(input_order_id, input_shoe_id) THEN
			UPDATE order_item
            SET quantity = quantity + 1
            WHERE order_id = input_order_id AND shoe_id = input_shoe_id;
		ELSE -- If order_item doesn't exist
			INSERT INTO order_item (order_id, shoe_id, quantity) VALUES(input_order_id, input_shoe_id, 1);
        END IF;

        SELECT 'Shoe added to cart' AS SUCCESS;
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
	INSERT INTO review (customer_id, shoe_id, rating_id, comment, review_date) VALUES (input_customer_id, input_shoe_id, input_rating_id, input_comment, CURRENT_DATE());
END IF;

COMMIT;
END //

DELIMITER ;



DROP PROCEDURE IF EXISTS attempt_login;

DELIMITER //
CREATE PROCEDURE attempt_login(IN input_email varchar(50), IN input_password varchar(50))
BEGIN
DECLARE cust_id int DEFAULT NULL;

-- No exception handler because no rollback is needed and sql exception stack trace is desired

-- Store customer id
SELECT customer_id
    INTO cust_id
    FROM customer
    WHERE email = input_email AND BINARY password = input_password;

IF NOT customer_exists(cust_id) THEN
    SELECT 'Email or password is incorrect' AS ERROR;
ELSE
    SELECT
        c.customer_id AS id,
        c.first_name AS first,
        c.last_name AS last,
        cy.city AS city
        FROM customer c
        JOIN city cy USING (city_id)
        WHERE c.customer_id = cust_id;
END IF;

END //

DELIMITER ;



DROP PROCEDURE IF EXISTS get_specific_order;

DELIMITER //
CREATE PROCEDURE get_specific_order(input_order_id INT)
BEGIN

DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
    END;


START TRANSACTION;

IF NOT order_exists(input_order_id) THEN
	SELECT 'Order does not exist in the database' AS ERROR;
ELSE
	SELECT
	    o.order_date,
	    s.shoe_id,
	    b.brand,
	    m.model,
	    s.color,
	    sz.eu,
        sz.uk,
	    sz.usa_male,
	    sz.usa_female,
        sz.japan,
        s.price,
	    s.stock_quantity,
        oi.quantity
	FROM order_item oi
	JOIN orders o USING (order_id)
	JOIN shoe s USING (shoe_id)
	JOIN brand b ON s.brand_id = b.brand_id
	JOIN model m ON s.model_id = m.model_id
	JOIN size sz ON s.size_id = sz.size_id
	WHERE oi.order_id = input_order_id;
END IF;

COMMIT;
END //

DELIMITER ;