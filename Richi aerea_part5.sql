/* *****************************************************
  INSTITUT TIC de Barcelona
    CFGS Desenvolupament d'aplicacions web (DAW1A)
    Mòdul: 0484 Bases de dades. 
    AUTORS: Ricardo Martín Díaz & Pau Bosch Pérez
    DATA: 25/03/2025
****************************************************** */

-- Pregunta 1

🔹 Texto original del enunciado

    Mostra la ciutat destí i quants vols han arribat durant l’any 2023 però nomès si han arribat almenys 800 vols.
    Ordena el resultat pel número de vols el ordre decreixent.

🔹 Requisitos resumidos

    Mostrar ciudad de destino

    Contar los vuelos que llegaron durante 2023

    Solo ciudades con mínimo 800 vuelos

    Ordenar por número de vuelos descendente

select 
  (select ciutat from aeroport where aeroport.codi = vol.aeroport_desti) as ciutat_desti,  -- Obtener el nombre de la ciudad de destino
  count(*) as total_vols  -- Contar cuántos vuelos llegaron a esa ciudad
from vol
where year(data) = 2023  -- Solo considerar vuelos del año 2023
group by aeroport_desti  -- Agrupar por código de aeropuerto destino
having count(*) >= 800  -- Solo mostrar los aeropuertos con al menos 800 vuelos
order by total_vols desc;  -- Ordenar de mayor a menor número de vuelos


-- Pregunta 2

🔹 Texto original del enunciado

    Mostra el nom de TOTES les companyies que siguin espanyoles, incloent les que no tinguin avions o no hagin
    fet cap vol (s’ha de visualitzar com companyia) i el número de vols (s’ha de visualitzar com total_vols)
    que han operat, també volem saber la durada promig dels seus vols així com la data de l’últim vol que tenim.
    Ordena el resultat segons el nom de la companyia.

🔹 Requisitos resumidos

    Mostrar todas las compañías españolas

    Aunque no tengan vuelos

    Mostrar: nombre, nº de vuelos, duración media y fecha último vuelo

    Ordenar por nombre

select 
  c.nom as companyia,  -- Mostrar el nombre de la compañía
  (select count(*) from vol where avio in 
      (select num_serie from avio where companyia = c.nom)) as total_vols,  -- Contar cuántos vuelos operó la compañía
  (select avg(durada) from vol where avio in 
      (select num_serie from avio where companyia = c.nom)) as durada_promig,  -- Calcular la duración promedio de los vuelos
  (select max(data) from vol where avio in 
      (select num_serie from avio where companyia = c.nom)) as ultim_vol  -- Obtener la fecha del vuelo más reciente
from companyia c
where pais = 'Spain'  -- Solo mostrar compañías españolas
order by c.nom;  -- Ordenar alfabéticamente por el nombre de la compañía


-- Pregunta 3

🔹 Texto original del enunciado

    Mostra quants vols s’han fet de cada companyia espanyola cada mes durant l’any 2023. Ordena el resultat per any,
    mes i companyia.

🔹 Requisitos resumidos

    Vuelos por mes y compañía

    Solo compañías españolas

    Año 2023

    Ordenar por año, mes, compañía

select 
  year(data) as any,  -- Obtener el año del vuelo
  month(data) as mes,  -- Obtener el mes del vuelo
  (select companyia from avio where num_serie = vol.avio) as companyia,  -- Obtener el nombre de la compañía del avión
  count(*) as total_vols  -- Contar cuántos vuelos realizó esa compañía ese mes
from vol
where year(data) = 2023  -- Solo vuelos del año 2023
  and (select pais from companyia 
       where nom = (select companyia from avio where num_serie = vol.avio)) = 'Spain'  -- Solo compañías españolas
group by any, mes, companyia  -- Agrupar por año, mes y compañía
order by any, mes, companyia;  -- Ordenar por año, luego mes, luego compañía


-- Pregunta 4

🔹 Texto original del enunciado

    Mostra el codi, el nom i el país de l’aeroport origen, el nom i el país de l’aeroport destí dels vols
    que es facin a la mateixa data, tinguin el mateix aeroport origen i mateix aeroport destí que el vol 482739,
    evidentment sense incloure a aquest vol.

🔹 Requisitos resumidos

    Comparar con vuelo 482739

    Coincidir en fecha, origen y destino

    Excluir el vuelo original

    Mostrar código, nombre y país de origen y destino

select 
  codi,  -- Mostrar el código del vuelo
  (select nom from aeroport where codi = aeroport_origen) as aeroport_origen,  -- Obtener nombre del aeropuerto origen
  (select pais from aeroport where codi = aeroport_origen) as pais_origen,  -- Obtener país del aeropuerto origen
  (select nom from aeroport where codi = aeroport_desti) as aeroport_desti,  -- Obtener nombre del aeropuerto destino
  (select pais from aeroport where codi = aeroport_desti) as pais_desti  -- Obtener país del aeropuerto destino
from vol
where data = (select data from vol where codi = 482739)  -- Coincidir fecha con el vuelo 482739
  and aeroport_origen = (select aeroport_origen from vol where codi = 482739)  -- Coincidir aeropuerto origen
  and aeroport_desti = (select aeroport_desti from vol where codi = 482739)  -- Coincidir aeropuerto destino
  and codi <> 482739;  -- Excluir el vuelo original


-- Pregunta 5

🔹 Texto original del enunciado

    Mostra el nom de la companyia i quants vols s’han fet de les companyies que tinguin més vols que la
    companyia “British Airways”. Ordena el resultat pel número de vols.

🔹 Requisitos resumidos

    Contar vuelos por compañía

    Solo las que tengan más que British Airways

    Mostrar nombre y número de vuelos

    Ordenar por número de vuelos descendente

select 
  nom as companyia,  -- Mostrar el nombre de la compañía
  (select count(*) from vol where avio in 
      (select num_serie from avio where companyia = c.nom)) as total_vols  -- Contar los vuelos de esa compañía
from companyia c
where (select count(*) from vol where avio in 
         (select num_serie from avio where companyia = c.nom)) >  -- Comparar su total de vuelos con...
      (select count(*) from vol where avio in 
         (select num_serie from avio where companyia = 'British Airways'))  -- ...los de British Airways
order by total_vols desc;  -- Ordenar de mayor a menor cantidad de vuelos

