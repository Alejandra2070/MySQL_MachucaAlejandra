USE universidad_T2;

SELECT * FROM alumno WHERE alumno.fecha_nacimiento = (SELECT MAX(fecha_nacimiento) FROM alumno); -- 1.Devuelve todos los datos del alumno más joven.

SELECT * FROM profesor WHERE id_departamento IS NULL; -- 2.Devuelve un listado con los profesores que no están asociados a un departamento.

SELECT departamento.nombre FROM departamento WHERE departamento.id NOT IN (SELECT DISTINCT profesor.id_departamento FROM profesor); -- 3.Devuelve un listado con los departamentos que no tienen profesores asociados.

SELECT profesor.* FROM profesor LEFT JOIN asignatura ON asignatura.id_profesor = profesor.id WHERE asignatura.id_profesor IS NULL; -- 4.Devuelve un listado con los profesores que tienen un departamento asociado y que no imparten ninguna asignatura.

SELECT * FROM asignatura WHERE id_profesor is NULL; -- 5.Devuelve un listado con las asignaturas que no tienen un profesor asignado.

SELECT departamento.nombre, asignatura.nombre FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento
INNER JOIN asignatura ON profesor.id = asignatura.id_profesor LEFT JOIN alumno_se_matricula_asignatura asma ON asignatura.id = asma.id_asignatura
LEFT JOIN curso_escolar ON asma.id_curso_escolar != curso_escolar.id; -- 6.Devuelve un listado con todos los departamentos que no han impartido asignaturas en ningún curso escolar.

SELECT DISTINCT departamento.* FROM departamento INNER JOIN profesor ON departamento.id = profesor.id_departamento INNER JOIN asignatura ON profesor.id = asignatura.id_profesor INNER JOIN grado ON asignatura.id_grado = grado.id WHERE grado.nombre = "Grado en Ingeniería Informática (Plan 2015)" ; -- 7. Devuelve un listado con el nombre de todos los departamentos que tienen profesores que imparten alguna asignatura en el Grado en Ingeniería Informática (Plan 2015).

SELECT departamento.nombre AS nombre_departamento, profesor.apellido1,profesor.apellido2,profesor.nombre FROM profesor 
INNER JOIN departamento ON profesor.id_departamento = departamento.id 
ORDER BY nombre_departamento, profesor.apellido1,profesor.apellido2,profesor.nombre ASC; -- 8. Devuelve un listado con los nombres de todos los profesores y los departamentos que tienen vinculados. 
-- El listado también debe mostrar aquellos profesores que no tienen ningún departamento asociado. 
-- El listado debe devolver cuatro columnas, nombre del departamento, primer apellido, segundo apellido y nombre del profesor. 
-- El resultado estará ordenado alfabéticamente de menor a mayor por el nombre del departamento, apellidos y el nombre.


SELECT  departamento.nombre, asignatura.nombre FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento
INNER JOIN asignatura ON profesor.id = asignatura.id_profesor LEFT JOIN alumno_se_matricula_asignatura asma ON asignatura.id = asma.id_asignatura
LEFT JOIN curso_escolar ON asma.id_curso_escolar != curso_escolar.id; -- 9. Devuelve un listado con todos los departamentos que tienen alguna asignatura que no se haya impartido en ningún curso escolar. El resultado debe mostrar el nombre del departamento y el nombre de la asignatura que no se haya impartido nunca.