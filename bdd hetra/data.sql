-- Insérer des données de référence dans la table type_tafo
INSERT INTO type_tafo (id_type_tafo, nom, coefficient) VALUES (1, 'Tafo falafa', 1.0);
INSERT INTO type_tafo (id_type_tafo, nom, coefficient) VALUES (2, 'Tafo tôle', 1.5);
INSERT INTO type_tafo (id_type_tafo, nom, coefficient) VALUES (3, 'Tafo ravinala', 1.2);

-- Insérer des données de référence dans la table type_rindrina
INSERT INTO type_rindrina (id_type_rindrina, nom, coefficient) VALUES (1, 'Rindrina falafa', 1.0);
INSERT INTO type_rindrina (id_type_rindrina, nom, coefficient) VALUES (2, 'Rindrina brique', 1.5);
INSERT INTO type_rindrina (id_type_rindrina, nom, coefficient) VALUES (3, 'Rindrina bois', 1.2);
INSERT INTO type_rindrina (id_type_rindrina, nom, coefficient) VALUES (4, 'Rindrina beton', 2.0);

-- Insertion de données dans la table `maison`
-- Insertion de données dans la table `maison`
INSERT INTO maison (id, nom, longeur, largeur, nbr_etage, position) 
VALUES ('M1', 'Maison Bleue', 20, 15, 2, SDO_GEOMETRY(2001, 8307, SDO_POINT_TYPE(45.764043, 4.835659, NULL), NULL, NULL));

INSERT INTO maison (id, nom, longeur, largeur, nbr_etage, position) 
VALUES ('M2', 'Villa Verte', 30, 20, 1, SDO_GEOMETRY(2001, 8307, SDO_POINT_TYPE(48.856614, 2.3522219, NULL), NULL, NULL));

INSERT INTO maison (id, nom, longeur, largeur, nbr_etage, position) 
VALUES ('M3', 'Chalet Rouge', 25, 18, 3, SDO_GEOMETRY(2001, 8307, SDO_POINT_TYPE(43.710173, 7.261953, NULL), NULL, NULL));

INSERT INTO maison (id, nom, longeur, largeur, nbr_etage, position) 
VALUES ('M4', 'Bungalow Jaune', 15, 10, 1, SDO_GEOMETRY(2001, 8307, SDO_POINT_TYPE(44.837789, -0.57918, NULL), NULL, NULL));

INSERT INTO maison (id, nom, longeur, largeur, nbr_etage, position) 
VALUES ('M5', 'Manoir Blanc', 40, 35, 4, SDO_GEOMETRY(2001, 8307, SDO_POINT_TYPE(50.62925, 3.057256, NULL), NULL, NULL));


-- Insertion de données dans la table `paiement`
-- Insertion de données dans la table `paiement`
INSERT INTO paiement (id, id_maison, mois, annee, date_paiement) VALUES ('P1', 'M1', 1, 2025, TO_DATE('2025-01-15', 'YYYY-MM-DD'));
INSERT INTO paiement (id, id_maison, mois, annee, date_paiement) VALUES ('P2', 'M2', 2, 2025, TO_DATE('2025-02-20', 'YYYY-MM-DD'));
INSERT INTO paiement (id, id_maison, mois, annee, date_paiement) VALUES ('P3', 'M1', 3, 2025, TO_DATE('2025-03-10', 'YYYY-MM-DD'));
INSERT INTO paiement (id, id_maison, mois, annee, date_paiement) VALUES ('P4', 'M3', 1, 2025, TO_DATE('2025-01-25', 'YYYY-MM-DD'));
INSERT INTO paiement (id, id_maison, mois, annee, date_paiement) VALUES ('P5', 'M2', 4, 2025, TO_DATE('2025-04-05', 'YYYY-MM-DD'));
INSERT INTO paiement (id, id_maison, mois, annee, date_paiement) VALUES ('P6', 'M1', 5, 2025, TO_DATE('2025-05-18', 'YYYY-MM-DD'));
INSERT INTO paiement (id, id_maison, mois, annee, date_paiement) VALUES ('P7', 'M3', 6, 2025, TO_DATE('2025-06-30', 'YYYY-MM-DD'));
INSERT INTO paiement (id, id_maison, mois, annee, date_paiement) VALUES ('P8', 'M4', 2, 2025, TO_DATE('2025-02-10', 'YYYY-MM-DD'));
