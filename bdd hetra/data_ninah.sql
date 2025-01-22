ALTER TABLE maison
ADD (
    latitude NUMBER,
    longitude NUMBER
);


-- #### 1. **Ajout des Arrondissements**
-- sql
INSERT INTO arrondissement (id_arrondissement, nom)
VALUES (get_seq_arrondissement(), 'Arrondissement 1');

INSERT INTO arrondissement (id_arrondissement, nom)
VALUES (get_seq_arrondissement(), 'Arrondissement 2');

INSERT INTO arrondissement (id_arrondissement, nom)
VALUES (get_seq_arrondissement(), 'Arrondissement 3');

-- ### 1. **Insertion dans `type_tafo`**
-- sql
INSERT INTO type_tafo (id_type_tafo, nom, coefficient)
VALUES (get_seq_type_tafo(), 'Tafo Métallique', 1.2);

INSERT INTO type_tafo (id_type_tafo, nom, coefficient)
VALUES (get_seq_type_tafo(), 'Tafo en Tuiles', 1.5);

INSERT INTO type_tafo (id_type_tafo, nom, coefficient)
VALUES (get_seq_type_tafo(), 'Tafo en Paille', 0.8);


-- ### 2. **Insertion dans `type_rindrina`**
-- sql
INSERT INTO type_rindrina (id_type_rindrina, nom, coefficient)
VALUES (get_seq_type_rindrina(), 'Rindrina en Béton', 1.8);

INSERT INTO type_rindrina (id_type_rindrina, nom, coefficient)
VALUES (get_seq_type_rindrina(), 'Rindrina en Briques', 1.4);

INSERT INTO type_rindrina (id_type_rindrina, nom, coefficient)
VALUES (get_seq_type_rindrina(), 'Rindrina en Bois', 1.0);

-- Arrondissement 1
INSERT INTO arrondissement_position (id_arrondissement, position)
VALUES (1, SDO_GEOMETRY(2003, NULL, NULL,
  SDO_ELEM_INFO_ARRAY(1, 1003, 1),
  SDO_ORDINATE_ARRAY(47.5136, -18.8907, 47.5200, -18.8907, 47.5200, -18.8850, 47.5136, -18.8850, 47.5136, -18.8907)));

-- Arrondissement 2
INSERT INTO arrondissement_position (id_arrondissement, position)
VALUES (2, SDO_GEOMETRY(2003, NULL, NULL,
  SDO_ELEM_INFO_ARRAY(1, 1003, 1),
  SDO_ORDINATE_ARRAY(47.5201, -18.8908, 47.5265, -18.8908, 47.5265, -18.8851, 47.5201, -18.8851, 47.5201, -18.8908)));

-- Arrondissement 3
INSERT INTO arrondissement_position (id_arrondissement, position)
VALUES (3, SDO_GEOMETRY(2003, NULL, NULL,
  SDO_ELEM_INFO_ARRAY(1, 1003, 1),
  SDO_ORDINATE_ARRAY(47.5266, -18.8909, 47.5330, -18.8909, 47.5330, -18.8852, 47.5266, -18.8852, 47.5266, -18.8909)));

-- Maisons dans Arrondissement 1
INSERT INTO maison (id, nom, longeur, largeur, nbr_etage, position)
VALUES (get_seq_maison(), 'Maison A1-1', 10, 8, 1, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(47.5140, -18.8905, NULL), NULL, NULL));

INSERT INTO maison (id, nom, longeur, largeur, nbr_etage, position)
VALUES (get_seq_maison(), 'Maison A1-2', 12, 9, 2, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(47.5150, -18.8860, NULL), NULL, NULL));

-- Maisons dans Arrondissement 2
INSERT INTO maison (id, nom, longeur, largeur, nbr_etage, position)
VALUES (get_seq_maison(), 'Maison A2-1', 15, 10, 3, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(47.5220, -18.8900, NULL), NULL, NULL));

INSERT INTO maison (id, nom, longeur, largeur, nbr_etage, position)
VALUES (get_seq_maison(), 'Maison A2-2', 14, 11, 2, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(47.5235, -18.8865, NULL), NULL, NULL));

INSERT INTO maison (id, nom, longeur, largeur, nbr_etage, position)
VALUES (get_seq_maison(), 'Maison A2-3', 13, 10, 1, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(47.5240, -18.8870, NULL), NULL, NULL));

-- Maisons dans Arrondissement 3
INSERT INTO maison (id, nom, longeur, largeur, nbr_etage, position)
VALUES (get_seq_maison(), 'Maison A3-1', 16, 12, 3, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(47.5270, -18.8890, NULL), NULL, NULL));

INSERT INTO maison (id, nom, longeur, largeur, nbr_etage, position)
VALUES (get_seq_maison(), 'Maison A3-2', 17, 13, 4, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(47.5285, -18.8860, NULL), NULL, NULL));

INSERT INTO maison (id, nom, longeur, largeur, nbr_etage, position)
VALUES (get_seq_maison(), 'Maison A3-3', 18, 14, 2, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(47.5290, -18.8870, NULL), NULL, NULL));

INSERT INTO maison (id, nom, longeur, largeur, nbr_etage, position)
VALUES (get_seq_maison(), 'Maison A3-4', 19, 15, 5, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(47.5300, -18.8885, NULL), NULL, NULL));

INSERT INTO maison (id, nom, longeur, largeur, nbr_etage, position)
VALUES (get_seq_maison(), 'Maison A3-5', 20, 16, 3, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(47.5320, -18.8890, NULL), NULL, NULL));








-- ### 3. **Insertion dans `maison_detaills`**
-- #### Maisons dans Arrondissement 1
-- sql
INSERT INTO maison_detaills (id_maison_detaills, id_maison, id_type_rindrina, id_type_tafo)
VALUES (get_seq_maison_detaills(), 1, 1, 1);

INSERT INTO maison_detaills (id_maison_detaills, id_maison, id_type_rindrina, id_type_tafo)
VALUES (get_seq_maison_detaills(), 2, 2, 2);


-- #### Maisons dans Arrondissement 2
-- sql
INSERT INTO maison_detaills (id_maison_detaills, id_maison, id_type_rindrina, id_type_tafo)
VALUES (get_seq_maison_detaills(), 3, 3, 3);

INSERT INTO maison_detaills (id_maison_detaills, id_maison, id_type_rindrina, id_type_tafo)
VALUES (get_seq_maison_detaills(), 4, 1, 2);

INSERT INTO maison_detaills (id_maison_detaills, id_maison, id_type_rindrina, id_type_tafo)
VALUES (get_seq_maison_detaills(), 5, 2, 1);


-- #### Maisons dans Arrondissement 3
-- sql
INSERT INTO maison_detaills (id_maison_detaills, id_maison, id_type_rindrina, id_type_tafo)
VALUES (get_seq_maison_detaills(), 6, 1, 3);

INSERT INTO maison_detaills (id_maison_detaills, id_maison, id_type_rindrina, id_type_tafo)
VALUES (get_seq_maison_detaills(), 7, 3, 2);

INSERT INTO maison_detaills (id_maison_detaills, id_maison, id_type_rindrina, id_type_tafo)
VALUES (get_seq_maison_detaills(), 8, 2, 3);

INSERT INTO maison_detaills (id_maison_detaills, id_maison, id_type_rindrina, id_type_tafo)
VALUES (get_seq_maison_detaills(), 9, 3, 1);

INSERT INTO maison_detaills (id_maison_detaills, id_maison, id_type_rindrina, id_type_tafo)
VALUES (get_seq_maison_detaills(), 10, 1, 2);




-- Mise à jour Maison A1-1
UPDATE maison
SET latitude = -18.8905, 
    longitude = 47.5140
WHERE nom = 'Maison A1-1';

-- Mise à jour Maison A1-2
UPDATE maison
SET latitude = -18.8860, 
    longitude = 47.5150
WHERE nom = 'Maison A1-2';

-- Mise à jour Maison A2-1
UPDATE maison
SET latitude = -18.8900, 
    longitude = 47.5220
WHERE nom = 'Maison A2-1';

-- Mise à jour Maison A2-2
UPDATE maison
SET latitude = -18.8865, 
    longitude = 47.5235
WHERE nom = 'Maison A2-2';

-- Mise à jour Maison A2-3
UPDATE maison
SET latitude = -18.8870, 
    longitude = 47.5240
WHERE nom = 'Maison A2-3';

-- Mise à jour Maison A3-1
UPDATE maison
SET latitude = -18.8890, 
    longitude = 47.5270
WHERE nom = 'Maison A3-1';

-- Mise à jour Maison A3-2
UPDATE maison
SET latitude = -18.8860, 
    longitude = 47.5285
WHERE nom = 'Maison A3-2';

-- Mise à jour Maison A3-3
UPDATE maison
SET latitude = -18.8870, 
    longitude = 47.5290
WHERE nom = 'Maison A3-3';

-- Mise à jour Maison A3-4
UPDATE maison
SET latitude = -18.8885, 
    longitude = 47.5300
WHERE nom = 'Maison A3-4';

-- Mise à jour Maison A3-5
UPDATE maison
SET latitude = -18.8890, 
    longitude = 47.5320
WHERE nom = 'Maison A3-5';
