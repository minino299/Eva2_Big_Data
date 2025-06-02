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
