-- Vue pour savoir dans quel arrondissement se trouve chaque maison
CREATE OR REPLACE VIEW vue_maison_arrondissement AS
SELECT 
    m.id_maison,
    m.nom AS nom_maison,
    m.longitude AS maison_longitude,
    m.latitude AS maison_latitude,
    a.id_arrondissement,
    a.nom AS nom_arrondissement,
    CASE 
        WHEN SDO_RELATE(
            SDO_GEOMETRY(
                2001,  -- Type de géométrie : point
                8307,  -- SRID (système de coordonnées)
                SDO_POINT_TYPE(m.longitude, m.latitude, NULL),
                NULL,
                NULL
            ),
            SDO_GEOMETRY(
                2003,  -- Type de géométrie : polygone
                8307,
                NULL,
                NULL,
                SDO_ELEM_INFO_ARRAY(1, 1003, 1), -- Élément d'un polygone simple
                SDO_ORDINATE_ARRAY(
                    (SELECT LISTAGG(c.longitude, ', ') WITHIN GROUP (ORDER BY c.id_coordonne) || ',' ||
                            LISTAGG(c.latitude, ', ') WITHIN GROUP (ORDER BY c.id_coordonne)
                     FROM coordonne c WHERE c.id_arrondissement = a.id_arrondissement)
                )
            ),
            'ANYINTERACT' -- Relation entre le point et le polygone
        ) = 'TRUE'
        THEN 'Dans l\'arrondissement'
        ELSE 'Hors de l\'arrondissement'
    END AS status
FROM 
    maison m
JOIN 
    arrondissement a
    ON 1=1; -- Modifier selon vos relations




-- Vue pour calculer le hetra d'une maison
CREATE OR REPLACE VIEW calcul_hetra_maison AS
SELECT 
    m.id AS id_maison,
    m.nom AS nom_maison,
    (m.longeur * m.largeur * m.nbr_etage) AS surface,
    tr.coefficient AS coefficient_rindrina,
    tt.coefficient AS coefficient_tafo,
    h.prix AS prix_par_m2,
    (h.prix * m.longeur * m.largeur * m.nbr_etage * tr.coefficient * tt.coefficient) AS hetra
FROM 
    maison m
JOIN 
    maison_detaills md ON m.id = md.id_maison
JOIN 
    type_rindrina tr ON md.id_type_rindrina = tr.id_type_rindrina
JOIN 
    type_tafo tt ON md.id_type_tafo = tt.id_type_tafo
JOIN 
    hetra h ON 1 = 1; 

CREATE OR REPLACE VIEW calcul_hetra_paiement AS
SELECT 
    chm.id_maison AS id_maison,
    chm.nom_maison AS nom_maison,
    chm.hetra AS hetra,
    p.mois AS mois,
    p.annee AS annee,
    p.date_paiement AS date_paiement
FROM 
    calcul_hetra_maison chm
LEFT JOIN 
    paiement p ON chm.id_maison = p.id_maison;

CREATE OR REPLACE VIEW sum_hetra_maison AS
WITH all_months AS (
    SELECT
        chm.id_maison AS id_maison,
        chm.nom_maison AS nom_maison,
        chm.hetra AS hetra,
        m.mois AS mois,
        y.annee AS annee
    FROM 
        calcul_hetra_maison chm,
        (SELECT LEVEL AS mois FROM dual CONNECT BY LEVEL <= 12) m,
        (SELECT DISTINCT annee FROM paiement) y
)
SELECT 
    am.id_maison,
    am.nom_maison,
    am.annee,
    SUM(CASE WHEN p.date_paiement IS NOT NULL THEN am.hetra ELSE 0 END) AS total_paye,
    SUM(CASE WHEN p.date_paiement IS NULL THEN am.hetra ELSE 0 END) AS total_non_paye
FROM 
    all_months am
LEFT JOIN 
    paiement p ON am.id_maison = p.id_maison AND am.mois = p.mois AND am.annee = p.annee
GROUP BY 
    am.id_maison, am.nom_maison, am.annee;