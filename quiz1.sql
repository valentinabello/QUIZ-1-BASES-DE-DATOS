-- Primer Punto

-- Consulta A
SELECT *
FROM ActividadesenlosquesonutilizadoslosbienesTICparaenseanza2023copia;

-- Consulta B
SELECT DISTINCT actividad_nombre
FROM ActividadesenlosquesonutilizadoslosbienesTICparaenseanza2023copia;


-- Segundo Punto
SELECT 
    sede_codigo AS codigo_sede,
    periodo_anio AS anio_reporte,
    actividad_codigo AS cod_actividad,
    actividad_nombre AS nombre_actividad
FROM ActividadesenlosquesonutilizadoslosbienesTICparaenseanza2022copia
ORDER BY sede_codigo ASC
LIMIT 50;


-- Tercer Punto
CREATE TABLE tic_sedes_resumen (
    resumen_id INT,
    sede_codigo INT,
    anio INT,
    total_actividades INT,
    tiene_internet BOOLEAN,
    fecha_carga DATETIME,
    UNIQUE (sede_codigo, anio)
);


-- Cuarto Punto
SELECT 
    SUBSTR(sede_codigo, 1, 2) AS codigo_departamento,
    COUNT(DISTINCT sede_codigo) AS numero_sedes_unicas
FROM ActividadesenlosquesonutilizadoslosbienesTICparaenseanza2023copia
WHERE actividad_codigo = 'S'
   OR actividad_codigo IS NULL
   OR actividad_codigo = '1'
GROUP BY codigo_departamento
HAVING numero_sedes_unicas > 500
ORDER BY numero_sedes_unicas DESC;

-- Quinto Punto

SELECT 
    t22.sede_codigo AS codigo_sede,
    COUNT(t22.sede_codigo) AS total_act_2022,
    COUNT(t23.sede_codigo) AS total_act_2023,
    
    (COUNT(t23.sede_codigo) - COUNT(t22.sede_codigo)) AS diferencia,

    CASE 
        WHEN (COUNT(t23.sede_codigo) - COUNT(t22.sede_codigo)) > 0 THEN 'CRECIÓ'
        WHEN (COUNT(t23.sede_codigo) - COUNT(t22.sede_codigo)) < 0 THEN 'DECRECIÓ'
    END AS tendencia

FROM ActividadesenlosquesonutilizadoslosbienesTICparaenseanza2022copia t22
INNER JOIN ActividadesenlosquesonutilizadoslosbienesTICparaenseanza2023copia t23
    ON t22.sede_codigo = t23.sede_codigo

GROUP BY t22.sede_codigo

HAVING COUNT(t22.sede_codigo) >= 2

ORDER BY diferencia DESC

LIMIT 30;