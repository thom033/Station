
INSERT INTO arrondissement (nom, geometry)
VALUES (
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

INSERT INTO arrondissement (nom, geometry)
VALUES (
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
INSERT INTO arrondissement (nom, geometry)
VALUES (
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

iNSERT INTO COMMUNE (ID, NOM, ZONE)
VALUES (
    1,
    'Commune ANTANANARIVO',
    SDO_GEOMETRY(2003, 4326, NULL,
        SDO_ELEM_INFO_ARRAY(1, 1003, 1),
        SDO_ORDINATE_ARRAY(
            46.66992188, -18.77891637,
            46.91162109, -18.53690856,
            47.22473145, -18.47960906,
            47.50488281, -18.21369822, 
            47.85644531, -18.26065336,
            48.41674805, -18.59418886,
            48.23547363, -18.92707243,
            47.97180176, -19.19705344,
            47.76306152, -19.41479244,
            47.36755371, -19.461413,
            47.12585449, -19.2644798,
            46.76879883, -19.04654131,
            46.66992188, -18.77891637
        )
    )
);

INSERT INTO COMMUNE (ID, NOM, ZONE)
VALUES (
    2,
    'Commune ANTSIRABE',
    SDO_GEOMETRY(2003, 4326, NULL,
        SDO_ELEM_INFO_ARRAY(1, 1003, 1),
        SDO_ORDINATE_ARRAY(
            46.70837402, -19.4717713,
            47.52685547, -19.53390722,
            47.4005127, -19.83389278, 
            47.14782715, -20.05593127,
            46.73583984, -19.95785975, 
            46.42272949, -19.58049348, 
            46.70837402, -19.4717713  
        )
    )
);