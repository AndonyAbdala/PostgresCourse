-- 1. Crear una llave primaria en city (id)
SELECT * FROM city;

SELECT
  count(*) as total,
  id
from
  city
GROUP BY
  id
HAVING count(*) > 1;

SELECT * FROM city WHERE name = 'Manzanillo';

ALTER TABLE city
ADD PRIMARY KEY (id);

-- 2. Crear un check en population, para que no soporte negativos
SELECT * FROM city WHERE population < 0;

ALTER TABLE city ADD CHECK (population >= 0);


-- 3. Crear una llave primaria compuesta en "countrylanguage"
-- los campos a usar como llave compuesta son countrycode y language
SELECT * FROM countrylanguage;

ALTER TABLE countrylanguage ADD PRIMARY KEY (countrycode, language);


-- 4. Crear check en percentage, 
-- Para que no permita negativos ni números superiores a 100
ALTER TABLE countrylanguage ADD CHECK (percentage BETWEEN 0 AND 100);