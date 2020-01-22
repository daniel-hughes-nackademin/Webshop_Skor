DROP TRIGGER IF EXISTS update_out_of_stock_log_table;

DELIMITER $$

CREATE TRIGGER update_shoes_out_of_stock_log
AFTER UPDATE ON shoe
FOR EACH ROW
BEGIN
	IF (new.stock_quantity = 0) THEN
    INSERT INTO shoes_out_of_stock_log(shoe_id, out_of_stock_date)
    VALUES(old.shoe_id, CURRENT_DATE());
END IF;

END $$

DELIMITER ;
