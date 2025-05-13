-- --------------------------------------------------------
-- 
-- Author:                       Diego Balaguer
-- Date:                         02/05/2025
-- Database:                     Tienda
--
-- Descripció:
--  Tenim les taules producto i fabricador, cadascuna amb 
-- els següents camps:
--  - producto (codigo, nombre, precio, codigo_fabricante)
--  - fabricante (codigo, nombre)
--  El camp 'codigo_fabricante' de l'entitat producto es 
-- relaciona amb el camp 'codi' de l'entitat fabricante.
-- --------------------------------------------------------


USE tienda;


-- 01. Llista el nom de tots els productes que hi ha en la taula producto.
SELECT nombre
FROM producto;


-- 02. Llista els noms i els preus de tots els productes de la taula producto.
SELECT nombre, precio
FROM producto;


-- 03. Llista totes les columnes de la taula producto.
SELECT *
FROM producto;


-- 04. Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD).

SELECT nombre, precio precio_EUR, ROUND(precio * 1.08, 2) precio_USD
FROM producto;


-- 05. Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD). Utilitza els següents àlies per a les columnes: nom de producto, euros, dòlars.

SELECT nombre nombre_de_producto, precio euros, ROUND(precio * 1.08, 2) dolars
FROM producto;


-- 06. Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a majúscula.

SELECT UPPER(nombre) nombre, precio
FROM producto;


-- 07. Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a minúscula.

SELECT LOWER(nombre) nombre, precio
FROM producto;


-- 08. Llista el nom de tots els fabricants en una columna, i en una altra columna obtingui en majúscules els dos primers caràcters del nom del fabricant.

SELECT nombre, RIGHT(UPPER(nombre),2) upper_fabricante
FROM fabricante;


-- 09. Llista els noms i els preus de tots els productes de la taula producto, arrodonint el valor del preu.

SELECT nombre, ROUND(precio, 0) precio
FROM producto;


-- 10. Llista els noms i els preus de tots els productes de la taula producto, truncant el valor del preu per a mostrar-lo sense cap xifra decimal.

SELECT nombre, TRUNCATE(precio, 0) precio
FROM producto;


-- 11. Llista el codi dels fabricants que tenen productes en la taula producto.

SELECT DISTINCT f.codigo
FROM fabricante f
JOIN producto p ON f.codigo = p.codigo_fabricante;


-- 12. Llista el codi dels fabricants que tenen productes en la taula producto, eliminant els codis que apareixen repetits.

SELECT DISTINCT f.codigo
FROM fabricante f
JOIN producto p ON f.codigo = p.codigo_fabricante;


-- 13. Llista els noms dels fabricants ordenats de manera ascendent.

SELECT nombre
FROM fabricante
ORDER BY nombre;


-- 14. Llista els noms dels fabricants ordenats de manera descendent.

SELECT nombre
FROM fabricante
ORDER BY nombre DESC;


-- 15. Llista els noms dels productes ordenats, en primer lloc, pel nom de manera ascendent i, en segon lloc, pel preu de manera descendent.

SELECT nombre, precio
FROM producto
ORDER BY nombre, precio DESC;


-- 16. Retorna una llista amb les 5 primeres files de la taula fabricante.

SELECT *
FROM fabricante
LIMIT 5;


-- 17. Retorna una llista amb 2 files a partir de la quarta fila de la taula fabricante. La quarta fila també s'ha d'incloure en la resposta.

SELECT *
FROM fabricante
LIMIT 2 OFFSET 3;


-- 18. Llista el nom i el preu del producte més barat. (Utilitza solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MIN(preu), necessitaria GROUP BY.

SELECT nombre, precio
FROM producto
ORDER BY precio
LIMIT 1;


-- 19. Llista el nom i el preu del producte més car. (Utilitza solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MAX(preu), necessitaria GROUP BY.

SELECT nombre, precio
FROM producto
ORDER BY precio DESC
LIMIT 1;


-- 20. Llista el nom de tots els productes del fabricant el codi de fabricant del qual és igual a 2.

SELECT nombre
FROM producto
WHERE codigo_fabricante = 2;


-- 21. Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades.

SELECT p.nombre nombre_producto, f.nombre nombre_fabricante, p.precio
FROM producto p
LEFT JOIN fabricante f ON p.codigo_fabricante = f.codigo;


-- 22. Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades. Ordena el resultat pel nom del fabricant, per ordre alfabètic.

SELECT p.nombre nombre_producto, f.nombre nombre_fabricante, p.precio
FROM producto p
LEFT JOIN fabricante f ON p.codigo_fabricante = f.codigo
ORDER BY f.nombre;


-- 23. Retorna una llista amb el codi del producte, nom del producte, codi del fabricador i nom del fabricador, de tots els productes de la base de dades.

SELECT p.codigo cod_producto, p.nombre nombre_producto, f.codigo codigo_fabricante, f.nombre nombre_fabricante
FROM producto p
LEFT JOIN fabricante f ON p.codigo_fabricante = f.codigo;


-- 24. Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més barat.

SELECT p.nombre nombre_producto, f.nombre nombre_fabricante, p.precio
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
ORDER BY p.precio
LIMIT 1;

SELECT p.nombre nombre_producto, f.nombre nombre_fabricante, p.precio
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE p.precio = (SELECT MIN(pp.precio) FROM producto pp)
ORDER BY p.precio;


-- 25. Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més car.

SELECT p.nombre nombre_producto, f.nombre nombre_fabricante, p.precio
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
ORDER BY p.precio DESC
LIMIT 1;


-- 26. Retorna una llista de tots els productes del fabricant Lenovo.

SELECT p.nombre nombre_producto
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre ='Lenovo';


-- 27. Retorna una llista de tots els productes del fabricant Crucial que tinguin un preu major que 200 €.

SELECT p.nombre nombre_producto, f.nombre nombre_fabricante, p.precio
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre ='Crucial' AND p.precio > 200;


-- 28. Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packardy Seagate. Sense utilitzar l'operador IN.

SELECT p.nombre nombre_producto, f.nombre nombre_fabricante, p.precio
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre ='Asus' OR f.nombre = 'Hewlett-Packard' OR f.nombre = 'Seagate';


-- 29. Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packardy Seagate. Fent servir l'operador IN.

SELECT p.nombre nombre_producto, f.nombre nombre_fabricante, p.precio
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');


-- 30. Retorna un llistat amb el nom i el preu de tots els productes dels fabricants el nom dels quals acabi per la vocal e.

SELECT p.nombre nombre_producto, f.nombre nombre_fabricante, p.precio
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE LOWER(right(f.nombre, 1)) = 'e';


-- 31. Retorna un llistat amb el nom i el preu de tots els productes el nom de fabricant dels quals contingui el caràcter w en el seu nom.

SELECT p.nombre nombre_producto, f.nombre nombre_fabricante, p.precio
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE LOWER(f.nombre) LIKE '%e%';


-- 32. Retorna un llistat amb el nom de producte, preu i nom de fabricant, de tots els productes que tinguin un preu major o igual a 180 €. 
--     Ordena el resultat, en primer lloc, pel preu (en ordre descendent) i, en segon lloc, pel nom (en ordre ascendent).

SELECT p.nombre nombre_producto, f.nombre nombre_fabricante, p.precio
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE p.precio >= 180
ORDER BY p.precio DESC, p.nombre;


-- 33. Retorna un llistat amb el codi i el nom de fabricant, solament d'aquells fabricants que tenen productes associats en la base de dades.

SELECT DISTINCT f.codigo, f.nombre
FROM fabricante f
INNER JOIN producto p ON f.codigo = p.codigo_fabricante;		


-- 34. Retorna un llistat de tots els fabricants que existeixen en la base de dades, juntament amb els productes que té cadascun d'ells. 
--     El llistat haurà de mostrar també aquells fabricants que no tenen productes associats.

SELECT f.codigo cod_fabricante, f.nombre nombre_fabricante, p.codigo cod_producto, p.nombre nombre_producto
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante;


-- 35. Retorna un llistat on només apareguin aquells fabricants que no tenen cap producte associat.

SELECT f.codigo cod_fabricante, f.nombre nombre_fabricante, p.codigo cod_producto, p.nombre nombre_producto
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante
WHERE p.codigo IS NULL;


-- 36. Retorna tots els productes del fabricador Lenovo. (Sense utilitzar INNER JOIN).

SELECT p.codigo, p.nombre
FROM producto p
WHERE p.codigo_fabricante = (SELECT f.codigo FROM fabricante f WHERE f.nombre = 'Lenovo');


-- 37. Retorna totes les dades dels productes que tenen el mateix preu que el producte més car del fabricant Lenovo. (Sense usar INNER JOIN).

SELECT p.*
FROM producto p
WHERE p.precio = (
    SELECT MAX(pp.precio)
    FROM producto pp
    WHERE pp.codigo_fabricante = (SELECT f.codigo FROM fabricante f WHERE f.nombre = 'Lenovo'));


-- 38. Llista el nom del producte més car del fabricant Lenovo.

SELECT p.nombre
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre ='Lenovo'
ORDER BY precio DESC
LIMIT 1;


-- 39. Llista el nom del producte més barat del fabricant Hewlett-Packard.

SELECT p.nombre
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre ='Hewlett-Packard'
ORDER BY precio
LIMIT 1;


-- 40. Retorna tots els productes de la base de dades que tenen un preu major o igual al producte més car del fabricant Lenovo.

SELECT p.nombre
FROM producto p
WHERE p.precio >= (
   SELECT MAX(pp.precio)
   FROM producto pp
   JOIN fabricante f ON pp.codigo_fabricante = f.codigo
	WHERE f.nombre ='Lenovo');


-- 41. Llesta tots els productes del fabricant Asus que tenen un preu superior al preu mitjà de tots els seus productes.
 
SELECT p.nombre
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre ='Asus'AND p.precio > 
	(SELECT AVG(pp.precio)
    FROM producto pp
    WHERE pp.codigo_fabricante = p.codigo_fabricante);

