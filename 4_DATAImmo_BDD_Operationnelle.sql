START TRANSACTION;

-- Création de la base de donnée

	CREATE DATABASE DataImmo CHARACTER SET 'utf8';
	USE DataImmo;

-- Création des tables

	CREATE TABLE Commune (
		id_commune SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
		nom_commune VARCHAR (50) NOT NULL, 
		code_dep VARCHAR (5) NOT NULL,
		code_com VARCHAR (5) NOT NULL,
		PRIMARY KEY (id_commune)
	) ENGINE=INNODB;

	CREATE TABLE Voie (
		id_voie SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
		nom_voie VARCHAR(100) NULL,
		PRIMARY KEY (id_voie)
	) ENGINE=INNODB;
	
	CREATE TABLE TypeVoie (
		id_type_voie SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
		nom_type_voie VARCHAR(6) NULL,
		PRIMARY KEY (id_type_voie)
	) ENGINE=INNODB;
	
	CREATE TABLE Local (
		id_local TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
		type_local VARCHAR(20) NOT NULL,
		PRIMARY KEY (id_local)
	) ENGINE=INNODB;
	
	CREATE TABLE DateSemestre (
		id_date SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
		date_mutation DATE NOT NULL,
		PRIMARY KEY (id_date)
	) ENGINE=INNODB;
	
	CREATE TABLE BienImmo (
		id_bien_immo INT UNSIGNED NOT NULL AUTO_INCREMENT,
		surf_reel_bati SMALLINT NOT NULL,
		surf_carrez DECIMAL(6,2) NOT NULL,
		nb_piece TINYINT NOT NULL,
		valeur_fonciere INT NOT NULL,
		id_local TINYINT UNSIGNED NOT NULL,
		id_date SMALLINT UNSIGNED NOT NULL,
		id_type_voie SMALLINT UNSIGNED NOT NULL,
		id_voie SMALLINT UNSIGNED NOT NULL,
		id_commune SMALLINT UNSIGNED NOT NULL,
		PRIMARY KEY (id_bien_immo)
	) ENGINE=INNODB;
	
-- Ajout des cléfs étrangères

	ALTER TABLE BienImmo ADD CONSTRAINT commune_bien_immo_fk
	FOREIGN KEY (id_commune)
	REFERENCES Commune (id_commune)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION;
	
	ALTER TABLE BienImmo ADD CONSTRAINT voie_bien_immo_fk
	FOREIGN KEY (id_voie)
	REFERENCES Voie (id_voie)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION;
	
	ALTER TABLE BienImmo ADD CONSTRAINT type_voie_bien_immo_fk
	FOREIGN KEY (id_type_voie)
	REFERENCES TypeVoie (id_type_voie)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION;
	
	ALTER TABLE BienImmo ADD CONSTRAINT local_bien_immo_fk
	FOREIGN KEY (id_local)
	REFERENCES Local (id_local)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION;
	
	ALTER TABLE BienImmo ADD CONSTRAINT date_bien_immo_fk
	FOREIGN KEY (id_date)
	REFERENCES DateSemestre (id_date)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION;
	
COMMIT;


-- Insertion des données dans les différentes tables

START TRANSACTION;

	LOAD DATA LOCAL INFILE 'G:/####Formation_DATA_Analyst/3_Projet_CreezEtUtilisezUneBaseDeDonneesImmobiliereAvecSQL/Validation_P3_Final/BBD_Projet/BienImmo.csv'
	INTO TABLE BienImmo 
	FIELDS TERMINATED BY ';' ENCLOSED BY '"'
	LINES TERMINATED BY '\r\n'
	IGNORE 1 LINES
	(id_bien_immo, surf_reel_bati, surf_carrez, nb_piece, valeur_fonciere, id_date, id_local, id_type_voie, id_voie, id_commune);
	
	LOAD DATA LOCAL INFILE 'G:/####Formation_DATA_Analyst/3_Projet_CreezEtUtilisezUneBaseDeDonneesImmobiliereAvecSQL/Validation_P3_Final/BBD_Projet/Commune.csv'
	INTO TABLE Commune 
	FIELDS TERMINATED BY ';' ENCLOSED BY '"'
	LINES TERMINATED BY '\r\n'
	IGNORE 1 LINES
	(id_commune, nom_commune, code_dep, code_com);
	
	LOAD DATA LOCAL INFILE 'G:/####Formation_DATA_Analyst/3_Projet_CreezEtUtilisezUneBaseDeDonneesImmobiliereAvecSQL/Validation_P3_Final/BBD_Projet/Date.csv'
	INTO TABLE DateSemestre 
	FIELDS TERMINATED BY ';' ENCLOSED BY '"'
	LINES TERMINATED BY '\r\n'
	IGNORE 1 LINES
	(id_date, date_mutation);
	
	LOAD DATA LOCAL INFILE 'G:/####Formation_DATA_Analyst/3_Projet_CreezEtUtilisezUneBaseDeDonneesImmobiliereAvecSQL/Validation_P3_Final/BBD_Projet/NomTypeVoie.csv'
	INTO TABLE TypeVoie 
	FIELDS TERMINATED BY ';' ENCLOSED BY '"'
	LINES TERMINATED BY '\r\n'
	IGNORE 1 LINES
	(id_type_voie, nom_type_voie);
	
	LOAD DATA LOCAL INFILE 'G:/####Formation_DATA_Analyst/3_Projet_CreezEtUtilisezUneBaseDeDonneesImmobiliereAvecSQL/Validation_P3_Final/BBD_Projet/NomVoie.csv'
	INTO TABLE Voie 
	FIELDS TERMINATED BY ';' ENCLOSED BY '"'
	LINES TERMINATED BY '\r\n'
	IGNORE 1 LINES
	(id_voie, nom_voie);
	
	LOAD DATA LOCAL INFILE 'G:/####Formation_DATA_Analyst/3_Projet_CreezEtUtilisezUneBaseDeDonneesImmobiliereAvecSQL/Validation_P3_Final/BBD_Projet/TypeLocal.csv'
	INTO TABLE Local 
	FIELDS TERMINATED BY ';' ENCLOSED BY '"'
	LINES TERMINATED BY '\r\n'
	IGNORE 1 LINES
	(id_local, type_local);

COMMIT;

-- Mise à jour des codes_dep 2A et 2B pour les villes corses

SELECT Commune.*
FROM Commune
WHERE code_dep = '2A'
ORDER BY nom_commune ASC;
    
    UPDATE Commune SET code_dep = '2A' 
    WHERE nom_commune = 'AJACCIO' 
    OR nom_commune = 'ALBITRECCIA'
	OR nom_commune = 'APPIETTO'
	OR nom_commune = 'ARBELLARA'
	OR nom_commune = 'ARGIUSTA-MORICCIO'
	OR nom_commune = 'BASTELICACCIA'
	OR nom_commune = 'BELVEDERE-CAMPOMORO'
	OR nom_commune = 'BONIFACIO'
	OR nom_commune = 'CALCATOGGIO'
	OR nom_commune = 'CASAGLIONE'
	OR nom_commune = 'CASALABRIVA'
	OR nom_commune = 'CAURO'
	OR nom_commune = 'COGGIA'
	OR nom_commune = 'COTI-CHIAVARI'
	OR nom_commune = 'CUTTOLI-CORTICCHIATO'
	OR nom_commune = 'FRASSETO'
	OR nom_commune = 'GROSSETO-PRUGNA'
	OR nom_commune = 'LECCI'
	OR nom_commune = 'OLMETO'
	OR nom_commune = 'OTA'
	OR nom_commune = 'PALNECA'
	OR nom_commune = 'PIANA'
	OR nom_commune = 'PIANOTTOLI-CALDARELLO'
	OR nom_commune = 'PIETROSELLA'
	OR nom_commune = 'PORTO-VECCHIO'
	OR nom_commune = 'PROPRIANO'
	OR nom_commune = 'QUENZA'
	OR nom_commune = 'SANTA-MARIA-SICHE'
	OR nom_commune = 'SARI-SOLENZARA'
	OR nom_commune = 'SARROLA-CARCOPINO'
	OR nom_commune = 'SARTENE'
	OR nom_commune = 'SERRA-DI-FERRO'
	OR nom_commune = 'SOTTA'
	OR nom_commune = 'TAVERA'
    OR nom_commune = 'VICO'
    OR nom_commune = 'VIGGIANELLO'
    OR nom_commune = 'ZONZA';
	
 UPDATE Commune SET code_dep = '2B' 
    WHERE nom_commune = 'AREGNO' 
    OR nom_commune = 'CERVIONE'
	OR nom_commune = 'L''ILE ROUSSE'
	OR nom_commune = 'OLETTA';
