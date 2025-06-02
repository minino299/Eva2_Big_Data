---
title: "Analisis estadistico de UFO's en America"
excerpt_separator: "<!--more-->"
categories:
  - Blog
tags:
  - Post Formats
  - readability
  - standard
---

# Analisis estadistico de UFO's en America

Este informe presenta un enfoque metodológico para explorar y analizar registros de avistamientos de OVNIs en Estados Unidos entre 1910 y 2014, aprovechando la potencia de BigQuery para almacenamiento y consulta masiva, Dataprep para la limpieza y normalización de datos, y Looker para la visualización interactiva de resultados. El principal objetivo no es especular sobre teorías conspirativas, sino demostrar cómo un conjunto heterogéneo de registros históricos puede transformarse en información útil mediante un flujo de trabajo de análisis de datos robusto y reproducible.

### Cloud Storage

En primer lugar, los datos en formato CSV se cargan en un bucket de Cloud Storage, para una mas facil utilizacion de estos con el resto de la suite de Google Cloud

![](https://holocron.so/uploads/d8662850-screenshot-2025-06-02-081412.png)

### DataPrep

A continuacion, se crea un dataset en BigQuery llamado `'ovni'`, que sera nuestro dataset donde guardaremos nuestros datos procesados desde DataPrep. Sin embargo para esto primero debemos procesar nuestros datos con la herramienta. El rol de Dataprep es identificar y corregir inconsistencias, en este caso se utilizo la siguiente receta en DataPrep:

![](https://holocron.so/uploads/1440f3e1-screenshot-2025-06-01-230226.png)

Esta fase garantiza que el análisis posterior no se vea afectado por problemas propios de datos recopilados durante casi un siglo y procedentes de múltiples fuentes.

### Big Query

Una vez nuestros datos fueron procesados y limpiados por Dataprep, se cargan en el dataset antes creado `'ovni'` como la tabla `'avistamientos'`

![](https://holocron.so/uploads/06d44241-screenshot-2025-06-02-082620.png)

Una vez en esta pantalla, se procede a realizar una manipulacion de datos utilizando el comando `SELECT` en SQL, especificamente con este codigo

```SQL
# 1.- 
 SELECT 
  UFO_shape,
  COUNT(*) AS Sightings
FROM 
  `ovni.avistamientos`
WHERE 
  country = 'us'
GROUP BY 
  UFO_shape
ORDER BY 
  Sightings DESC
LIMIT 5;


# 2.-
SELECT 
  EXTRACT(YEAR FROM DATETIME(Date_time)) AS Year,
  COUNT(*) AS Sightings
FROM 
  `ovni.avistamientos`
WHERE 
  country = 'us'
GROUP BY 
  Year
ORDER BY 
  Sightings DESC;
 # 3-
 SELECT 
  `state_or_province` AS State,
  COUNT(*) AS Sightings
FROM 
  `ovni.avistamientos`
WHERE 
  country = 'us'
GROUP BY 
  State
ORDER BY 
  Sightings DESC;
```

Las tablas generadas por este codigo SQL pueden ser vistas en el repositorio.

### Looker

Finalmente, Looker ofrece una capa de modelado semántico y un lienzo de visualización donde podemos explorar tendencias temporales, patrones geográficos y posibles correlaciones—por ejemplo, concentraciones de avistamientos en determinadas décadas o estados, o variaciones estacionales en la frecuencia de reportes. Utilizando esta herramienta se crearon tres reportes con sus respectivas tablas y graficos

![](https://holocron.so/uploads/2bd6fece-image.png)

![](https://holocron.so/uploads/f9cef7a8-image.png)

![](https://holocron.so/uploads/6b3130d3-screenshot-2025-06-02-070030.png)

Gracias a estos tres componentes (BigQuery, Dataprep y Looker), este informe se centra en el valor analítico: descubrir comportamientos estadísticos, visualizar clusters y aportar herramientas concretas para que investigadores y analistas puedan profundizar en el fenómeno desde una perspectiva basada en datos.
