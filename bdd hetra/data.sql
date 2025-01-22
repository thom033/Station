-- Insérer des données de référence dans la table type_tafo
INSERT INTO type_tafo (id_type_tafo, nom, coefficient) VALUES (1, 'Tafo falafa', 1.0);
INSERT INTO type_tafo (id_type_tafo, nom, coefficient) VALUES (2, 'Tafo tôle', 1.5);
INSERT INTO type_tafo (id_type_tafo, nom, coefficient) VALUES (3, 'Tafo ravinala', 1.2);

-- Insérer des données de référence dans la table type_rindrina
INSERT INTO type_rindrina (id_type_rindrina, nom, coefficient) VALUES (1, 'Rindrina falafa', 1.0);
INSERT INTO type_rindrina (id_type_rindrina, nom, coefficient) VALUES (2, 'Rindrina brique', 1.5);
INSERT INTO type_rindrina (id_type_rindrina, nom, coefficient) VALUES (3, 'Rindrina bois', 1.2);
INSERT INTO type_rindrina (id_type_rindrina, nom, coefficient) VALUES (4, 'Rindrina beton', 2.0);

----------------------------------
--donnee test chat

-- Insérer des données de test pour arrondissement
INSERT INTO arrondissement (id_arrondissement, nom) VALUES ('1', 'Arrondissement 1');
INSERT INTO arrondissement (id_arrondissement, nom) VALUES ('2', 'Arrondissement 2');

-- Insérer des données de test pour arrondissement_position
INSERT INTO arrondissement_position (id_arrondissement, position) VALUES ('1', SDO_GEOMETRY(2003, NULL, NULL, SDO_ELEM_INFO_ARRAY(1,1003,3), SDO_ORDINATE_ARRAY(0,0, 10,0, 10,10, 0,10, 0,0)));
INSERT INTO arrondissement_position (id_arrondissement, position) VALUES ('2', SDO_GEOMETRY(2003, NULL, NULL, SDO_ELEM_INFO_ARRAY(1,1003,3), SDO_ORDINATE_ARRAY(20,20, 30,20, 30,30, 20,30, 20,20)));

-- Insérer des données de test pour maison
INSERT INTO maison (id, nom, longeur, largeur, nbr_etage, position) VALUES ('1', 'Maison 1', 10, 10, 2, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(5, 5, NULL), NULL, NULL));
INSERT INTO maison (id, nom, longeur, largeur, nbr_etage, position) VALUES ('2', 'Maison 2', 15, 15, 3, SDO_GEOMETRY(2001, NULL, SDO_POINT_TYPE(25, 25, NULL), NULL, NULL));

-- Insérer des données de test pour type_rindrina
INSERT INTO type_rindrina (id_type_rindrina, nom, coefficient) VALUES ('1', 'Type Rindrina 1', 1.2);
INSERT INTO type_rindrina (id_type_rindrina, nom, coefficient) VALUES ('2', 'Type Rindrina 2', 1.5);

-- Insérer des données de test pour type_tafo
INSERT INTO type_tafo (id_type_tafo, nom, coefficient) VALUES ('1', 'Type Tafo 1', 1.1);
INSERT INTO type_tafo (id_type_tafo, nom, coefficient) VALUES ('2', 'Type Tafo 2', 1.3);

-- Insérer des données de test pour maison_detaills
INSERT INTO maison_detaills (id_maison_detaills, id_maison, id_type_rindrina, id_type_tafo) VALUES ('1', '1', '1', '1');
INSERT INTO maison_detaills (id_maison_detaills, id_maison, id_type_rindrina, id_type_tafo) VALUES ('2', '2', '2', '2');

-- Insérer des données de test pour hetra
INSERT INTO hetra (id_hetra, prix) VALUES ('1', 100);

----------------------------------------------
INSERT INTO paiement (id, id_maison, mois, annee, date_paiement) VALUES ('1', '1', 1, 2023, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO paiement (id, id_maison, mois, annee, date_paiement) VALUES ('2', '1', 2, 2023, TO_DATE('2023-02-15', 'YYYY-MM-DD'));
INSERT INTO paiement (id, id_maison, mois, annee, date_paiement) VALUES ('3', '1', 3, 2023, TO_DATE('2023-03-15', 'YYYY-MM-DD'));
INSERT INTO paiement (id, id_maison, mois, annee, date_paiement) VALUES ('4', '1', 4, 2023, TO_DATE('2023-04-15', 'YYYY-MM-DD'));
INSERT INTO paiement (id, id_maison, mois, annee, date_paiement) VALUES ('5', '1', 5, 2023, TO_DATE('2023-05-15', 'YYYY-MM-DD'));

INSERT INTO paiement (id, id_maison, mois, annee, date_paiement) VALUES ('6', '2', 1, 2023, TO_DATE('2023-01-20', 'YYYY-MM-DD'));
INSERT INTO paiement (id, id_maison, mois, annee, date_paiement) VALUES ('7', '2', 2, 2023, TO_DATE('2023-02-20', 'YYYY-MM-DD'));
INSERT INTO paiement (id, id_maison, mois, annee, date_paiement) VALUES ('8', '2', 3, 2023, TO_DATE('2023-03-20', 'YYYY-MM-DD'));
INSERT INTO paiement (id, id_maison, mois, annee, date_paiement) VALUES ('9', '2', 4, 2023, TO_DATE('2023-04-20', 'YYYY-MM-DD'));
INSERT INTO paiement (id, id_maison, mois, annee, date_paiement) VALUES ('10', '2', 5, 2023, TO_DATE('2023-05-20', 'YYYY-MM-DD'));