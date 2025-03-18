/* *****************************************************
  INSTITUT TIC de Barcelona
    CFGS _____________________________
    Mòdul: 0484 Bases de dades. 
    AUTORS: _______________________________
    DATA: ________________
****************************************************** */


-- ------------------------------------------------------
-- Base de dades de vols
-- ------------------------------------------------------

-- ------------------------------------------------------
--  Eliminació de taules
-- ------------------------------------------------------
	drop table if exists volar;
	drop table if exists vol;
    drop table if exists pilot;
	drop table if exists hostessa;
    drop table if exists personal;
	drop table if exists passatger;
	drop table if exists mostrador;
	drop table if exists aeroport;
	drop table if exists avio;
	drop table if exists companyia;

-- ------------------------------------------------------
--  Creació de taula companyia
-- ------------------------------------------------------

  CREATE TABLE companyia (	
	nom Varchar(40) not null, 
	IATA CHAR(6) not null, 
	CODE3 CHAR(6), 
	ICAO CHAR(6), 
	pais Varchar(40) NOT NULL, 
	filial_de Varchar(40)
   ) CHARACTER SET utf8mb4;
-- ------------------------------------------------------
--  Creació de la taula  hostessa
-- ------------------------------------------------------

  CREATE TABLE hostessa ( 
	num_empleat int
  ) CHARACTER SET utf8mb4;
-- ------------------------------------------------------
--  Creació de la taula  avio
-- ------------------------------------------------------

  CREATE TABLE avio (	
	num_serie CHAR(30), 
	tipus Varchar(10) not null, 
	fabricant Varchar(20) not null, 
	any_fabricacio year, 
	companyia Varchar(40) not null
  )  CHARACTER SET utf8mb4;
-- ------------------------------------------------------
--  Creació de la taula  aeroport
-- ------------------------------------------------------

  CREATE TABLE aeroport (
	codi CHAR(4), 
	pais Varchar(55) not null, 
	ciutat Varchar(40) not null, 
	IATA CHAR(4), 
	nom Varchar(55) not null, 
	any_construccio Year
  ) CHARACTER SET utf8mb4;
-- ------------------------------------------------------
--  Creació de la taula  Mostrador
-- ------------------------------------------------------

  CREATE TABLE mostrador (
	numero smallint, 
	codi_aeroport CHAR(4)
   ) CHARACTER SET utf8mb4;
-- ------------------------------------------------------
--  Creació de la taula  personal
-- ------------------------------------------------------

  CREATE TABLE personal (
	num_empleat int, 
	nom Varchar(25) not null, 
	cognom Varchar(35) not null, 
	passaport CHAR(20) not null, 
	sou float not null
   )  CHARACTER SET utf8mb4;
-- ------------------------------------------------------
--  Creació de la taula  vol
-- ------------------------------------------------------

  CREATE TABLE vol (
	codi CHAR(9), 
	aeroport_desti CHAR(4) not null, 
	data DATE not null, 
	durada smallint not null, 
	aeroport_origen CHAR(4) not null, 
	avio CHAR(30) not null, 
	hostessa int not null, 
    pilot int not null, 
	descripcio Varchar(30) not null
   ) CHARACTER SET utf8mb4;
-- ------------------------------------------------------
--  Creació de la taula  passatger
-- ------------------------------------------------------

  CREATE TABLE passatger (
	passaport CHAR(20), 
	nom Varchar(30) not null, 
	cognom Varchar(50), 
	adreca Varchar(70), 
	telefon Varchar(9), 
	email Varchar(40), 
	data_naix DATE, 
	genere CHAR(1)
   )  CHARACTER SET utf8mb4;
-- ------------------------------------------------------
--  Creació de la taula  pilot
-- ------------------------------------------------------

  CREATE TABLE pilot (
	num_empleat int, 
	hores_Vol smallint
   )CHARACTER SET utf8mb4;

-- ------------------------------------------------------
--  Creació de la taula  volar
-- ------------------------------------------------------  
 CREATE TABLE volar(
	passatger char(20),
	vol char(9),
	seient smallint
)CHARACTER SET utf8mb4;
