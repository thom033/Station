INSERT INTO commune (id_commune, nom) VALUES ('CUA', 'Commune Urbaine d''Antananarivo');
INSERT into mpiasa values (1060,'CUA');


INSERT INTO arrondissement (id_arrondissement, id_commune, nom) 
VALUES ('A1', 'CUA', 'Arrondissement 1');

INSERT INTO arrondissement (id_arrondissement, id_commune, nom) 
VALUES ('A2', 'CUA', 'Arrondissement 2');


-- ##### Insérer des polygones (géométrie des arrondissements) #####
INSERT INTO polygone (id_polygone, id_arrondissement, position) 
VALUES ('P1', 'A1', SDO_GEOMETRY(2003, 8307, NULL, 
    SDO_ELEM_INFO_ARRAY(1,1003,1), 
    SDO_ORDINATE_ARRAY(10, 10, 20, 10, 20, 20, 10, 20, 10, 10))); -- Polygone pour A1

INSERT INTO polygone (id_polygone, id_arrondissement, position) 
VALUES ('P2', 'A2', SDO_GEOMETRY(2003, 8307, NULL, 
    SDO_ELEM_INFO_ARRAY(1,1003,1), 
    SDO_ORDINATE_ARRAY(30, 30, 40, 30, 40, 40, 30, 40, 30, 30))); -- Polygone pour A2

-- ##### Insérer des maisons (positions géographiques) #####
INSERT INTO maison (id_maison, id_proprietaire, nom, longitude, latitude, position) 
VALUES ('M1', 'P1', 'Maison 1', 15, 15, SDO_GEOMETRY(2001, 8307, SDO_POINT_TYPE(15, 15, NULL), NULL, NULL)); -- Maison dans A1

INSERT INTO maison (id_maison, id_proprietaire, nom, longitude, latitude, position) 
VALUES ('M2', 'P2', 'Maison 2', 35, 35, SDO_GEOMETRY(2001, 8307, SDO_POINT_TYPE(35, 35, NULL), NULL, NULL)); -- Maison dans A2

INSERT INTO maison (id_maison, id_proprietaire, nom, longitude, latitude, position) 
VALUES ('M3', 'P3', 'Maison 3', 50, 50, SDO_GEOMETRY(2001, 8307, SDO_POINT_TYPE(50, 50, NULL), NULL, NULL)); -- Maison hors de tous les arrondissements
