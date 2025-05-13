-- --------------------------------------------------------
-- 
-- Author:                       Diego Balaguer
-- Date:                         02/05/2025
-- Database:                     Universidad
--
-- Descripció:
--  Si us plau, descàrrega la base de dades del fitxer 
-- schema_universidad.sql, visualitza el diagrama E-R en un 
-- editor i efectua les següents consultes
-- --------------------------------------------------------


USE universidad;


-- 01. Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. 
--     El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.

SELECT apellido1, apellido2, nombre
FROM persona
WHERE tipo = 'alumno'
ORDER BY apellido1, apellido2, nombre;


-- 02. Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.

SELECT nombre, apellido1, apellido2
FROM persona
WHERE tipo = 'alumno' AND telefono IS NULL;


-- 03. Retorna el llistat dels alumnes que van néixer en 1999.

SELECT nombre, apellido1, apellido2
FROM persona
WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;


-- 04. Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.

SELECT nombre, apellido1, apellido2
FROM persona
WHERE tipo = 'profesor' AND telefono IS NULL AND UPPER(RIGHT(nif, 1)) = 'K';


-- 05. Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.

SELECT nombre
FROM asignatura
WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;


-- 06. Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar 
--     quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.

SELECT p.apellido1, p.apellido2, p.nombre, d.nombre nombre_dpto
FROM profesor pf
JOIN persona p ON pf.id_profesor = p.id
JOIN departamento d ON pf.id_departamento = d.id
ORDER BY  p.apellido1, p.apellido2, p.nombre;


-- 07. Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.

SELECT a.nombre, c.anyo_inicio, c.anyo_fin
FROM persona p
JOIN alumno_se_matricula_asignatura aa ON p.id = aa.id_alumno
JOIN asignatura a ON aa.id_asignatura = a.id
JOIN curso_escolar c ON aa.id_curso_escolar = c.id
WHERE p.nif = '26902806M';


-- 08. Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).

 SELECT d.nombre 
 FROM departamento d
 JOIN (
	SELECT DISTINCT pf.id_profesor
	FROM profesor pf
	JOIN asignatura a ON pf.id_profesor = a.id_profesor
	JOIN grado g ON a.id_grado = g.id
	WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)'
	) ff ON d.id = ff.id_profesor;


-- 09. Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.

SELECT p.nombre, p.apellido1, p.apellido2
FROM  persona p
WHERE p.id IN 
 (SELECT DISTINCT a.id_alumno 
		FROM alumno_se_matricula_asignatura a
		JOIN curso_escolar ce ON a.id_curso_escolar = ce.id
		WHERE ce.anyo_inicio = 2018 AND ce.anyo_fin = 2019 )
AND p.tipo = 'alumno';


-- --------------------------------------------------------
-- 
-- Author:                       Diego Balaguer
-- Date:                         02/05/2025
-- Database:                     Universidad
--
-- Descripció:
-- Resol les 6 següents consultes utilitzant les clàusules 
-- LEFT JOIN i RIGHT JOIN.
-- --------------------------------------------------------


USE universidad;


-- 01. Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. 
--     El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. El llistat ha de retornar quatre columnes, 
--     nom del departament, primer cognom, segon cognom i nom del professor/a. El resultat estarà ordenat alfabèticament 
--     de menor a major pel nom del departament, cognoms i el nom.

SELECT d.nombre nombre_dpto, p.apellido1, p.apellido2, p.nombre
FROM persona p
LEFT JOIN profesor pf ON p.id = pf.id_profesor
LEFT JOIN departamento d ON pf.id_departamento = d.id
WHERE p.tipo = 'profesor'
ORDER BY  d.nombre, p.apellido1, p.apellido2;


-- 02. Retorna un llistat amb els professors/es que no estan associats a un departament.

SELECT d.nombre nombre_dpto, p.apellido1, p.apellido2, p.nombre
FROM persona p
LEFT JOIN profesor pf ON p.id = pf.id_profesor
LEFT JOIN departamento d ON pf.id_departamento = d.id
WHERE p.tipo = 'profesor' AND d.id IS NULL
ORDER BY  p.apellido1, p.apellido2, p.nombre;


-- 03. Retorna un llistat amb els departaments que no tenen professors/es associats.

SELECT d.nombre nombre_dpto
FROM departamento d
LEFT JOIN profesor pf ON d.id = pf.id_departamento
WHERE pf.id_profesor IS NULL;


-- 04. Retorna un llistat amb els professors/es que no imparteixen cap assignatura.

SELECT p.apellido1, p.apellido2, p.nombre
FROM persona p
LEFT JOIN profesor pf ON p.id = pf.id_profesor
LEFT JOIN asignatura a ON pf.id_profesor = a.id_profesor
WHERE p.tipo = 'profesor' AND a.id IS NULL
ORDER BY  p.apellido1, p.apellido2, p.nombre;


-- 05. Retorna un llistat amb les assignatures que no tenen un professor/a assignat.

SELECT a.nombre
FROM asignatura a
LEFT JOIN profesor pf ON a.id_profesor = pf.id_profesor
WHERE pf.id_profesor IS NULL;


-- 06. Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.

SELECT dd.nombre
FROM departamento dd
WHERE dd.nombre NOT IN (
	SELECT DISTINCT d.nombre 
	FROM departamento d
	LEFT JOIN profesor pf ON d.id = pf.id_departamento
	LEFT JOIN asignatura a ON pf.id_profesor = a.id_profesor
	LEFT JOIN alumno_se_matricula_asignatura aa ON a.id = aa.id_asignatura
	LEFT JOIN curso_escolar ce ON aa.id_curso_escolar = ce.id
	WHERE ce.id IS NOT NULL);


-- --------------------------------------------------------
-- 
-- Author:                       Diego Balaguer
-- Date:                         02/05/2025
-- Database:                     Universidad
--
-- Descripció:
-- Consultes resum
-- --------------------------------------------------------


USE universidad;


-- 01. Retorna el nombre total d'alumnes que hi ha.

SELECT COUNT(*) numero_alumnos
FROM persona
WHERE tipo = 'alumno';


-- 02. Calcula quants alumnes van néixer en 1999.

SELECT COUNT(*) numero_alumnos_1999
FROM persona
WHERE YEAR(fecha_nacimiento) = 1999;


-- 03. Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del 
--     departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els 
--     departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.

SELECT d.nombre, COUNT(pf.id_profesor) num_profesores
FROM departamento d
JOIN profesor pf ON d.id = pf.id_departamento
GROUP BY d.nombre;


-- 04. Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Tingui en compte que poden 
--     existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat. 

SELECT d.nombre, COUNT(pf.id_profesor) num_profesores
FROM departamento d
LEFT JOIN profesor pf ON d.id = pf.id_departamento
GROUP BY d.nombre;


-- 05. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingues en 
--     compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat 
--     haurà d'estar ordenat de major a menor pel nombre d'assignatures.

SELECT g.nombre, COUNT(a.id) num_asignaturas
FROM grado g
LEFT JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.nombre
ORDER BY num_asignaturas DESC;


-- 06. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus 
--     que tinguin més de 40 assignatures associades.

SELECT g.nombre, COUNT(a.id) num_asignaturas
FROM grado g
LEFT JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.nombre
HAVING num_asignaturas > 40
ORDER BY num_asignaturas DESC;


-- 07. Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat 
--     ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.

SELECT g.nombre, a.tipo tipo_asignatura, SUM(a.creditos) suma_creditos
FROM grado g
LEFT JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.nombre, a.tipo
ORDER BY g.nombre, a.tipo;


-- 08. Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de 
--     mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.

SELECT ce.anyo_inicio cursos_escolares, COUNT(distinct(aa.id_alumno)) alumnos
FROM curso_escolar ce
LEFT JOIN alumno_se_matricula_asignatura aa ON ce.id = aa.id_curso_escolar
GROUP BY ce.anyo_inicio;


-- 09. Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es 
--     que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. 
--     El resultat estarà ordenat de major a menor pel nombre d'assignatures.

SELECT p.id, p.nombre, p.apellido1, p.apellido2, COUNT(a.id) num_asignaturas
FROM persona p
LEFT JOIN asignatura a ON p.id = a.id_profesor
WHERE p.tipo = 'profesor'
GROUP BY p.id, p.nombre, p.apellido1, p.apellido2
ORDER BY num_asignaturas DESC;


-- 10. Retorna totes les dades de l'alumne/a més jove.

SELECT p.*
FROM persona p
WHERE p.tipo = 'alumno' AND p.fecha_nacimiento = (SELECT MAX(pp.fecha_nacimiento) FROM persona pp WHERE pp.tipo = 'alumno');


-- 11. Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.

SELECT p.id, p.nombre, p.apellido1, p.apellido2
FROM persona p
JOIN profesor pf ON p.id = pf.id_profesor
LEFT JOIN departamento d ON pf.id_departamento = d.id
LEFT JOIN asignatura a ON pf.id_profesor = a.id_profesor
WHERE p.tipo = 'profesor' AND d.id IS NOT NULL AND a.id IS NULL 
ORDER BY p.id;
