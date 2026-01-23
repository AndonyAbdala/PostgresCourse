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
