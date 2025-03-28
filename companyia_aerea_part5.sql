/* *****************************************************
  INSTITUT TIC de Barcelona
    CFGS Desenvolupament d'aplicacions web (DAW1A)
    Mòdul: 0484 Bases de dades. 
    AUTORS: Ricardo Martín Díaz & Pau Bosch Pérez
    DATA: 18/03/2025
****************************************************** */

-- Pregunta 1

SELECT 
  (SELECT ciutat
  FROM aeroport 
  WHERE aeroport.codi = vol.aeroport_desti) AS ciutat,
  COUNT(*) AS total_vols
FROM vol
WHERE YEAR(DATA) = 2023
GROUP BY aeroport_desti
HAVING COUNT(*) >= 800
ORDER BY total_vols DESC;

-- Pregunta 2

SELECT 
    companyia.nom AS nom,
    COALESCE(
        (SELECT COUNT(vol.codi) 
         FROM vol 
         JOIN avio ON vol.avio = avio.num_serie 
         WHERE avio.companyia = companyia.nom), 
        0) AS total_vols,
    COALESCE(
        (SELECT AVG(vol.durada) 
         FROM vol 
         JOIN avio ON vol.avio = avio.num_serie 
         WHERE avio.companyia = companyia.nom), 
        0) AS vol_promig,
    COALESCE(
        (SELECT MAX(vol.data) 
         FROM vol 
         JOIN avio ON vol.avio = avio.num_serie 
         WHERE avio.companyia = companyia.nom), 
        NULL) AS last_vol
FROM companyia
WHERE companyia.pais = 'Spain'
ORDER BY companyia.nom;


-- Pregunta 3

SELECT 
  YEAR(data) AS anyo,
  MONTH(data) AS mes,
  (SELECT companyia.nom 
   FROM companyia
   WHERE companyia.nom = (
       SELECT avio.companyia 
       FROM avio 
       WHERE avio.num_serie = vol.avio
   )
  ) AS nom,
  COUNT(*) AS total_vols
FROM vol
WHERE avio IN (
    SELECT num_serie
    FROM avio
    WHERE companyia IN (
        SELECT nom
        FROM companyia
        WHERE pais = 'Spain'
    )
)
AND data BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY anyo, mes, nom
ORDER BY anyo, mes, nom;

-- Pregunta 4

SELECT 
    aeroport_origen AS codi_origen,
    (SELECT aeroport.nom FROM aeroport WHERE aeroport.codi = vol.aeroport_origen) AS nom_origen,
    (SELECT aeroport.pais FROM aeroport WHERE aeroport.codi = vol.aeroport_origen) AS pais_origen,
    (SELECT aeroport.nom FROM aeroport WHERE aeroport.codi = vol.aeroport_desti) AS nom_desti,
    (SELECT aeroport.pais FROM aeroport WHERE aeroport.codi = vol.aeroport_desti) AS pais_dest
FROM vol
WHERE aeroport_origen = (SELECT aeroport_origen FROM vol WHERE codi = 482739)
AND aeroport_desti = (SELECT aeroport_desti FROM vol WHERE codi = 482739)
AND data = (SELECT data FROM vol WHERE codi = 482739)
AND codi <> 482739;

-- Pregunta 5

SELECT companyia.nom AS nom, 
       (SELECT COUNT(*) FROM vol WHERE vol.avio IN 
            (SELECT avio.num_serie FROM avio WHERE avio.companyia = companyia.nom)
       ) AS total_vols
FROM companyia
WHERE (SELECT COUNT(*) FROM vol WHERE vol.avio IN 
            (SELECT avio.num_serie FROM avio WHERE avio.companyia = companyia.nom)
       ) > 
      (SELECT COUNT(*) FROM vol WHERE vol.avio IN 
            (SELECT avio.num_serie FROM avio WHERE avio.companyia = 'British Airways')
       )
ORDER BY total_vols;