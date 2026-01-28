CREATE TABLE users (
	name VARCHAR(10) UNIQUE
);

--auto COMMIT;

INSERT INTO
  users (name)
VALUES
  ('Ximena2');
  
UPDATE users
SET
  name = 'Alberto'
WHERE
  name = 'Andony';


SELECT * from users
LIMIT 3
OFFSET 1;

SELECT * from users
WHERE name = 'Andony';

SELECT * from users
WHERE name LIKE 'Xi%';

DELETE from users WHERE name LIKE 'Ximena_';

DROP TABLE users;

TRUNCATE TABLE users;


select 
	id, 
	upper(name) as upper_name, 
	lower(name) as lower_name, 
	LENGTH(name) as LENGTH,
	(20*3) as constante,
	concat('*', id, '-', name, '*') as concatenado,
	'*'||id||'-'||name||'*' as concatenado_con_tubo,
	name 
from users;


select 
	name, 
	SUBSTRING( name, 0, 5) as nombre,
	POSITION( 'E' in name) as posicion
from 
	users;

select 
	name, 
	SUBSTRING( name, 0, POSITION( ' ' in name)) as first_name,
	SUBSTRING( name, POSITION( ' ' in name) + 1) as last_name,	
	TRIM(SUBSTRING( name, POSITION( ' ' in name))) as last_name
from 
	users;
	

UPDATE users
SET 
	first_name = SUBSTRING( name, 0, POSITION( ' ' in name)), 
	last_name = SUBSTRING( name, POSITION( ' ' in name) + 1);
	
SELECT * from users;

-- Nombre, apellido y seguidores(followers) de todos a los que lo siguen más de 4600 personas
SELECT first_name, last_name, followers FROM users WHERE followers > 4600;

SELECT
  first_name,
  last_name,
  followers
FROM
  users
WHERE
  followers > 4600
  AND followers < 4700
ORDER BY followers ASC;

SELECT
  first_name,
  last_name,
  followers
FROM
  users
WHERE
  followers > 4600
  AND followers < 4700
ORDER BY followers DESC;

SELECT
  first_name,
  last_name,
  followers
FROM
  users
WHERE
  followers BETWEEN 4601 AND 4699
ORDER BY followers ASC;

SELECT
  COUNT(*) AS total_users,
  MIN(followers) as min_followers,    -- valor mininimo de una columna
  MAX(followers) as max_followers,    -- valor maximo de una columna
  AVG(followers) as promedio,          -- valor promedio de una columna
  ROUND(AVG(followers)) as promedio_redondeado,          -- valor promedio REDONDEADO de una columna
  SUM(followers)/COUNT(*) as promedio          -- valor promedio de una columna
FROM
  users;
  
SELECT
  first_name,
  last_name,
  followers
FROM
  users
WHERE
  followers = 4
  or followers = 4999
ORDER BY followers ASC;

SELECT
  first_name,
  last_name,
  followers
FROM
  users
WHERE
  followers = 4
  or followers = 4999
ORDER BY followers ASC;


-- GROUP BY --
SELECT
  count(*) as numero_users,
  followers
FROM
  users
WHERE
  followers = 4
  or followers = 4999
GROUP BY
  followers;
  
SELECT
  count(*) as numero_users,
  followers
FROM
  users
WHERE
  followers BETWEEN 4000 and 4999
GROUP BY
  followers
  ORDER BY followers ASC;
  
  
-- HAVING --
SELECT * FROM users;

SELECT
  count(*) as personas_por_pais,
  country
FROM
  users
GROUP BY
  country
HAVING
  COUNT(*) > 5
ORDER BY
  COUNT(*) DESC;
  
SELECT
  count(*) as personas_por_pais,
  country
FROM
  users
GROUP BY
  country
HAVING
  COUNT(*) BETWEEN 1 and 5
ORDER BY
  COUNT(*) DESC;
  
  
-- DISTINCT --
SELECT DISTINCT country from users order by country asc;


-- GROUP BY --
SELECT
  email,
  SUBSTRING(email, POSITION('@' in email) + 1) as domain
from
  users;
  
SELECT
  COUNT(*),
  SUBSTRING(email, POSITION('@' in email) + 1) as domain
from
  users
GROUP BY SUBSTRING(email, POSITION('@' in email) + 1)
HAVING COUNT(*) > 1;


-- SUBQUERIES --
SELECT
  *
FROM
  (
    SELECT
      COUNT(*),
      SUBSTRING(email, POSITION('@' in email) + 1) as domain
    from
      users
    GROUP BY
      SUBSTRING(email, POSITION('@' in email) + 1)
    HAVING
      COUNT(*) > 1
  ) as email_domains;

SELECT
  sum(total)
FROM
  (
    SELECT
      COUNT(*) as total,
      SUBSTRING(email, POSITION('@' in email) + 1) as domain
    from
      users
    GROUP BY
      SUBSTRING(email, POSITION('@' in email) + 1)
    HAVING
      COUNT(*) > 1
  ) as email_domains;









--------------------------- QUERIES FOR SECTION 5 ---------------------------
SELECT * FROM country ORDER BY continent ASC;

ALTER TABLE country
ADD PRIMARY KEY (code);     -- This command is to add a primary key to the table

SELECT * FROM country WHERE code = 'NLD';

SELECT * FROM country WHERE code2 = 'NA' AND code = 'NLD';

DELETE FROM country WHERE code2 = 'NA' AND code = 'NLD';

ALTER TABLE country
add CHECK (surfacearea >= 0);

SELECT DISTINCT
  continent
from
  country;
  
-- Add a constraint to avoid adding rows with non valid continents
ALTER TABLE country ADD CHECK(
	(continent = 'Asia'::text) OR 
	(continent = 'South America'::text) OR 
	(continent = 'North America'::text) OR 
	(continent = 'Oceania'::text) OR 
	(continent = 'Antarctica'::text) OR 
	(continent = 'Africa'::text) OR 
	(continent = 'Europe'::text)
);

SELECT * FROM country WHERE region = 'Central America';

  
-- Add a new contraint to an existing contraint. To do this, we need to delete the existing constraint
ALTER TABLE country DROP CONSTRAINT "country_continent_check";

-- Later apply the new full constraint
ALTER TABLE country ADD CHECK(
	(continent = 'Asia'::text) OR 
	(continent = 'South America'::text) OR 
	(continent = 'North America'::text) OR 
	(continent = 'Oceania'::text) OR 
	(continent = 'Antarctica'::text) OR 
	(continent = 'Africa'::text) OR 
	(continent = 'Europe'::text) OR 
	(continent = 'Central America'::text)
);

-- Update data
UPDATE country
SET
  continent = 'Central America'
WHERE
  region = 'Central America';
  
-- Indexes: they are used to increase the speed of queries
CREATE UNIQUE INDEX "unique_country_name" on country (name);   -- Add UNIQUE if it is unique

SELECT * FROM country WHERE continent = 'Africa';

CREATE INDEX "country_continent" on country (continent);



SELECT * FROM city;

CREATE UNIQUE INDEX "unique_name_countrycode_district" on city (name, countrycode, district);

SELECT * FROM city WHERE name='Jinzhou' and countrycode = 'CHN' and district = 'Liaoning';

CREATE INDEX "index_district" on city (district);


-- Create Foreing keys
ALTER TABLE city ADD CONSTRAINT fk_country_code FOREIGN KEY (countrycode) REFERENCES country (code);  -- To add the foreing key, we need to ensure that all keys in child exist in parent (foreing keys). in this case, there is no AFG in country table

SELECT * FROM country WHERE code = 'AFG';
SELECT * FROM city WHERE countrycode = 'AFG';

INSERT INTO country
		values('AFG', 'Afghanistan', 'Asia', 'Southern Asia', 652860, 1919, 40000000, 62, 69000000, NULL, 'Afghanistan', 'Totalitarian', NULL, NULL, 'AF');  -- It created Afganistan

-- Add foreing key in countrylanguage table
SELECT * FROM countrylanguage;
ALTER TABLE countrylanguage ADD CONSTRAINT fk_country_code FOREIGN KEY (countrycode) REFERENCES country (code);

SELECT * from country WHERE code = 'AFG';
SELECT * from city WHERE countrycode = 'AFG';

DELETE FROM country WHERE code = 'AFG';  -- If we try to delete a row, but it is from a table that has foreing keys attached, it won't be possible, because other tables depends on that row

ALTER TABLE city DROP CONSTRAINT fk_country_code;  -- Delete existing constraint
ALTER TABLE countrylanguage DROP CONSTRAINT fk_country_code;    -- Delete existing constraint

ALTER TABLE city     
ADD CONSTRAINT fk_country_code
FOREIGN KEY (countrycode)
REFERENCES country(code)
ON DELETE CASCADE; -- Recreate existing constraint with CASCADE

ALTER TABLE countrylanguage     
ADD CONSTRAINT fk_country_code
FOREIGN KEY (countrycode)
REFERENCES country(code)
ON DELETE CASCADE; -- Recreate existing constraint with CASCADE

DELETE FROM country WHERE code = 'AFG';   -- Try again to delete that row

SELECT * FROM country WHERE code = 'AFG';
SELECT * FROM city WHERE countrycode = 'AFG';
SELECT * FROM countrylanguage WHERE countrycode = 'AFG';