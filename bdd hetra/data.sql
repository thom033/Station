iNSERT INTO COMMUNE 
VALUES (
    'C001',
    'CUA',
    'Commune ANTANANARIVO'
);

insert into roles values ('commune', ' commune', 6);

insert  into mpiasa values (880681, 'C001');

insert into prix_impot  values (1,'C001',100, 1, 2024);



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

---- Insérer des données dans la table proprietaire
INSERT INTO proprietaire (id, nom) VALUES ('1', 'P1');
INSERT INTO proprietaire (id, nom) VALUES ('2', 'P2');
INSERT INTO proprietaire (id, nom) VALUES ('3', 'P3');
INSERT INTO proprietaire (id, nom) VALUES ('4', 'P4');
INSERT INTO proprietaire (id, nom) VALUES ('5', 'P5');
INSERT INTO proprietaire (id, nom) VALUES ('6', 'P6');
INSERT INTO proprietaire (id, nom) VALUES ('7', 'P7');
INSERT INTO proprietaire (id, nom) VALUES ('8', 'P8');
INSERT INTO proprietaire (id, nom) VALUES ('9', 'P9');
INSERT INTO proprietaire (id, nom) VALUES ('10', 'P10');
INSERT INTO proprietaire (id, nom) VALUES ('11', 'P11');
INSERT INTO proprietaire (id, nom) VALUES ('12', 'P12');

-- Insérer des données dans la table maison
INSERT INTO maison (id_maison, id_proprietaire, nom, longitude, latitude) VALUES ('1', '1', 'Trano1', 46.984406, -18.868592);
INSERT INTO maison (id_maison, id_proprietaire, nom, longitude, latitude) VALUES ('2', '2', 'Trano2', 47.308502, -18.807757);
INSERT INTO maison (id_maison, id_proprietaire, nom, longitude, latitude) VALUES ('3', '3', 'Trano3', 47.223358, -18.759544);
INSERT INTO maison (id_maison, id_proprietaire, nom, longitude, latitude) VALUES ('4', '4', 'Trano4', 47.985535, -18.63468);
INSERT INTO maison (id_maison, id_proprietaire, nom, longitude, latitude) VALUES ('5', '5', 'Trano5', 48.002014, -18.755723);
INSERT INTO maison (id_maison, id_proprietaire, nom, longitude, latitude) VALUES ('6', '6', 'Trano6', 47.960815, -18.802319);
INSERT INTO maison (id_maison, id_proprietaire, nom, longitude, latitude) VALUES ('7', '7', 'Trano7', 47.562561, -19.176731);
INSERT INTO maison (id_maison, id_proprietaire, nom, longitude, latitude) VALUES ('8', '8', 'Trano8', 47.643585, -19.235121);
INSERT INTO maison (id_maison, id_proprietaire, nom, longitude, latitude) VALUES ('9', '9', 'Trano9', 47.392273, -19.180624);
INSERT INTO maison (id_maison, id_proprietaire, nom, longitude, latitude) VALUES ('10', '10', 'Trano10', 47.60376, -18.491392);
INSERT INTO maison (id_maison, id_proprietaire, nom, longitude, latitude) VALUES ('11', '11', 'Trano11', 47.584534, -18.535692);
INSERT INTO maison (id_maison, id_proprietaire, nom, longitude, latitude) VALUES ('12', '12', 'Trano12', 47.727356, -18.521361);



-- Insérer des données dans la table type_tafo
INSERT INTO type_tafo (id_type_tafo, nom) VALUES ('1', 'Bozaka');
INSERT INTO type_tafo (id_type_tafo, nom) VALUES ('2', 'Tuile');
INSERT INTO type_tafo (id_type_tafo, nom) VALUES ('3', 'Tôle');
INSERT INTO type_tafo (id_type_tafo, nom) VALUES ('4', 'Beton');

-- Insérer des données dans la table type_rindrina
INSERT INTO type_rindrina (id_type_rindrina, nom) VALUES ('1', 'Hazo');
INSERT INTO type_rindrina (id_type_rindrina, nom) VALUES ('2', 'Brique');
INSERT INTO type_rindrina (id_type_rindrina, nom) VALUES ('3', 'Beton');

-- Insérer des données dans la table type_tafo_coefficient
INSERT INTO type_tafo_coefficient (id_type_tafo, coefficient, dates) VALUES ('1', 0.6, TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO type_tafo_coefficient (id_type_tafo, coefficient, dates) VALUES ('2', 0.8, TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO type_tafo_coefficient (id_type_tafo, coefficient, dates) VALUES ('3', 1.1, TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO type_tafo_coefficient (id_type_tafo, coefficient, dates) VALUES ('4', 1.4, TO_DATE('2024-01-01', 'YYYY-MM-DD'));

-- Insérer des données dans la table type_rindrina_coefficient
INSERT INTO type_rindrina_coefficient (id_type_rindrina, coefficient, dates) VALUES ('1', 0.8, TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO type_rindrina_coefficient (id_type_rindrina, coefficient, dates) VALUES ('2', 1.1, TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO type_rindrina_coefficient (id_type_rindrina, coefficient, dates) VALUES ('3', 1.2, TO_DATE('2024-01-01', 'YYYY-MM-DD'));

alter TABLE maison_details  add dates date not null;

-- Insérer des données dans la table maison_details
INSERT INTO maison_details (id_maison_details, id_maison, longueur, largeur, nb_etages, id_type_tafo, id_type_rindrina, dates) VALUES ('1', '1', 400, 200, 2, '3', '3', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO maison_details (id_maison_details, id_maison, longueur, largeur, nb_etages, id_type_tafo, id_type_rindrina, dates) VALUES ('2', '2', 150, 90, 1, '2', '2', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO maison_details (id_maison_details, id_maison, longueur, largeur, nb_etages, id_type_tafo, id_type_rindrina, dates) VALUES ('3', '3', 600, 700, 3, '2', '1', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO maison_details (id_maison_details, id_maison, longueur, largeur, nb_etages, id_type_tafo, id_type_rindrina, dates) VALUES ('4', '4', 300, 150, 1, '1', '3', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO maison_details (id_maison_details, id_maison, longueur, largeur, nb_etages, id_type_tafo, id_type_rindrina, dates) VALUES ('5', '5', 540, 260, 2, '2', '2', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO maison_details (id_maison_details, id_maison, longueur, largeur, nb_etages, id_type_tafo, id_type_rindrina, dates) VALUES ('6', '6', 470, 350, 3, '4', '1', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO maison_details (id_maison_details, id_maison, longueur, largeur, nb_etages, id_type_tafo, id_type_rindrina, dates) VALUES ('7', '7', 220, 100, 1, '3', '2', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO maison_details (id_maison_details, id_maison, longueur, largeur, nb_etages, id_type_tafo, id_type_rindrina, dates) VALUES ('8', '8', 600, 210, 2, '4', '1', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO maison_details (id_maison_details, id_maison, longueur, largeur, nb_etages, id_type_tafo, id_type_rindrina, dates) VALUES ('9', '9', 500, 400, 3, '1', '3', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO maison_details (id_maison_details, id_maison, longueur, largeur, nb_etages, id_type_tafo, id_type_rindrina, dates) VALUES ('10', '10', 250, 300, 4, '2', '3', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO maison_details (id_maison_details, id_maison, longueur, largeur, nb_etages, id_type_tafo, id_type_rindrina, dates) VALUES ('11', '11', 260, 100, 3, '2', '1', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO maison_details (id_maison_details, id_maison, longueur, largeur, nb_etages, id_type_tafo, id_type_rindrina, dates) VALUES ('12', '12', 255.5, 200, 2, '3', '2', TO_DATE('2024-01-01', 'YYYY-MM-DD'));

-- Insérer des données dans la table paiement
INSERT INTO paiement (id, mois, annee, id_maison, dates) VALUES ('1', 1, 2024, '1', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO paiement (id, mois, annee, id_maison, dates) VALUES ('2', 2, 2024, '1', TO_DATE('2024-01-01', 'YYYY-MM-DD'));

INSERT INTO paiement (id, mois, annee, id_maison, dates) VALUES ('3', 1, 2024, '2', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO paiement (id, mois, annee, id_maison, dates) VALUES ('4', 2, 2024, '2', TO_DATE('2024-01-01', 'YYYY-MM-DD'));

INSERT INTO paiement (id, mois, annee, id_maison, dates) VALUES ('5', 1, 2024, '3', TO_DATE('2024-01-01', 'YYYY-MM-DD'));

INSERT INTO paiement (id, mois, annee, id_maison, dates) VALUES ('6', 1, 2024, '4', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO paiement (id, mois, annee, id_maison, dates) VALUES ('7', 2, 2024, '4', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO paiement (id, mois, annee, id_maison, dates) VALUES ('8', 3, 2024, '4', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO paiement (id, mois, annee, id_maison, dates) VALUES ('9', 4, 2024, '4', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO paiement (id, mois, annee, id_maison, dates) VALUES ('10', 5, 2024, '5', TO_DATE('2024-01-01', 'YYYY-MM-DD'));

INSERT INTO paiement (id, mois, annee, id_maison, dates) VALUES ('11', 1, 2024, '5', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO paiement (id, mois, annee, id_maison, dates) VALUES ('12', 2, 2024, '5', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO paiement (id, mois, annee, id_maison, dates) VALUES ('13', 3, 2024, '5', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO paiement (id, mois, annee, id_maison, dates) VALUES ('14', 4, 2024, '5', TO_DATE('2024-01-01', 'YYYY-MM-DD'));


INSERT INTO paiement (id, mois, annee, id_maison, dates) VALUES ('15', 1, 2024, '6', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO paiement (id, mois, annee, id_maison, dates) VALUES ('16', 2, 2024, '6', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO paiement (id, mois, annee, id_maison, dates) VALUES ('17', 3, 2024, '6', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO paiement (id, mois, annee, id_maison, dates) VALUES ('18', 4, 2024, '6', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO paiement (id, mois, annee, id_maison, dates) VALUES ('19', 5, 2024, '6', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO paiement (id, mois, annee, id_maison, dates) VALUES ('20', 6, 2024, '6', TO_DATE('2024-01-01', 'YYYY-MM-DD'));