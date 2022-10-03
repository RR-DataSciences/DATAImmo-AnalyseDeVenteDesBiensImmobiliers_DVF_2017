# Présentation du projet "DATAImmo"

*¤¤¤ Projet certifiant au titre RNCP de Data Analyst ¤¤¤*

**Objectifs:** 
1. Création de la base de données permettant de collecter les transactions immobilières et foncières en France
2. Analyser le marché en utilisant des requêtes SQL et aider les différentes agences régionales à mieux accompagner leurs clients.

**Source de données:** [Demandes de valeurs foncières (DVF) - Open Data](https://www.data.gouv.fr/fr/datasets/5c4ae55a634f4117716d5656/)

*"Le présent jeu de données « Demandes de valeurs foncières », publié et produit par la direction générale des finances publiques, permet de connaître les transactions immobilières intervenues au cours des cinq dernières années sur le territoire métropolitain et les DOM-TOM, à l’exception de l’Alsace, de la Moselle et de Mayotte. Les données contenues sont issues des actes notariés et des informations cadastrales"*
>Direction Générale des Finances Publiques, Dgf. (2022, 8 avril). Demandes de valeurs foncières (DVF) - data.gouv.fr. data.gouv.fr. Consulté le 3 juillet 2022, à l’adresse https://www.data.gouv.fr/fr/datasets/5c4ae55a634f4117716d5656/

## 1. Création de la base de donnée

**Analyse et nettoyage** du data set afin de rédiger le [dictionnaire des données](1_DATAImmo_DictionnaireDonnees.pdf) correspondant aux besoins du projet.

**La Base de Données est représentée** par le [Modèle Conceptuel de Donnée (MCD)](2_DATAImmo_ModeleConceptuelDonnees.pdf) dans lequel se trouve les classes ainsi que leurs attributs. La relation entre ces classes ainsi que le type des attributs sont représentés dans le [Schémas Relationnel Normalise 3NF](3_DATAImmo_SchemasRelationnelNormalise3NF.pdf).

**Création et mise à jour de la [Base De Données opérationelle](4_DATAImmo_BDD_Operationnelle.sql)**. En effet, les `code_dep` (2A et 2B) de la Corse n'étaient pas renseignés. Afin d'obtenir une analyse plus détaillée de cette région, les codes département ont été assignés aux villes correspondantes.

## 2. Analyse de marché

L'analyses a été réalisée en utilsant [des requêtes SQL](5_DATAImmo_Requetes.sql), voici les résultats:

1. Nombre total d’appartements vendus au 1er semestre 2020
<img width="240" alt="Requete1_Resultat" src="https://user-images.githubusercontent.com/113794754/193700868-59f5bd8c-facf-4892-800a-fa74a80f82ca.png">

2. Proportion des ventes d’appartements par le nombre de pièces
<img width="193" alt="Requete2_Resultat" src="https://user-images.githubusercontent.com/113794754/193701078-766964b6-6973-4fa4-84ed-7ba01df0cde7.png">

3. Liste des 10 départements où le prix du mètre carré est le plus élevé
<img width="120" alt="Requete3_Resultat" src="https://user-images.githubusercontent.com/113794754/193701179-8a3156c9-e195-46ea-bd76-60323eb089a0.png">

4. Prix moyen du mètre carré d’une maison en Île-de-France
<img width="120" alt="Requete4_Resultat" src="https://user-images.githubusercontent.com/113794754/193701208-25865a11-813d-496d-9844-6890892e3b53.png">

5. Liste des 10 appartements les plus chers avec le département et le nombre de mètres carrés
<img width="300" alt="Requete5_Resultat" src="https://user-images.githubusercontent.com/113794754/193701236-0b7a30be-2134-4f7a-bb7b-96d53e07973e.png">

6. Taux d’évolution du nombre de ventes entre le premier et le second trimestre de 2020
<img width="160" alt="Requete6_Resultat" src="https://user-images.githubusercontent.com/113794754/193701267-bc15f547-3fc5-4fa8-969c-2d270027e625.png">

7. Liste des communes où le nombre de ventes a augmenté d'au moins 20% entre le premier et le second trimestre de 2020
<img width="180" alt="Requete7_Resultat" src="https://user-images.githubusercontent.com/113794754/193702632-459380f7-1339-42c4-a30b-51aab66a3482.png">

8. Différence en pourcentage du prix au mètre carré entre un appartement de 2 pièces et un appartement de 3 pièces
<img width="80" alt="Requete8_Resultat" src="https://user-images.githubusercontent.com/113794754/193701310-22775c8f-b066-429f-b4d7-fb9f6a7e657c.png">

9. Les moyennes de valeurs foncières pour le top 3 des communes des départements 6, 13, 33, 59 et 69
<img width="280" alt="Requete9_Resultat_v2" src="https://user-images.githubusercontent.com/113794754/193702255-d1e10bfd-f8f9-41ac-bae3-5a017da0b222.png">

