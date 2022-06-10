
#Systems with small planets

SELECT s.radius AS sun_radius,
  p.radius AS planet_radius
FROM Star AS s, Planet AS p
WHERE s.kepler_id = p.kepler_id AND
  s.radius > p.radius
ORDER BY S.radius DESC;


#How many planets for big stars

SELECT Star.radius, COUNT(Planet.koi_name)
FROM Star
JOIN Planet USING (kepler_id)
WHERE Star.radius >= 1
GROUP BY Star.kepler_id
HAVING COUNT(Planet.koi_name) > 1
ORDER BY Star.radius DESC;


#Lonely stars

SELECT s.kepler_id, s.t_eff, s.radius
FROM Star AS s
LEFT OUTER JOIN Planet AS p USING (kepler_id)
WHERE p.koi_name is NULL
ORDER BY t_eff DESC;

#Subquery join

SELECT ROUND(AVG(P.t_eq), 1), MIN(S.t_eff), MAX(S.t_eff)
FROM Star S
JOIN Planet P USING(kepler_id)
WHERE S.t_eff > (
  SELECT AVG(t_eff) FROM Star
);

#Correlated sizes

SELECT p.koi_name, p.radius, s.radius
FROM Star AS s
JOIN Planet AS p USING (kepler_id)
WHERE s.kepler_id IN (
  SELECT kepler_id
  FROM Star
  ORDER BY radius DESC
  LIMIT 5
);

#Adding stars

INSERT INTO Star (kepler_id, t_eff, radius) VALUES
(7115384, 3789, 27.384),
(8106973, 5810, 0.811),
(9391817, 6200, 0.958);


#Update table

UPDATE Planet
 SET kepler_name = NULL
 WHERE UPPER(status) != 'CONFIRMED';


DELETE FROM Planet
 WHERE radius < 0;


#Creating a new table

CREATE TABLE Planet (
  kepler_id INTEGER NOT NULL,
  koi_name VARCHAR(15) NOT NULL UNIQUE,
  kepler_name VARCHAR(15),
  status VARCHAR(20) NOT NULL,
  radius FLOAT NOT NULL
);

INSERT INTO Planet
(kepler_id, koi_name, kepler_name, status, radius)
 VALUES(6862328, 'K00865.01', NULL, 'CANDIDATE', 119.021);
 
INSERT INTO Planet
 (kepler_id, koi_name, kepler_name, status, radius)
 VALUES(10187017, 'K00082.05', 'Kepler-102 b', 'CONFIRMED', 5.286);
 
INSERT INTO Planet
 (kepler_id, koi_name, kepler_name, status, radius)
 VALUES(10187017, 'K00082.04', 'Kepler-102 c', 'CONFIRMED', 7.071);
 
 
 CREATE TABLE Star (
   kepler_id INTEGER PRIMARY KEY,
   t_eff INTEGER NOT NULL,
   radius FLOAT NOT NULL
 );


#DIY Exoplanet archive

 CREATE TABLE Planet (
   kepler_id INTEGER REFERENCES Star(Kepler_ID),
   koi_name VARCHAR(20) PRIMARY KEY,
   kepler_name VARCHAR(20),
   status VARCHAR(20) NOT NULL,
   period FLOAT,
   radius FLOAT,
   t_eq INTEGER
 );

 COPY Star (kepler_id, t_eff, radius) FROM 'stars.csv' CSV;
 COPY Planet (kepler_id, koi_name, kepler_name, status, period, radius, t_eq) FROM 'planets.csv' CSV;
 
 
 #Star coordinates
 
 ALTER TABLE Star
  ADD COLUMN ra FLOAT,
  ADD COLUMN decl FLOAT;

 DELETE FROM Star;

 COPY Star (kepler_id, t_eff, radius, ra, decl) FROM 'stars_full.csv' CSV;
