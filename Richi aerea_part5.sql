/* *****************************************************
  INSTITUT TIC de Barcelona
    CFGS Desenvolupament d'aplicacions web (DAW1A)
    Mòdul: 0484 Bases de dades. 
    AUTORS: Ricardo Martín Díaz & Pau Bosch Pérez
    DATA: 25/03/2025
****************************************************** */

-- Pregunta 1

select 
    aeroport.ciutat as ciutat_desti,  -- Se obtiene la ciudad de destino
    count(vol.codi) as total_vols  -- Se cuenta la cantidad de vuelos que llegaron a esa ciudad
from vol
join aeroport on vol.aeroport_desti = aeroport.codi  -- Se une 'vol' con 'aeroport' para obtener la ciudad de destino
where year(vol.data) = 2023  -- Solo vuelos del año 2023
group by aeroport.ciutat  -- Se agrupa por ciudad de destino para contar los vuelos de cada una
having count(vol.codi) >= 800  -- Solo se incluyen ciudades con al menos 800 vuelos
order by total_vols desc;  -- Se ordena de mayor a menor número de vuelos


-- Pregunta 2

select 
    companyia.nom as companyia,  -- Se obtiene el nombre de la compañía
    count(vol.codi) as total_vols,  -- Se cuenta la cantidad de vuelos operados
    avg(vol.durada) as durada_promig,  -- Se obtiene la duración promedio de los vuelos
    max(vol.data) as ultim_vol  -- Se obtiene la fecha del último vuelo
from companyia
left join avio on companyia.nom = avio.companyia  -- Se une con 'avio' para incluir compañías sin aviones
left join vol on avio.num_serie = vol.avio  -- Se une con 'vol' para incluir compañías sin vuelos
where companyia.pais = 'Spain'  -- Solo compañías españolas
group by companyia.nom  -- Se agrupa por compañía para calcular sus valores
order by companyia.nom;  -- Se ordena alfabéticamente por nombre de la compañía


-- Pregunta 3

select 
    year(vol.data) as any,  -- Se obtiene el año del vuelo
    month(vol.data) as mes,  -- Se obtiene el mes del vuelo
    companyia.nom as companyia,  -- Se obtiene el nombre de la compañía
    count(vol.codi) as total_vols  -- Se cuenta la cantidad de vuelos operados
from vol
join avio on vol.avio = avio.num_serie  -- Se une con 'avio' para obtener la compañía del avión
join companyia on avio.companyia = companyia.nom  -- Se une con 'companyia' para obtener el nombre de la compañía
where companyia.pais = 'Spain'  -- Solo compañías españolas
  and year(vol.data) = 2023  -- Solo vuelos del año 2023
group by any, mes, companyia.nom  -- Se agrupa por año, mes y compañía
order by any, mes, companyia.nom;  -- Se ordena por año, mes y compañía


-- Pregunta 4

select 
    vol.codi,
    aeroport_origen.nom as aeroport_origen,
    aeroport_origen.pais as pais_origen,
    aeroport_desti.nom as aeroport_desti,
    aeroport_desti.pais as pais_desti
from vol
join aeroport aeroport_origen on vol.aeroport_origen = aeroport_origen.codi
join aeroport aeroport_desti on vol.aeroport_desti = aeroport_desti.codi
where vol.data = (select data from vol where codi = 482739)
  and vol.aeroport_origen = (select aeroport_origen from vol where codi = 482739)
  and vol.aeroport_desti = (select aeroport_desti from vol where codi = 482739)
  and vol.codi <> 482739;  -- Excluimos el vuelo 482739


-- Pregunta 5

select 
    companyia.nom as companyia,  -- Se obtiene el nombre de la compañía
    count(vol.codi) as total_vols  -- Se cuenta la cantidad de vuelos operados
from vol
join avio on vol.avio = avio.num_serie  -- Se une 'vol' con 'avio' para obtener la compañía del avión
join companyia on avio.companyia = companyia.nom  -- Se une 'avio' con 'companyia' para obtener el nombre de la compañía
group by companyia.nom  -- Se agrupa por compañía para contar los vuelos de cada una
having count(vol.codi) > (  -- Se filtran las compañías con más vuelos que British Airways
    select count(vol.codi)  -- Se cuenta el número de vuelos operados por British Airways
    from vol
    join avio on vol.avio = avio.num_serie
    join companyia on avio.companyia = companyia.nom
    where companyia.nom = 'British Airways'
)
order by total_vols desc;  -- Se ordena por el número de vuelos en orden descendente

