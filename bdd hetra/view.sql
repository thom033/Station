-- Étapes :

--     Relation entre les positions des arrondissements et leurs surfaces
--     Les positions (coordonnées long, lat) des arrondissements, stockées dans arrondissement_position, sont utilisées pour former un polygone qui représente la surface de chaque arrondissement.

--     Vérification de l'appartenance d'une maison à un arrondissement
--     La position d'une maison, stockée sous forme de géométrie dans maison.position, est vérifiée pour savoir si elle se trouve dans le polygone d'un arrondissement.

--     Création de la vue reliant les maisons aux arrondissements
--     La vue reliera les id_maison de la table maison et les id_arrondissement de la table arrondissement.

-- ### **Résultat attendu :**
-- La vue `maison_arrondissement` reliera chaque maison (`id_maison`) à l'arrondissement (`id_arrondissement`) auquel elle appartient. Vous pouvez interroger cette vue pour obtenir directement les informations souhaitées.


-- #### **1. Création des polygones des arrondissements**
-- sql
SELECT 
    a.id_arrondissement, 
    SDO_GEOM.SDO_CONVEXHULL(
        SDO_AGGR_MDSYS.SDO_CONCAT_LINES(
            CAST(COLLECT(ap.position) AS SDO_GEOMETRY_ARRAY)
        )
    ) AS surface
FROM arrondissement a
JOIN arrondissement_position ap 
    ON a.id_arrondissement = ap.id_arrondissement
GROUP BY a.id_arrondissement;



-- #### **2. Déterminer l'arrondissement d'une maison**

SELECT 
    m.id AS id_maison, 
    a.id_arrondissement
FROM maison m
JOIN (
    SELECT 
        a.id_arrondissement, 
        SDO_GEOM.SDO_CONVEXHULL(
            SDO_AGGR_MDSYS.SDO_CONCAT_LINES(
                CAST(COLLECT(ap.position) AS SDO_GEOMETRY_ARRAY)
            )
        ) AS surface
    FROM arrondissement a
    JOIN arrondissement_position ap 
        ON a.id_arrondissement = ap.id_arrondissement
    GROUP BY a.id_arrondissement
) surfaces
    ON SDO_INSIDE(m.position, surfaces.surface) = 'TRUE';


---

-- #### **3. Création de la vue finale**

sql
CREATE OR REPLACE VIEW maison_arrondissement AS
SELECT 
    m.id AS id_maison, 
    a.id_arrondissement
FROM maison m
JOIN (
    SELECT 
        a.id_arrondissement, 
        SDO_GEOM.SDO_CONVEXHULL(
            SDO_AGGR_MDSYS.SDO_CONCAT_LINES(
                CAST(COLLECT(ap.position) AS SDO_GEOMETRY_ARRAY)
            )
        ) AS surface
    FROM arrondissement a
    JOIN arrondissement_position ap 
        ON a.id_arrondissement = ap.id_arrondissement
    GROUP BY a.id_arrondissement
) surfaces
    ON SDO_INSIDE(m.position, surfaces.surface) = 'TRUE';


---

SELECT * FROM maison_arrondissement;
