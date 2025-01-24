insert into roles values ('commune', ' commune', 6);

insert  into mpiasa values (880681, 'C001');

insert into prix_impot  values (1,'C001',100, 1, 2025);

iNSERT INTO COMMUNE 
VALUES (
    'C001',
    'CUA',
    'Commune ANTANANARIVO'
);

INSERT INTO COMMUNE 
VALUES (
    'C002',
    'CUB',
    'Commune ANTSIRABE'
);

INSERT INTO arrondissement (id_arrondissement,ID_commune ,nom, geometry)
VALUES (
    'A1',
    'C001',
    'Arrondissement 1',
    SDO_GEOMETRY(
        2003, -- Type de géométrie : polygone
        4326, -- SRID pour le système de coordonnées WGS 84
        NULL,
        SDO_ELEM_INFO_ARRAY(1, 1003, 1), -- Indique que c'est un polygone simple
        SDO_ORDINATE_ARRAY(
            47.0805636, -18.589103, -- Point 1
            46.796265, -18.840271, -- Point 2
            46.918488, -18.99235, -- Point 3
            47.176666, -19.028725, -- Point 4
            47.558441, -18.848073, -- Point 5
            47.513123, -18.643793, -- Point 6
            47.194519, -18.563054, -- Point 7
            47.5500, -18.9200, -- Point 8
            47.5000, -18.9100, -- Point 9
            47.4500, -18.9000, -- Point 10
            47.4000, -18.9100, -- Point 11
            47.4000, -18.9500  -- Retour au point 1 pour fermer le polygone
        )
    )
);

INSERT INTO arrondissement (id_arrondissement, ID_commune,nom, geometry)
VALUES (
    'A2',
    'C001',
    'Arrondissement 2',
    SDO_GEOMETRY(
        2003, -- Type de géométrie : polygone
        4326, -- SRID pour le système de coordonnées WGS 84
        NULL,
        SDO_ELEM_INFO_ARRAY(1, 1003, 1), -- Indique que c'est un polygone simple
        SDO_ORDINATE_ARRAY(
            47.7000, -18.9500, -- Point 1
            47.7500, -18.9600, -- Point 2
            47.8000, -18.9700, -- Point 3
            47.8500, -18.9600, -- Point 4
            47.9000, -18.9500, -- Point 5
            47.9500, -18.9400, -- Point 6
            47.9000, -18.9300, -- Point 7
            47.8500, -18.9200, -- Point 8
            47.8000, -18.9100, -- Point 9
            47.7500, -18.9000, -- Point 10
            47.7000, -18.9100, -- Point 11
            47.7000, -18.9500  -- Retour au point 1 pour fermer le polygone
        )
    )
);

-- Arrondissement 3
INSERT INTO arrondissement (id_arrondissement, id_commune ,nom, geometry)
VALUES (
    'A3',
    'C001',
    'Arrondissement 3',
    SDO_GEOMETRY(
        2003, -- Type de géométrie : polygone
        4326, -- SRID pour le système de coordonnées WGS 84
        NULL,
        SDO_ELEM_INFO_ARRAY(1, 1003, 1), -- Indique que c'est un polygone simple
        SDO_ORDINATE_ARRAY(
            47.3000, -18.8500, -- Point 1
            47.3500, -18.8600, -- Point 2
            47.4000, -18.8700, -- Point 3
            47.4500, -18.8600, -- Point 4
            47.5000, -18.8500, -- Point 5
            47.5500, -18.8400, -- Point 6
            47.5000, -18.8300, -- Point 7
            47.4500, -18.8200, -- Point 8
            47.4000, -18.8100, -- Point 9
            47.3500, -18.8000, -- Point 10
            47.3000, -18.8100, -- Point 11
            47.3000, -18.8500  -- Retour au point 1 pour fermer le polygone
        )
    )
);
