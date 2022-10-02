
	-- 1. Nombre total d’appartements vendus au 1er semestre 2020.
	SELECT BienImmo.id_bien_immo, COUNT(*) AS nb_appart_vendu, Local.type_local
	FROM BienImmo
	INNER JOIN Local ON BienImmo.id_local = Local.id_local
	WHERE Local.type_local = 'appartement'
	GROUP BY Local.type_local;

	-- 2. Proportion des ventes d’appartements par le nombre de pièces.	
	SELECT NbAppartPiece.nb_piece, NbAppartPiece.TotalPiece/NbAppartTotal.NbAppart AS ProportionNbPiece, NbAppartPiece.type_local
	FROM 
	(	SELECT BienImmo.nb_piece, COUNT(*) AS TotalPiece, Local.type_local
		FROM BienImmo
		INNER JOIN Local ON BienImmo.id_local = Local.id_local
		WHERE Local.type_local = 'Appartement'
		GROUP BY BienImmo.nb_piece) AS NbAppartPiece,
     (	SELECT COUNT(*) AS NbAppart, Local.type_local
		FROM BienImmo
		INNER JOIN Local ON BienImmo.id_local = Local.id_local
		WHERE Local.type_local = 'Appartement') AS NbAppartTotal
        ORDER BY ProportionNbPiece DESC;
	
	-- 3. Liste des 10 départements où le prix du mètre carré est le plus élevé.
	SELECT Commune.code_dep, ROUND(AVG(BienImmo.valeur_fonciere / BienImmo.surf_carrez),2) AS Prixm2
	FROM BienImmo
	INNER JOIN Commune ON BienImmo.id_commune = Commune.id_commune
	GROUP BY Commune.code_dep
    ORDER BY Prixm2 DESC
    LIMIT 10;
    
	-- 4. Prix moyen du mètre carré d’une maison en Île-de-France.	
	SELECT ROUND(AVG(BienImmo.valeur_fonciere / BienImmo.surf_carrez),2) AS PrixMoyenM2IDF
	FROM BienImmo
	INNER JOIN Commune ON BienImmo.id_commune = Commune.id_commune
	INNER JOIN Local ON BienImmo.id_local = Local.id_local
	WHERE Commune.code_dep IN ('75', '77', '78', '91', '92', '93', '94', '95')
	AND Local.type_local = 'Maison';
	
	-- 5. Liste des 10 appartements les plus chers avec le département et le nombre de mètres carrés.	
	SELECT BienImmo.id_bien_immo, Commune.code_dep, MAX(BienImmo.valeur_fonciere) AS BienPlusCher, BienImmo.surf_carrez, Local.type_local
	FROM BienImmo
	INNER JOIN Commune ON BienImmo.id_commune = Commune.id_commune
	INNER JOIN Local ON BienImmo.id_local = Local.id_local
	GROUP BY BienImmo.id_bien_immo
	ORDER BY BienPlusCher DESC
	LIMIT 10;
	
	-- 6. Taux d’évolution du nombre de ventes entre le premier et le second trimestre de 2020.		
	SELECT ((NbdeVenteT2-NbdeVenteT1)/NbdeVenteT1)*100 AS TauxComparatifVenteT1T2 FROM 
	(
		SELECT COUNT(BienImmo.id_bien_immo) AS NbdeVenteT1
		FROM BienImmo
		INNER JOIN DateSemestre ON BienImmo.id_date = DateSemestre.id_date 
		WHERE DateSemestre.date_mutation BETWEEN '2020-01-01' AND '2020-03-31') AS T1, 
	(
		SELECT COUNT(BienImmo.id_bien_immo) AS NbdeVenteT2
		FROM BienImmo
		INNER JOIN DateSemestre ON BienImmo.id_date = DateSemestre.id_date 
		WHERE DateSemestre.date_mutation BETWEEN '2020-04-01' AND '2020-06-30') AS T2;
	
	-- 7. Liste des communes où le nombre de ventes a augmenté d'au moins 20% entre le premier et le second trimestre de 2020
	SELECT T1.Com1, ((T2.NbdeVenteT2-T1.NbdeVenteT1)/T1.NbdeVenteT1)*100 AS TauxEvolution20 FROM 
	(
		SELECT COUNT(BienImmo.id_bien_immo) AS NbdeVenteT1, Commune.nom_commune AS Com1
		FROM BienImmo
		INNER JOIN DateSemestre ON BienImmo.id_date = DateSemestre.id_date 
        INNER JOIN Commune ON BienImmo.id_commune = Commune.id_commune
		WHERE DateSemestre.date_mutation BETWEEN '2020-01-01' AND '2020-03-31'
        GROUP BY Com1) AS T1, 
	(
		SELECT COUNT(BienImmo.id_bien_immo) AS NbdeVenteT2, Commune.nom_commune AS Com2
		FROM BienImmo
		INNER JOIN DateSemestre ON BienImmo.id_date = DateSemestre.id_date 
        INNER JOIN Commune ON BienImmo.id_commune = Commune.id_commune
		WHERE DateSemestre.date_mutation BETWEEN '2020-04-01' AND '2020-06-30'
        GROUP BY Com2) AS T2
	WHERE T1.Com1=T2.Com2
	AND ((T2.NbdeVenteT2-T1.NbdeVenteT1)/T1.NbdeVenteT1)*100 > 20
	ORDER BY TauxEvolution20 DESC;
        
	-- 8. Différence en pourcentage du prix au mètre carré entre un appartement de 2 pièces et un appartement de 3 pièces.
	SELECT ROUND(((PrixMoyenP2.m2P2-PrixMoyenP3.m2P3)/PrixMoyenP3.m2P3)*100, 2) AS DiffPrixM2
	FROM 
(
	SELECT BI.nb_piece, ROUND(AVG(BI.valeur_fonciere/BI.surf_carrez),2) AS m2P2, Local.type_local
	FROM BienImmo AS BI
	INNER JOIN Local ON BI.id_local = Local.id_local
	WHERE BI.nb_piece = 2 AND Local.type_local = 'Appartement') AS PrixMoyenP2,
(
	SELECT BI.nb_piece, ROUND(AVG(BI.valeur_fonciere/BI.surf_carrez),2) AS m2P3, Local.type_local
	FROM BienImmo AS BI
	INNER JOIN Local ON BI.id_local = Local.id_local
	WHERE BI.nb_piece = 3 AND Local.type_local = 'Appartement') AS PrixMoyenP3;
			
	-- 9. Les moyennes de valeurs foncières pour le top 3 des communes des départements 6, 13, 33, 59 et 69
	SELECT * FROM
	(     
		SELECT *, RANK() OVER(PARTITION BY MoyenneBienVille.code_dep ORDER BY MoyenneBienVille.MoyenneValFonciere DESC) AS RangCommune FROM
		(
			SELECT Commune.code_dep, Commune.nom_commune, ROUND(AVG(BienImmo.valeur_fonciere), 2) AS MoyenneValFonciere
			FROM BienImmo
			INNER JOIN Commune ON BienImmo.id_commune = Commune.id_commune
			WHERE Commune.code_dep IN ('6', '13', '33', '59', '69')
			GROUP BY Commune.code_dep, Commune.nom_commune
		) AS MoyenneBienVille
	) AS ReqPrincipale
	WHERE RangCommune <= 3
	ORDER BY LPAD(code_dep, 3, '0') ASC;