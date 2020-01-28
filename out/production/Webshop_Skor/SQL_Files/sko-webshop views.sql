USE fancy_webshop;

DROP VIEW IF EXISTS average_rating_view;

CREATE VIEW average_rating_view AS
SELECT
s.shoe_id,
average_rating(s.shoe_id) AS average_rating,
(SELECT rating FROM rating WHERE rating_value = ROUND(average_rating)) AS rating
FROM shoe s
LEFT JOIN review rw USING (shoe_id)
LEFT JOIN rating r ON rw.rating_id = r.rating_id
GROUP BY s.shoe_id

DROP VIEW IF EXISTS shoe_view;

CREATE VIEW  shoe_view AS
SELECT s.shoe_id AS shoe_id,
       b.brand AS brand,
       m.model AS model,
       sz.eu AS eu,
       sz.uk AS uk,
       sz.usa_male AS usa_male,
       sz.usa_female AS usa_female,
       sz.japan AS japan,
       s.color AS color,
       s.price AS price,
       s.stock_quantity AS stock_quantity
FROM shoe s
JOIN brand b USING(brand_id)
JOIN model m USING(model_id)
JOIN size sz USING(size_id);




DROP VIEW IF EXISTS shoe_categories_view;

CREATE VIEW shoe_categories_view AS
SELECT s.shoe_id AS shoe_id,
       c.category AS category
FROM
lt_shoe_category lt
JOIN category c USING(category_id)
JOIN shoe s USING(shoe_id);

