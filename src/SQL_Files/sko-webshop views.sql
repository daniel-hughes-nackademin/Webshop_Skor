-- Antal produkter per kategori
CREATE OR REPLACE VIEW category_count AS
SELECT
  kat.kategori AS Kategori,
  COUNT(s.sko_id) AS Antal
FROM Kategori kat
LEFT JOIN LT_SkoKategori sk USING (kategori_id)
LEFT JOIN Sko s ON sk.sko_id = s.sko_id
GROUP BY kat.kategori
ORDER BY Antal DESC;


-- Lista Kund och hur mycket de handlat för
CREATE OR REPLACE VIEW customer_shopping AS
SELECT
	k.förnamn AS Förnamn,
    k.efternamn AS Efternamn,
    COALESCE(SUM(s.pris*bv.antal), 0) AS Handlat_För
FROM Kund k
LEFT JOIN Beställning b USING (kund_id)
LEFT JOIN Beställningsvara bv ON b.beställning_id = bv.beställning_id
LEFT JOIN Sko s ON s.sko_id = bv.sko_id
GROUP BY (kund_id)
ORDER BY Handlat_För DESC;


-- Vilka kunder har köpt svarta sandaler, storlek 38 av märket Ecco?
SELECT
    CONCAT(k.förnamn, ' ', k.efternamn) AS Kund_Namn,
    s.sko_id AS Köpt_Sko_ID,
    stl.eu AS 'Storlek (EU)',
    s.färg AS Färg,
    m.märke AS Märke,
	kat.kategori
FROM Kund k
JOIN Beställning b USING (kund_id)
JOIN Beställningsvara bv ON b.beställning_id = bv.beställning_id
JOIN Sko s ON s.sko_id = bv.sko_id
JOIN Storlek stl ON s.storlek_id = stl.storlek_id
JOIN Märke m ON s.märke_id = m.märke_id
JOIN LT_SkoKategori sk ON s.sko_id = sk.sko_id
JOIN Kategori kat ON sk.kategori_id = kat.kategori_id
-- WHERE s.sko_id = 1;
WHERE stl.eu = 38 AND s.färg = 'Svart' AND m.märke = 'Ecco' AND kat.kategori = 'Sandaler';


-- Lista beställningsvärde per ort där beställningsvärde är över 1000
CREATE OR REPLACE VIEW city_sales AS
SELECT
    o.ort AS Ort,
    SUM(s.pris * bv.antal) AS Beställningsvärde
FROM Beställning b
JOIN Kund k USING (kund_id)
JOIN Ort o ON k.ort_id = o.ort_id
JOIN Beställningsvara bv USING (beställning_id)
JOIN Sko s ON bv.sko_id = s.sko_id
GROUP BY Ort
-- HAVING Beställningsvärde >= 1000
ORDER BY Beställningsvärde DESC;

-- Top 5 mest sålda produkter
CREATE OR REPLACE VIEW top5_products AS
SELECT
    s.sko_id AS Köpt_Sko_ID,
    mo.modell AS Modell,
    stl.eu AS 'Storlek (EU)',
    s.färg AS Färg,
    m.märke AS Märke,
    GROUP_CONCAT(DISTINCT kat.kategori ORDER BY kategori ASC SEPARATOR ' - ') AS Kategorier,
    SUM(bv.antal) AS 'Antal Sålda'
FROM Sko s
JOIN Modell mo USING (modell_id)
JOIN Storlek stl USING (storlek_id)
JOIN Märke m USING (märke_id)
JOIN Beställningsvara bv USING (sko_id)
JOIN LT_SkoKategori sk USING (sko_id)
JOIN Kategori kat ON sk.Kategori_id = kat.kategori_id
GROUP BY s.sko_id
ORDER BY SUM(bv.antal) DESC
LIMIT 5;

-- Vilken månad hade störst försäljning?
CREATE OR REPLACE VIEW monthly_sales AS
SELECT
		MONTHNAME(b.datum) AS Månad,
		YEAR(b.datum) AS År,
        SUM(bv.antal*s.pris) AS Försäljning
FROM Beställningsvara bv
JOIN Beställning b USING (beställning_id)
JOIN Sko s USING (sko_id)
GROUP BY EXTRACT(YEAR_MONTH FROM b.datum)
ORDER BY Försäljning DESC
-- LIMIT 1
;
