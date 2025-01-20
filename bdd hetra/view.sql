CREATE VIEW arrondissement_polygone AS
SELECT 
    a.id_arrondissement,
    a.nom,
    LISTAGG(ap.latitude || ' ' || ap.longitude, ', ') WITHIN GROUP (ORDER BY ap.id_arrondissement) AS polygon
FROM 
    arrondissement a
JOIN 
    arrondissement_position ap ON a.id_arrondissement = ap.id_arrondissement
GROUP BY 
    a.id_arrondissement, a.nom;