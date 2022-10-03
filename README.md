# Présentation du projet "DATAImmo"

*Projet certifiant au titre RNCP de Data Analyst*

**Objectifs:** 
1. Création de la base de données permettant de collecter les transactions immobilières et foncières en France
2. Analyser le marché en utilisant des requêtes SQL et aider les différentes agences régionales à mieux accompagner leurs clients.

**Source de données:** [Demandes de valeurs foncières (DVF) - Open Data](https://www.data.gouv.fr/fr/datasets/5c4ae55a634f4117716d5656/)

*"Le présent jeu de données « Demandes de valeurs foncières », publié et produit par la direction générale des finances publiques, permet de connaître les transactions immobilières intervenues au cours des cinq dernières années sur le territoire métropolitain et les DOM-TOM, à l’exception de l’Alsace, de la Moselle et de Mayotte. Les données contenues sont issues des actes notariés et des informations cadastrales"*
>Direction Générale des Finances Publiques, Dgf. (2022, 8 avril). Demandes de valeurs foncières (DVF) - data.gouv.fr. data.gouv.fr. Consulté le 3 juillet 2022, à l’adresse https://www.data.gouv.fr/fr/datasets/5c4ae55a634f4117716d5656/

## 1. Création de la base de donnée

**Analyse et nettoyage** du data set afin de rédiger le [dictionnaire des données](1_DATAImmo_DictionnaireDonnees.pdf) correspondant aux besoins du projet.

**La Base de Données est représentée** par le [Modèle Conceptuel de Donnée (MCD)](2_DATAImmo_ModeleConceptuelDonnees.pdf) dans lequel se trouve les classes ainsi que leurs attributs. La relation entre ces classes ainsi que le type des attributs sont représentés dans le [Schémas Relationnel Normalise 3NF](3_DATAImmo_SchemasRelationnelNormalise3NF.pdf).



## 2. Analyse de marché en fonction des besoins métier

1. Nombre total d’appartements vendus au 1er semestre 2020
2. Proportion des ventes d’appartements par le nombre de pièces
3. Liste des 10 départements où le prix du mètre carré est le plus élevé
4. Prix moyen du mètre carré d’une maison en Île-de-France
5. Liste des 10 appartements les plus chers avec le département et le nombre de mètres carrés
6. Taux d’évolution du nombre de ventes entre le premier et le second trimestre de 2020
7. Liste des communes où le nombre de ventes a augmenté d'au moins 20% entre le premier et le second trimestre de 2020
8. Différence en pourcentage du prix au mètre carré entre un appartement de 2 pièces et un appartement de 3 pièces
9. Les moyennes de valeurs foncières pour le top 3 des communes des départements 6, 13, 33, 59 et 69
