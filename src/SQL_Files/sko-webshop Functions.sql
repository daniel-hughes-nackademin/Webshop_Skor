USE `fancy_webshop`;

-- Function (boolean): shoe exists in database
DROP function IF EXISTS `shoe_exists`;

DELIMITER $$
CREATE FUNCTION `shoe_exists`(input_shoe_id INT)
RETURNS BOOLEAN
BEGIN
DECLARE nr_found INT;
SELECT COUNT(*) INTO nr_found FROM shoe WHERE shoe_id = input_shoe_id;
IF nr_found = 0 THEN
	RETURN FALSE;
ELSE
	RETURN TRUE;
END IF;
END$$

DELIMITER ;

-- Function (boolean): customer exists in database
DROP function IF EXISTS `customer_exists`;

DELIMITER $$
CREATE FUNCTION `customer_exists`(input_customer_id INT)
RETURNS BOOLEAN
BEGIN
DECLARE nr_found INT;
SELECT COUNT(*) INTO nr_found FROM customer WHERE customer_id = input_customer_id;
IF nr_found = 0 THEN
	RETURN FALSE;
ELSE
	RETURN TRUE;
END IF;
END$$

DELIMITER ;


-- Function (boolean): order exists in database
DROP function IF EXISTS `order_exists`;

DELIMITER $$
CREATE FUNCTION `order_exists`(input_order_id INT)
RETURNS BOOLEAN
BEGIN
DECLARE nr_found INT;
SELECT COUNT(*) INTO nr_found FROM orders WHERE order_id = input_order_id;
IF nr_found = 0 THEN
	RETURN FALSE;
ELSE
	RETURN TRUE;
END IF;
END$$

DELIMITER ;

-- Function (boolean): order_item exists in database
DROP function IF EXISTS `order_item_exists`;

DELIMITER $$
CREATE FUNCTION `order_item_exists` (input_order_id INT, input_shoe_id INT)
RETURNS BOOLEAN
BEGIN
DECLARE nr_found INT;
SELECT COUNT(*) INTO nr_found FROM order_item WHERE order_id = input_order_id AND shoe_id = input_shoe_id;
IF nr_found = 0 THEN
	RETURN FALSE;
ELSE
	RETURN TRUE;
END IF;
END$$

DELIMITER ;


-- Function (boolean): rating exists in database
DROP function IF EXISTS `rating_exists`;

DELIMITER $$
CREATE FUNCTION `rating_exists`(input_rating_id INT)
RETURNS BOOLEAN
BEGIN
DECLARE nr_found INT;
SELECT COUNT(*) INTO nr_found FROM rating WHERE rating_id = input_rating_id;
IF nr_found = 0 THEN
	RETURN FALSE;
ELSE
	RETURN TRUE;
END IF;
END$$

DELIMITER ;


-- Function (decimal(2,1)): calculates average rating for a shoe
DROP function IF EXISTS average_rating;

DELIMITER $$
CREATE FUNCTION average_rating(input_shoe_id INT)
RETURNS DECIMAL(2,1)
BEGIN
DECLARE avg_rating DECIMAL(2,1);
SELECT AVG(r.rating_value) INTO avg_rating
FROM review rw
JOIN rating r USING (rating_id)
GROUP BY rw.shoe_id
HAVING rw.shoe_id = input_shoe_id;
RETURN avg_rating;
END$$

DELIMITER ;