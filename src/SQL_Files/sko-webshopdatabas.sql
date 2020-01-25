DROP DATABASE IF EXISTS fancy_webshop;
CREATE DATABASE fancy_webshop;

USE fancy_webshop;

-- Alla primärnycklar är syntetiskt index, förutom order_item och LT_shoe_category som har varsin composite key
-- Alla referenser (FOREIGN KEY) refererar till andra primärnycklar
-- Det mesta kan ändras som namn osv, så id är det enda som känns helt tryggt att referera normalt


CREATE TABLE city (
	city_id int NOT NULL AUTO_INCREMENT,
    city varchar(50) NOT NULL,
    PRIMARY KEY (city_id)
);
INSERT INTO city VALUES (1, 'Malmö');
INSERT INTO city VALUES (2, 'Linköping');
INSERT INTO city VALUES (3, 'Nyköping');
INSERT INTO city VALUES (4, 'Stockholm');
INSERT INTO city VALUES (5, 'Kiruna');


CREATE TABLE customer (
    customer_id int NOT NULL AUTO_INCREMENT,
    first_name varchar(50) NOT NULL,
    last_name varchar(50) NOT NULL,
    email varchar(50) NOT NULL,
    password varchar(50) NOT NULL,
    city_id int,
    PRIMARY KEY (customer_id),
    FOREIGN KEY (city_id) REFERENCES city (city_id) ON DELETE SET NULL
);
CREATE INDEX IX_Customer_Name ON customer (first_name, last_name); -- Vi söker ofta efter för- och efternamn tillsammans så ett dubbelindex blir effektivt

INSERT INTO customer VALUES (1, 'Daniel', 'Hughes', 'daniel.hughes@yh.nackademin.se', 'Hejsan:30', 4);
INSERT INTO customer VALUES (2, 'Michelle', 'Jackson', 'm.jackson@jackson.com', 'H0tma1l!', 2);
INSERT INTO customer VALUES (3, 'John', 'Smith', 'mr.smith@smith.com', '94Rx!kr', 5);
INSERT INTO customer VALUES (4, 'Lisa', 'Svensson', 'ls@gmail.com', '489TT;L', 1);
INSERT INTO customer VALUES (5, 'Yuki', 'Yamamoto', 'yy@yy.jp', 'Kawaii:89', 4);
INSERT INTO customer VALUES (6, 'Bertil', 'Granqvist', 'bertan@granen.se', 'BeQ99%', 2);
INSERT INTO customer VALUES (7, 'Kalle', 'Anka', 'kalle.anka@ankeborg.org', 'Knattarna:123', 3);


CREATE TABLE model (
  model_id int NOT NULL AUTO_INCREMENT,
  model varchar(50) NOT NULL,
  PRIMARY KEY (model_id)
);
CREATE INDEX IX_model ON model (model); -- Index för att snabbt hitta en viss modell

INSERT INTO model VALUES (1, 'Offroad');
INSERT INTO model VALUES (2, 'Performance');
INSERT INTO model VALUES (3, 'Sartorelle');
INSERT INTO model VALUES (4, 'MD Runner 2');
INSERT INTO model VALUES (5, 'Terrex Swift R2 Gore-Tex');

CREATE TABLE size (
  size_id int NOT NULL AUTO_INCREMENT,
  eu int NOT NULL,
  uk dec(3, 1) NOT NULL,
  usa_female dec(3, 1) NOT NULL,
  usa_male dec(3, 1) NOT NULL,
  japan dec(3, 1) NOT NULL,
  PRIMARY KEY (size_id)
);
INSERT INTO size VALUES (1, 38, 5, 7.5, 6, 23.5);
INSERT INTO size VALUES (2, 40, 6.5, 9, 7.5, 25);
INSERT INTO size VALUES (3, 42, 7.5, 10, 8.5, 26);


CREATE TABLE brand (
  brand_id int NOT NULL AUTO_INCREMENT,
  brand varchar(50) NOT NULL,
  PRIMARY KEY (brand_id)
);
INSERT INTO brand VALUES (1, 'Ecco');
INSERT INTO brand VALUES (2, 'Adidas');
INSERT INTO brand VALUES (3, 'Nike');


CREATE TABLE category (
    category_id int NOT NULL AUTO_INCREMENT,
    category varchar(50) NOT NULL,
    PRIMARY KEY (category_id)
);
INSERT INTO category VALUES (1, 'Sneakers');
INSERT INTO category VALUES (2, 'Sportskor');
INSERT INTO category VALUES (3, 'Sandaler');
INSERT INTO category VALUES (4, 'Stövlar');
INSERT INTO category VALUES (5, 'Hikingskor');
INSERT INTO category VALUES (6, 'Herrskor');
INSERT INTO category VALUES (7, 'Damskor');
INSERT INTO category VALUES (8, 'Barnskor');


CREATE TABLE shoe (
    shoe_id int NOT NULL AUTO_INCREMENT,
	model_id int,
    size_id int,
    brand_id int,
    price int NOT NULL,
    color varchar(50) NOT NULL,
		stock_quantity INT DEFAULT 0 CHECK (stock_quantity >= 0),
    PRIMARY KEY (shoe_id),
	FOREIGN KEY (model_id) REFERENCES model(model_id) ON DELETE SET NULL,
    FOREIGN KEY (size_id) REFERENCES size(size_id) ON DELETE SET NULL,
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id) ON DELETE SET NULL
);
INSERT INTO shoe VALUES (1, 1, 1, 1, 699, 'Svart', 12);
INSERT INTO shoe VALUES (2, 1, 2, 1, 699, 'Svart', 7);
INSERT INTO shoe VALUES (3, 1, 3, 1, 699, 'Svart', 4);
INSERT INTO shoe VALUES (4, 1, 1, 1, 699, 'Brun', 11);
INSERT INTO shoe VALUES (5, 1, 2, 1, 699, 'Brun', 7);
INSERT INTO shoe VALUES (6, 1, 3, 1, 699, 'Brun', 2);
INSERT INTO shoe VALUES (7, 2, 1, 2, 499, 'Vit', 6);
INSERT INTO shoe VALUES (8, 2, 2, 2, 499, 'Vit', 9);
INSERT INTO shoe VALUES (9, 2, 3, 2, 499, 'Vit', 4);
INSERT INTO shoe VALUES (10, 2, 1, 2, 499, 'Röd', 11);
INSERT INTO shoe VALUES (11, 2, 2, 2, 499, 'Röd', 3);
INSERT INTO shoe VALUES (12, 2, 3, 2, 499, 'Röd', 6);
INSERT INTO shoe VALUES (13, 3, 1, 1, 399, 'Grön', 5);
INSERT INTO shoe VALUES (14, 3, 2, 1, 399, 'Grön', 7);
INSERT INTO shoe VALUES (15, 3, 3, 1, 399, 'Grön', 3);
INSERT INTO shoe VALUES (16, 4, 1, 3, 629, 'Vit', 2);
INSERT INTO shoe VALUES (17, 4, 2, 3, 629, 'Vit', 3);
INSERT INTO shoe VALUES (18, 4, 3, 3, 629, 'Vit', 8);
INSERT INTO shoe VALUES (19, 4, 1, 3, 629, 'Blå', 1);
INSERT INTO shoe VALUES (20, 4, 2, 3, 629, 'Blå', 6);
INSERT INTO shoe VALUES (21, 4, 3, 3, 629, 'Blå', 8);
INSERT INTO shoe VALUES (22, 5, 1, 2, 1199, 'Svart', 9);
INSERT INTO shoe VALUES (23, 5, 2, 2, 1199, 'Svart', 3);
INSERT INTO shoe VALUES (24, 5, 3, 2, 1199, 'Svart', 6);


CREATE TABLE LT_shoe_category (
	shoe_id int NOT NULL,
	category_id int NOT NULL,
	PRIMARY KEY (shoe_id, category_id),
	FOREIGN KEY (shoe_id) REFERENCES shoe (shoe_id) ON DELETE CASCADE,
	FOREIGN KEY (category_id) REFERENCES category (category_id) ON DELETE CASCADE
);
INSERT INTO LT_shoe_category VALUES (1, 3);
INSERT INTO LT_shoe_category VALUES (2, 3);
INSERT INTO LT_shoe_category VALUES (3, 3);
INSERT INTO LT_shoe_category VALUES (4, 3);
INSERT INTO LT_shoe_category VALUES (5, 3);
INSERT INTO LT_shoe_category VALUES (6, 3);
INSERT INTO LT_shoe_category VALUES (7, 2);
INSERT INTO LT_shoe_category VALUES (8, 2);
INSERT INTO LT_shoe_category VALUES (9, 2);
INSERT INTO LT_shoe_category VALUES (10, 2);
INSERT INTO LT_shoe_category VALUES (11, 2);
INSERT INTO LT_shoe_category VALUES (12, 2);
INSERT INTO LT_shoe_category VALUES (13, 4);
INSERT INTO LT_shoe_category VALUES (14, 4);
INSERT INTO LT_shoe_category VALUES (15, 4);
INSERT INTO LT_shoe_category VALUES (16, 1);
INSERT INTO LT_shoe_category VALUES (17, 1);
INSERT INTO LT_shoe_category VALUES (18, 1);
INSERT INTO LT_shoe_category VALUES (19, 1);
INSERT INTO LT_shoe_category VALUES (20, 1);
INSERT INTO LT_shoe_category VALUES (21, 1);
INSERT INTO LT_shoe_category VALUES (22, 5);
INSERT INTO LT_shoe_category VALUES (23, 5);
INSERT INTO LT_shoe_category VALUES (24, 5);
INSERT INTO LT_shoe_category VALUES (1, 6);
INSERT INTO LT_shoe_category VALUES (2, 6);
INSERT INTO LT_shoe_category VALUES (3, 6);
INSERT INTO LT_shoe_category VALUES (4, 7);
INSERT INTO LT_shoe_category VALUES (5, 7);
INSERT INTO LT_shoe_category VALUES (6, 7);
INSERT INTO LT_shoe_category VALUES (7, 6);
INSERT INTO LT_shoe_category VALUES (8, 6);
INSERT INTO LT_shoe_category VALUES (9, 6);
INSERT INTO LT_shoe_category VALUES (10, 7);
INSERT INTO LT_shoe_category VALUES (11, 7);
INSERT INTO LT_shoe_category VALUES (12, 7);
INSERT INTO LT_shoe_category VALUES (13, 6);
INSERT INTO LT_shoe_category VALUES (14, 6);
INSERT INTO LT_shoe_category VALUES (15, 6);
INSERT INTO LT_shoe_category VALUES (16, 7);
INSERT INTO LT_shoe_category VALUES (17, 7);
INSERT INTO LT_shoe_category VALUES (18, 7);
INSERT INTO LT_shoe_category VALUES (19, 7);
INSERT INTO LT_shoe_category VALUES (20, 7);
INSERT INTO LT_shoe_category VALUES (21, 7);
INSERT INTO LT_shoe_category VALUES (22, 6);
INSERT INTO LT_shoe_category VALUES (23, 6);
INSERT INTO LT_shoe_category VALUES (24, 6);


CREATE TABLE orders (
    order_id int NOT NULL AUTO_INCREMENT,
    customer_id int,
    order_date DATE NOT NULL,
    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE SET NULL
);
INSERT INTO orders VALUES (1, 1, '2019-10-11');
INSERT INTO orders VALUES (2, 2, '2019-10-28');
INSERT INTO orders VALUES (3, 3, '2019-08-13');
INSERT INTO orders VALUES (4, 4, '2019-11-14');
INSERT INTO orders VALUES (5, 5, '2019-09-12');
INSERT INTO orders VALUES (6, 7, '2019-09-17');
INSERT INTO orders VALUES (7, 2, '2019-08-28');
INSERT INTO orders VALUES (8, 4, '2019-12-30');
INSERT INTO orders VALUES (9, 5, '2019-12-18');
INSERT INTO orders VALUES (10, 1, '2018-12-01');


CREATE TABLE order_item (
    -- order_item_id int NOT NULL AUTO_INCREMENT,
    order_id int NOT NULL,
    shoe_id int NOT NULL,
    quantity int NOT NULL CHECK (quantity >= 1),
    PRIMARY KEY (order_id, shoe_id),
    FOREIGN KEY (order_id) REFERENCES orders (order_id) ON DELETE CASCADE,
    FOREIGN KEY (shoe_id) REFERENCES shoe (shoe_id) ON DELETE CASCADE
);
INSERT INTO order_item VALUES (1, 1, 2);
INSERT INTO order_item VALUES (1, 4, 1);
INSERT INTO order_item VALUES (1, 10, 1);
INSERT INTO order_item VALUES (2, 14, 2);
INSERT INTO order_item VALUES (2, 17, 3);
INSERT INTO order_item VALUES (3, 21, 1);
INSERT INTO order_item VALUES (4, 1, 2);
INSERT INTO order_item VALUES (4, 7, 1);
INSERT INTO order_item VALUES (5, 19, 2);
INSERT INTO order_item VALUES (5, 16, 1);
INSERT INTO order_item VALUES (6, 18, 1);
INSERT INTO order_item VALUES (7, 9, 1);
INSERT INTO order_item VALUES (8, 5, 2);
INSERT INTO order_item VALUES (8, 14, 3);
INSERT INTO order_item VALUES (8, 20, 1);
INSERT INTO order_item VALUES (9, 10, 3);
INSERT INTO order_item VALUES (9, 7, 2);
INSERT INTO order_item VALUES (9, 4, 1);
INSERT INTO order_item VALUES (10, 13, 1);
INSERT INTO order_item VALUES (10, 23, 2);


CREATE TABLE rating (
    rating_id int NOT NULL AUTO_INCREMENT,
    rating varchar(50) NOT NULL,
    rating_value DECIMAL(2,1) NOT NULL,
    PRIMARY KEY (rating_id)
);
INSERT INTO rating VALUES (1, 'Aldrig mer', 1);
INSERT INTO rating VALUES (2, 'Missnöjd', 2);
INSERT INTO rating VALUES (3, 'Ganska nöjd', 3);
INSERT INTO rating VALUES (4, 'Nöjd', 4);
INSERT INTO rating VALUES (5, 'Mycket nöjd', 5);



CREATE TABLE review (
    review_id int NOT NULL AUTO_INCREMENT,
    customer_id int,
    shoe_id int,
    rating_id int,
    comment varchar(100),
    review_date Date CHECK (review_date <= CURRENT_DATE()),
    PRIMARY KEY (review_id),
    FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE SET NULL,
    FOREIGN KEY (shoe_id) REFERENCES shoe (shoe_id) ON DELETE SET NULL,
    FOREIGN KEY (rating_id) REFERENCES rating (rating_id) ON DELETE SET NULL,
    UNIQUE KEY (customer_id, shoe_id)
);

INSERT INTO review VALUES (1, 1, 1, 3, "Helt ok sandaler men inget speciellt");
INSERT INTO review VALUES (2, 2, 17, 5, "Bästa sneakers jag någonsin haft!");
INSERT INTO review VALUES (3, 1, 10, 4, "Älskar den röda färgen men sulan blir dock ibland lite obekväm");
INSERT INTO review VALUES (4, 3, 21, 1, "Helt värdelöst! Alldeles för dyrt för den skiten");
INSERT INTO review VALUES (5, 4, 1, 4, "Väldigt sköna för att vara billiga sandaler. Rekommenderar varmt");
INSERT INTO review VALUES (6, 7, 1, 3, "Jag har inte provat dem men de verkar ju sådär");


CREATE TABLE shoes_out_of_stock_log (
	id int NOT NULL AUTO_INCREMENT,
	shoe_id int NOT NULL,
	out_of_stock_date DATE NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (shoe_id) REFERENCES shoe(shoe_id) ON DELETE CASCADE
);
