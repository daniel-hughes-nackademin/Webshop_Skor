DROP DATABASE IF EXISTS webshop_skor;
CREATE DATABASE webshop_skor;

USE webshop_skor;

-- Alla primärnycklar är syntetiskt index, förutom Beställningsvara och LT_SkoKategori som har varsin composite key
-- Alla referenser (FOREIGN KEY) refererar till andra primärnycklar
-- Det mesta kan ändras som namn osv, så id är det enda som känns helt tryggt att referera normalt


CREATE TABLE Ort (
	ort_id int NOT NULL AUTO_INCREMENT,
    ort varchar(50) NOT NULL,
    PRIMARY KEY (ort_id)
);
INSERT INTO Ort VALUES (1, 'Malmö');
INSERT INTO Ort VALUES (2, 'Linköping');
INSERT INTO Ort VALUES (3, 'Nyköping');
INSERT INTO Ort VALUES (4, 'Stockholm');
INSERT INTO Ort VALUES (5, 'Kiruna');


CREATE TABLE Kund (
    kund_id int NOT NULL AUTO_INCREMENT,
    förnamn varchar(50) NOT NULL,
    efternamn varchar(50) NOT NULL,
    ort_id int,
    PRIMARY KEY (kund_id),
    FOREIGN KEY (ort_id) REFERENCES Ort (ort_id) ON DELETE SET NULL
);
CREATE INDEX IX_KundNamn ON Kund (förnamn, efternamn); -- Vi söker ofta efter för- och efternamn tillsammans så ett dubbelindex blir effektivt

INSERT INTO Kund VALUES (1, 'Daniel', 'Hughes', 4);
INSERT INTO Kund VALUES (2, 'Michelle', 'Jackson', 2);
INSERT INTO Kund VALUES (3, 'John', 'Smith', 5);
INSERT INTO Kund VALUES (4, 'Lisa', 'Svensson', 1);
INSERT INTO Kund VALUES (5, 'Yuki', 'Yamamoto', 4);
INSERT INTO Kund VALUES (6, 'Bertil', 'Granqvist', 2);
INSERT INTO Kund VALUES (7, 'Kalle', 'Anka', 3);


CREATE TABLE Modell (
  modell_id int NOT NULL AUTO_INCREMENT,
  modell varchar(50) NOT NULL,
  PRIMARY KEY (modell_id)
);
CREATE INDEX IX_Modell ON Modell (modell); -- Index för att snabbt hitta en viss modell

INSERT INTO Modell VALUES (1, 'Offroad');
INSERT INTO Modell VALUES (2, 'Performance');
INSERT INTO Modell VALUES (3, 'Sartorelle');
INSERT INTO Modell VALUES (4, 'MD Runner 2');
INSERT INTO Modell VALUES (5, 'Terrex Swift R2 Gore-Tex');

CREATE TABLE Storlek (
  storlek_id int NOT NULL AUTO_INCREMENT,
  eu int NOT NULL,
  uk dec(3, 1) NOT NULL,
  usa_dam dec(3, 1) NOT NULL,
  usa_herr dec(3, 1) NOT NULL,
  japan dec(3, 1) NOT NULL,
  PRIMARY KEY (storlek_id)
);
INSERT INTO Storlek VALUES (1, 38, 5, 7.5, 6, 23.5);
INSERT INTO Storlek VALUES (2, 40, 6.5, 9, 7.5, 25);
INSERT INTO Storlek VALUES (3, 42, 7.5, 10, 8.5, 26);


CREATE TABLE Märke (
  märke_id int NOT NULL AUTO_INCREMENT,
  märke varchar(50) NOT NULL,
  PRIMARY KEY (märke_id)
);
INSERT INTO Märke VALUES (1, 'Ecco');
INSERT INTO Märke VALUES (2, 'Adidas');
INSERT INTO Märke VALUES (3, 'Nike');


CREATE TABLE Kategori (
    kategori_id int NOT NULL AUTO_INCREMENT,
    kategori varchar(50) NOT NULL,
    PRIMARY KEY (kategori_id)
);
INSERT INTO Kategori VALUES (1, 'Sneakers');
INSERT INTO Kategori VALUES (2, 'Sportskor');
INSERT INTO Kategori VALUES (3, 'Sandaler');
INSERT INTO Kategori VALUES (4, 'Stövlar');
INSERT INTO Kategori VALUES (5, 'Hikingskor');
INSERT INTO Kategori VALUES (6, 'Herrskor');
INSERT INTO Kategori VALUES (7, 'Damskor');
INSERT INTO Kategori VALUES (8, 'Barnskor');


CREATE TABLE Sko (
    sko_id int NOT NULL AUTO_INCREMENT,
		modell_id int,
    storlek_id int,
    märke_id int,
    pris int NOT NULL,
    färg varchar(50) NOT NULL,
		antal_i_lager INT DEFAULT 0,
    PRIMARY KEY (sko_id),
	FOREIGN KEY (modell_id) REFERENCES Modell(modell_id) ON DELETE SET NULL,
    FOREIGN KEY (storlek_id) REFERENCES Storlek(storlek_id) ON DELETE SET NULL,
    FOREIGN KEY (märke_id) REFERENCES Märke(märke_id) ON DELETE SET NULL
);
INSERT INTO Sko VALUES (1, 1, 1, 1, 699, 'Svart', 12);
INSERT INTO Sko VALUES (2, 1, 2, 1, 699, 'Svart', 7);
INSERT INTO Sko VALUES (3, 1, 3, 1, 699, 'Svart', 4);
INSERT INTO Sko VALUES (4, 1, 1, 1, 699, 'Brun', 11);
INSERT INTO Sko VALUES (5, 1, 2, 1, 699, 'Brun', 7);
INSERT INTO Sko VALUES (6, 1, 3, 1, 699, 'Brun', 2);
INSERT INTO Sko VALUES (7, 2, 1, 2, 499, 'Vit', 6);
INSERT INTO Sko VALUES (8, 2, 2, 2, 499, 'Vit', 9);
INSERT INTO Sko VALUES (9, 2, 3, 2, 499, 'Vit', 4);
INSERT INTO Sko VALUES (10, 2, 1, 2, 499, 'Röd', 11);
INSERT INTO Sko VALUES (11, 2, 2, 2, 499, 'Röd', 3);
INSERT INTO Sko VALUES (12, 2, 3, 2, 499, 'Röd', 6);
INSERT INTO Sko VALUES (13, 3, 1, 1, 399, 'Grön', 5);
INSERT INTO Sko VALUES (14, 3, 2, 1, 399, 'Grön', 7);
INSERT INTO Sko VALUES (15, 3, 3, 1, 399, 'Grön', 3);
INSERT INTO Sko VALUES (16, 4, 1, 3, 629, 'Vit', 2);
INSERT INTO Sko VALUES (17, 4, 2, 3, 629, 'Vit', 3);
INSERT INTO Sko VALUES (18, 4, 3, 3, 629, 'Vit', 8);
INSERT INTO Sko VALUES (19, 4, 1, 3, 629, 'Blå', 1);
INSERT INTO Sko VALUES (20, 4, 2, 3, 629, 'Blå', 6);
INSERT INTO Sko VALUES (21, 4, 3, 3, 629, 'Blå', 8);
INSERT INTO Sko VALUES (22, 5, 1, 2, 1199, 'Svart', 9);
INSERT INTO Sko VALUES (23, 5, 2, 2, 1199, 'Svart', 3);
INSERT INTO Sko VALUES (24, 5, 3, 2, 1199, 'Svart', 6);


CREATE TABLE LT_SkoKategori (
	sko_id int NOT NULL,
	kategori_id int NOT NULL,
	PRIMARY KEY (sko_id, kategori_id),
	FOREIGN KEY (sko_id) REFERENCES Sko (sko_id) ON DELETE CASCADE,
	FOREIGN KEY (kategori_id) REFERENCES Kategori (kategori_id) ON DELETE CASCADE
);
INSERT INTO LT_SkoKategori VALUES (1, 3);
INSERT INTO LT_SkoKategori VALUES (2, 3);
INSERT INTO LT_SkoKategori VALUES (3, 3);
INSERT INTO LT_SkoKategori VALUES (4, 3);
INSERT INTO LT_SkoKategori VALUES (5, 3);
INSERT INTO LT_SkoKategori VALUES (6, 3);
INSERT INTO LT_SkoKategori VALUES (7, 2);
INSERT INTO LT_SkoKategori VALUES (8, 2);
INSERT INTO LT_SkoKategori VALUES (9, 2);
INSERT INTO LT_SkoKategori VALUES (10, 2);
INSERT INTO LT_SkoKategori VALUES (11, 2);
INSERT INTO LT_SkoKategori VALUES (12, 2);
INSERT INTO LT_SkoKategori VALUES (13, 4);
INSERT INTO LT_SkoKategori VALUES (14, 4);
INSERT INTO LT_SkoKategori VALUES (15, 4);
INSERT INTO LT_SkoKategori VALUES (16, 1);
INSERT INTO LT_SkoKategori VALUES (17, 1);
INSERT INTO LT_SkoKategori VALUES (18, 1);
INSERT INTO LT_SkoKategori VALUES (19, 1);
INSERT INTO LT_SkoKategori VALUES (20, 1);
INSERT INTO LT_SkoKategori VALUES (21, 1);
INSERT INTO LT_SkoKategori VALUES (22, 5);
INSERT INTO LT_SkoKategori VALUES (23, 5);
INSERT INTO LT_SkoKategori VALUES (24, 5);
INSERT INTO LT_SkoKategori VALUES (1, 6);
INSERT INTO LT_SkoKategori VALUES (2, 6);
INSERT INTO LT_SkoKategori VALUES (3, 6);
INSERT INTO LT_SkoKategori VALUES (4, 7);
INSERT INTO LT_SkoKategori VALUES (5, 7);
INSERT INTO LT_SkoKategori VALUES (6, 7);
INSERT INTO LT_SkoKategori VALUES (7, 6);
INSERT INTO LT_SkoKategori VALUES (8, 6);
INSERT INTO LT_SkoKategori VALUES (9, 6);
INSERT INTO LT_SkoKategori VALUES (10, 7);
INSERT INTO LT_SkoKategori VALUES (11, 7);
INSERT INTO LT_SkoKategori VALUES (12, 7);
INSERT INTO LT_SkoKategori VALUES (13, 6);
INSERT INTO LT_SkoKategori VALUES (14, 6);
INSERT INTO LT_SkoKategori VALUES (15, 6);
INSERT INTO LT_SkoKategori VALUES (16, 7);
INSERT INTO LT_SkoKategori VALUES (17, 7);
INSERT INTO LT_SkoKategori VALUES (18, 7);
INSERT INTO LT_SkoKategori VALUES (19, 7);
INSERT INTO LT_SkoKategori VALUES (20, 7);
INSERT INTO LT_SkoKategori VALUES (21, 7);
INSERT INTO LT_SkoKategori VALUES (22, 6);
INSERT INTO LT_SkoKategori VALUES (23, 6);
INSERT INTO LT_SkoKategori VALUES (24, 6);


CREATE TABLE Beställning (
    beställning_id int NOT NULL AUTO_INCREMENT,
    kund_id int,
    datum DATE NOT NULL,
    PRIMARY KEY (beställning_id),
    FOREIGN KEY (kund_id) REFERENCES Kund (kund_id) ON DELETE SET NULL
);
INSERT INTO Beställning VALUES (1, 1, '2019-10-11');
INSERT INTO Beställning VALUES (2, 2, '2019-10-28');
INSERT INTO Beställning VALUES (3, 3, '2019-08-13');
INSERT INTO Beställning VALUES (4, 4, '2019-11-14');
INSERT INTO Beställning VALUES (5, 5, '2019-09-12');
INSERT INTO Beställning VALUES (6, 7, '2019-09-17');
INSERT INTO Beställning VALUES (7, 2, '2019-08-28');
INSERT INTO Beställning VALUES (8, 4, '2019-12-30');
INSERT INTO Beställning VALUES (9, 5, '2019-12-18');
INSERT INTO Beställning VALUES (10, 1, '2018-12-01');


CREATE TABLE Beställningsvara (
    -- beställningsvara_id int NOT NULL AUTO_INCREMENT,
    beställning_id int NOT NULL,
    sko_id int NOT NULL,
    antal int NOT NULL,
    PRIMARY KEY (beställning_id, sko_id),
    FOREIGN KEY (beställning_id) REFERENCES Beställning (beställning_id) ON DELETE CASCADE,
    FOREIGN KEY (sko_id) REFERENCES Sko (sko_id) ON DELETE CASCADE
);
INSERT INTO Beställningsvara VALUES (1, 1, 2);
INSERT INTO Beställningsvara VALUES (1, 4, 1);
INSERT INTO Beställningsvara VALUES (1, 10, 1);
INSERT INTO Beställningsvara VALUES (2, 14, 2);
INSERT INTO Beställningsvara VALUES (2, 17, 3);
INSERT INTO Beställningsvara VALUES (3, 21, 1);
INSERT INTO Beställningsvara VALUES (4, 1, 2);
INSERT INTO Beställningsvara VALUES (4, 7, 1);
INSERT INTO Beställningsvara VALUES (5, 19, 2);
INSERT INTO Beställningsvara VALUES (5, 16, 1);
INSERT INTO Beställningsvara VALUES (6, 18, 1);
INSERT INTO Beställningsvara VALUES (7, 9, 1);
INSERT INTO Beställningsvara VALUES (8, 5, 2);
INSERT INTO Beställningsvara VALUES (8, 14, 3);
INSERT INTO Beställningsvara VALUES (8, 20, 1);
INSERT INTO Beställningsvara VALUES (9, 10, 3);
INSERT INTO Beställningsvara VALUES (9, 7, 2);
INSERT INTO Beställningsvara VALUES (9, 4, 1);
INSERT INTO Beställningsvara VALUES (10, 13, 1);
INSERT INTO Beställningsvara VALUES (10, 23, 2);


CREATE TABLE Betyg (
    betyg_id int NOT NULL AUTO_INCREMENT,
    betyg varchar(50) NOT NULL,
    PRIMARY KEY (Betyg_id)
);
INSERT INTO Betyg VALUES (1, 'Mycket nöjd');
INSERT INTO Betyg VALUES (2, 'Nöjd');
INSERT INTO Betyg VALUES (3, 'Ganska nöjd');
INSERT INTO Betyg VALUES (4, 'Missnöjd');


CREATE TABLE Recension (
    recension_id int NOT NULL AUTO_INCREMENT,
    kund_id int,
    sko_id int,
    betyg_id int,
    kommentar varchar(100),
    PRIMARY KEY (recension_id),
    FOREIGN KEY (kund_id) REFERENCES Kund (kund_id) ON DELETE SET NULL,
    FOREIGN KEY (sko_id) REFERENCES Sko (sko_id) ON DELETE SET NULL,
    FOREIGN KEY (betyg_id) REFERENCES Betyg (betyg_id) ON DELETE SET NULL
);

INSERT INTO Recension VALUES (1, 1, 1, 3, "Helt ok sandaler men inget speciellt");
INSERT INTO Recension VALUES (2, 2, 17, 1, "Bästa sneakers jag någonsin haft!");
INSERT INTO Recension VALUES (3, 1, 10, 2, "Älskar den röda färgen men sulan blir dock ibland lite obekväm");
INSERT INTO Recension VALUES (4, 3, 21, 4, "Helt värdelöst! Alldeles för dyrt för den skiten");
INSERT INTO Recension VALUES (5, 4, 1, 2, "Väldigt sköna för att vara billiga sandaler. Rekommenderar varmt");
