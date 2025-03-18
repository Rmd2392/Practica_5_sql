/* *****************************************************
  INSTITUT TIC de Barcelona
    CFGS Desenvolupament d'aplicacions web (DAW1A)
    Mòdul: 0484 Bases de dades. 
    AUTORS: Ricardo Martín Díaz & Pau Bosch Pérez
    DATA: 18/03/2025
****************************************************** */

-- Pregunta 1

select 
    aeroport.ciutat as ciutat_desti,
    count(vol.codi) as total_vols
from vol
join aeroport on vol.aeroport_desti = aeroport.codi
where year(vol.data) = 2023
group by aeroport.ciutat
having count(vol.codi) >= 800
order by total_vols desc;

-- Pregunta 2
select 'No ho sé';

-- Pregunta 3
select 'No ho sé';

-- Pregunta 4
select 'No ho sé';

-- Pregunta 5
select 'No ho sé';


