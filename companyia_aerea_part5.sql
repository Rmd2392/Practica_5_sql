/* *****************************************************
  INSTITUT TIC de Barcelona
    CFGS Desenvolupament d'aplicacions web (DAW1A)
    Mòdul: 0484 Bases de dades. 
    AUTORS: Ricardo Martín Díaz & Pau Bosch Pérez
    DATA: 18/03/2025
****************************************************** */

-- Pregunta 1

select 
  (select ciutat from aeroport where aeroport.codi = vol.aeroport_desti) as ciutat_desti,
  count(*) as total_vols
from vol
where year(data) = 2023
group by aeroport_desti
having count(*) >= 800
order by total_vols desc;


-- Pregunta 2
select 'No ho sé';


-- Pregunta 3
select 'No ho sé';


-- Pregunta 4
select 'No ho sé';


-- Pregunta 5
select 'No ho sé';


