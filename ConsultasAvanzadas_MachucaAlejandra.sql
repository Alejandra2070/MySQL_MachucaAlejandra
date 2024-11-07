USE universidad_T2;

-- Devuelve un listado con el primer apellido, segundo apellido y el nombre de todos los alumnos.
-- El listado deberá estar ordenado alfabéticamente de menor a mayor por el primer apellido, segundo apellido y nombre.
SELECT apellido1 AS Apellido_1,apellido2 AS Apellido_2,nombre AS Nombre FROM alumno ORDER BY 1,2,3 ASC;

-- Averigua el nombre y los dos apellidos de los alumnos que no han dado de alta su número de teléfono en la base de datos.
-- SELECT * FROM alumno;

SELECT nombre,apellido1,apellido2 FROM alumno WHERE telefono IS NULL;

-- Devuelve el listado de las asignaturas que se imparten en el primer cuatrimestre, en el tercer curso del grado que tiene el identificador 7.
-- SELECT * FROM asignatura;
-- SELECT * FROM grado;
SELECT * FROM asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;

-- Devuelve un listado con todas las asignaturas ofertadas en el Grado en Ingeniería Informática (Plan 2015)
SELECT * FROM asignatura INNER JOIN grado ON asignatura.id_grado = grado.id WHERE grado.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

SELECT * FROM alumno al INNER JOIN alumno_se_matricula_asignatura asm ON al.id = asm.id_alumno INNER JOIN asignatura a ON asm.id_asignatura = a.id INNER JOIN curso_escolar ce ON ce.id = asm.id_curso_escolar WHERE ce.anyo_inicio = '2017' AND ce.anyo_fin = '2018';

-- Devuelve un listado con todos los alumnos que se han matriculado en alguna asignatura durante el curso escolar 2017/2018
SELECT * FROM asignatura;
SELECT * FROM alumno INNER JOIN asignatura ON asignatura;



-- Trabajo Asignado

SELECT COUNT(sexo) FROM alumno WHERE sexo = 'M'; -- 1. Devuelve el número total de alumnas que hay.
SELECT COUNT(fecha_nacimiento) as Cantidad FROM alumno where year (fecha_nacimiento) = 1999; -- 2. Calcula cuántos alumnos nacieron en 1999.
SELECT departamento.nombre as Departamento, COUNT(profesor.id_departamento) as cantidad_profesores from profesor INNER JOIN departamento on profesor.id_departamento = departamento.id GROUP BY departamento.nombre ORDER BY cantidad_profesores DESC;  -- 3. Calcula cuántos profesores hay en cada departamento. El resultado sólo debe mostrar dos columnas, una con el nombre del departamento y otra con el número de profesores que hay en ese departamento. El resultado sólo debe incluir los departamentos que tienen profesores asociados y deberá estar ordenado de mayor a menor por el número de profesores.
SELECT departamento.nombre, COUNT(profesor.id_departamento) AS 'Cantidad_profesores' FROM departamento LEFT JOIN profesor ON profesor.id_departamento = departamento.id GROUP BY departamento.nombre; -- 4. Devuelve un listado con todos los departamentos y el número de profesores que hay en cada uno de ellos. Tenga en cuenta que pueden existir departamentos que no tienen profesores asociados. Estos departamentos también tienen que aparecer en el listado.
SELECT grado.nombre, COUNT(asignatura.id) AS 'Cantidad_asignaturas' FROM grado LEFT JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre ORDER BY 2 DESC; -- 5. Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno. Tenga en cuenta que pueden existir grados que no tienen asignaturas asociadas. Estos grados también tienen que aparecer en el listado. El resultado deberá estar ordenado de mayor a menor por el número de asignaturas.
SELECT grado.nombre, COUNT(asignatura.id) AS 'Cantidad_asignaturas' FROM grado INNER JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre HAVING COUNT(asignatura.id) > 40; -- 6. Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno, de los grados que tengan más de 40 asignaturas asociadas.
-- 7. Devuelve un listado que muestre el nombre de los grados y la suma del número total de créditos que hay para cada tipo de asignatura. El resultado debe tener tres columnas: nombre del grado, tipo de asignatura y la suma de los créditos de todas las asignaturas que hay de ese tipo. Ordene el resultado de mayor a menor por el número total de crédidos.
-- 8. Devuelve un listado que muestre cuántos alumnos se han matriculado de alguna asignatura en cada uno de los cursos escolares. El resultado deberá mostrar dos columnas, una columna con el año de inicio del curso escolar y otra con el número de alumnos matriculados.
-- 9. Devuelve un listado con el número de asignaturas que imparte cada profesor. El listado debe tener en cuenta aquellos profesores que no imparten ninguna asignatura. El resultado mostrará cinco columnas: id, nombre, primer apellido, segundo apellido y número de asignaturas. El resultado estará ordenado de mayor a menor por el número de asignaturas.