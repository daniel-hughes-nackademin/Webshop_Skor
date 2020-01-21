
-- Function (boolean): shoe exists in database
USE `webshop_skor`;
DROP function IF EXISTS `is_shoe_in_DB`;

DELIMITER $$
USE `webshop_skor`$$
CREATE FUNCTION `is_shoe_in_DB`(shoe_id INT)
RETURNS BOOLEAN
BEGIN
DECLARE nr_found INT;
SELECT COUNT(*) INTO nr_found FROM sko WHERE sko_id = shoe_id;
IF nr_found = 0 THEN
	RETURN FALSE;
ELSE
	RETURN TRUE;
END IF;
END$$

DELIMITER ;

-- Function (boolean): customer exists in database
USE `webshop_skor`;
DROP function IF EXISTS `is_customer_in_DB`;

DELIMITER $$
USE `webshop_skor`$$
CREATE FUNCTION `is_customer_in_DB`(customer_id INT)
RETURNS BOOLEAN
BEGIN
DECLARE nr_found INT;
SELECT COUNT(*) INTO nr_found FROM kund WHERE kund_id = customer_id;
IF nr_found = 0 THEN
	RETURN FALSE;
ELSE
	RETURN TRUE;
END IF;
END$$

DELIMITER ;


-- Function (boolean): order exists in database
USE `webshop_skor`;
DROP function IF EXISTS `is_order_in_DB`;

DELIMITER $$
USE `webshop_skor`$$
CREATE FUNCTION `is_order_in_DB`(order_id INT)
RETURNS BOOLEAN
BEGIN
DECLARE nr_found INT;
SELECT COUNT(*) INTO nr_found FROM beställning WHERE beställning_id = order_id;
IF nr_found = 0 THEN
	RETURN FALSE;
ELSE
	RETURN TRUE;
END IF;
END$$

DELIMITER ;

-- Function (boolean): order_item exists in database
USE `webshop_skor`;
DROP function IF EXISTS `is_order_item_in_DB`;

DELIMITER $$
USE `webshop_skor`$$
CREATE FUNCTION `is_order_item_in_DB` (order_id INT, shoe_id INT)
RETURNS BOOLEAN
BEGIN
DECLARE nr_found INT;
SELECT COUNT(*) INTO nr_found FROM beställningsvara WHERE beställning_id = order_id AND sko_id = shoe_id;
IF nr_found = 0 THEN
	RETURN FALSE;
ELSE
	RETURN TRUE;
END IF;
END$$

DELIMITER ;
