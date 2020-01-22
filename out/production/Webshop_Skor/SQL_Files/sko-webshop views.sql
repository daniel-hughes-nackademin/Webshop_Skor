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
