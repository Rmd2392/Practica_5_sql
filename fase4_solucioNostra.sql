/* *****************************************************
  INSTITUT TIC de Barcelona
    CFGS DAW 1A
    Mòdul: 0484 Bases de dades. 
    AUTORS: Pau Bosch Pérez and Ricardo Martín Díaz
    DATA: 27/02/2025
****************************************************** */

-- Pregunta 1
select
  aeroport.ciutat,
  aeroport.nom as aeroport,
  vol.data,
  vol.codi
from vol
  join aeroport on (aeroport.codi=vol.aeroport_origen)
where
  durada < 40
  and MONTH(data)= 2
  and year(data) = 2024
  and descripcio = 'DELAYED'
order by
  ciutat,
  data;

-- Pregunta 2
select
  any_fabricacio as 'any',
  companyia as 'companyia',
  num_serie,
  tipus
from avio
  join companyia on companyia.nom = avio.companyia
where
  companyia.pais like 'spain'
  and any_fabricacio < 2000
order by
  any_fabricacio desc,
  companyia asc,
  num_serie asc;

-- Pregunta 3
select 
    vol.codi, 
    vol.data, 
    CONCAT(personal.cognom, ', ', personal.nom, ' (', pilot.hores_vol, ')') as pilot, 
    avio.companyia
from vol
  join pilot on vol.pilot = pilot.num_empleat
  join personal on pilot.num_empleat = personal.num_empleat
  join avio on vol.avio = avio.num_serie
where 
    MONTH(vol.data) = 2 
    and YEAR(vol.data) = 2024
    and pilot.hores_vol > 7000
    and personal.sou > 53000
    and vol.descripcio like '%delayed%';

-- Pregunta 4
select
  concat(passatger.cognom, ', ', passatger.nom) as passatger,
  concat(personal.cognom, ', ', personal.nom) as hostessa,
  vol.aeroport_origen,
  vol.aeroport_desti,
  vol.durada
from passatger
  join volar on volar.passatger = passatger.passaport
  join vol on volar.vol = vol.codi
  join hostessa on hostessa.num_empleat = vol.hostessa
  join personal on hostessa.num_empleat = personal.num_empleat
where
  passatger.adreca like '%MADRID%'
  and vol.data = '2023-12-25'
order by
  passatger.cognom;

-- Pregunta 5
select
  vol.codi,
  concat(ao.nom, ' (', ao.ciutat, ')') as origen,
  concat(ad.nom, ' (', ad.ciutat, ')') as desti
from vol
  join aeroport ao on vol.aeroport_origen = ao.codi
  join aeroport ad on vol.aeroport_desti = ad.codi
where
  year(vol.data) = 2024
  and durada > 160
  and ao.ciutat like '__o%'
  and ad.ciutat like '__o%'
order by
  vol.codi;

-- Pregunta 6
select
  companyia.nom, 
  companyia.filial_de, 
  concat(pilot_personal.cognom, ', ', pilot_personal.nom) as pilot, 
  concat(hostessa_personal.cognom, ', ', hostessa_personal.nom) as hostessa
from vol
  join avio on vol.avio = avio.num_serie
  join companyia on avio.companyia = companyia.nom
  join pilot on vol.pilot = pilot.num_empleat
  join personal as pilot_personal on pilot.num_empleat = pilot_personal.num_empleat
  join hostessa on vol.hostessa = hostessa.num_empleat
  join personal as hostessa_personal on hostessa.num_empleat = hostessa_personal.num_empleat
where
    avio.any_fabricacio = 2008 
    and companyia.filial_de is not null
order by 
    pilot_personal.cognom, 
    hostessa_personal.cognom;

-- Pregunta 7
select
  comp.nom,
  coalesce(compfil.nom, '-') as mare
from companyia comp
  left join companyia compfil on comp.filial_de = compfil.nom
order by
  comp.nom;

-- Pregunta 8
select 
    aeroport.nom, 
    aeroport.pais, 
    coalesce(vol.codi, 'Sense vols') as vol
from aeroport
  left join vol on aeroport.codi = vol.aeroport_origen 
  and vol.durada > 200 
  and vol.data between '2024-01-01' and '2024-01-10'
where 
    aeroport.nom like '%z%' 
    and length(aeroport.pais) < 15
order by 
    aeroport.pais, 
    aeroport.nom;