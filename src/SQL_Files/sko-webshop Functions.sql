USE `webshop_skor`;
DROP function IF EXISTS `is_shoe_in_DB`;

DELIMITER $$
USE `webshop_skor`$$
CREATE FUNCTION `is_shoe_in_DB`(shoe_id INT)
RETURNS BOOLEAN
BEGIN
DECLARE nr_found INT;
SELECT COUNT(*) FROM sko WHERE sko_id = shoe_id INTO nr_found;
IF nr_found = 0 THEN
	RETURN FALSE;
ELSE
	RETURN TRUE;
END IF;
END$$

DELIMITER ;