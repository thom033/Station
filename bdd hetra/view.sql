-- Vue pour savoir dans quel arrondissement se trouve chaque maison
CREATE OR REPLACE VIEW maison_arrondissement AS
SELECT 
    m.id AS id_maison,
    a.id_arrondissement
FROM 
    maison m
JOIN 
    arrondissement_position ap ON SDO_RELATE(ap.position, m.position, 'mask=contains') = 'TRUE'
JOIN 
    arrondissement a ON ap.id_arrondissement = a.id_arrondissement;

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
    hetra h ON 1 = 1; -- Assuming there is only one row in hetra table, otherwise adjust the join condition

CREATE OR REPLACE VIEW calcul_hetra_paiement AS
SELECT 
    chm.id_maison,
    chm.nom_maison,
    chm.hetra,
    p.mois,
    p.annee,
    p.date_paiement AS date_paiement
FROM 
    calcul_hetra_maison chm
LEFT JOIN 
    paiement p ON chm.id_maison = p.id_maison;

CREATE OR REPLACE VIEW sum_hetra_maison AS
WITH all_months AS (
    SELECT 
        chm.id_maison,
        chm.nom_maison,
        chm.hetra,
        m.mois,
        y.annee
    FROM 
        calcul_hetra_maison chm,
        (SELECT LEVEL AS mois FROM dual CONNECT BY LEVEL <= 12) m,
        (SELECT DISTINCT annee FROM paiement) y
)
SELECT 
    am.id_maison,
    am.nom_maison,
    SUM(CASE WHEN p.date_paiement IS NOT NULL THEN am.hetra ELSE 0 END) AS total_paye,
    SUM(CASE WHEN p.date_paiement IS NULL THEN am.hetra ELSE 0 END) AS total_non_paye
FROM 
    all_months am
LEFT JOIN 
    paiement p ON am.id_maison = p.id_maison AND am.mois = p.mois AND am.annee = p.annee
GROUP BY 
    am.id_maison, am.nom_maison;