-- ##### Création de la table des Communes #####
CREATE TABLE commune (
    id_commune VARCHAR2(50) PRIMARY KEY, -- Identifiant unique de la commune
    nom VARCHAR2(100) NOT NULL UNIQUE    -- Nom unique de la commune
);

ALTER TABLE commune ADD val VARCHAR2(50) NOT NULL;

-- ##### Création de la table des Arrondissements #####
CREATE TABLE arrondissement (
    id_arrondissement VARCHAR2(50) PRIMARY KEY, -- Identifiant unique de l'arrondissement
    id_commune VARCHAR2(50) NOT NULL,           -- Référence vers la commune
    nom VARCHAR2(100) NOT NULL,
    geometry SDO_GEOMETRY,                 -- Nom de l'arrondissement
    FOREIGN KEY (id_commune) REFERENCES commune(id_commune) -- Clé étrangère vers la table des communes
);
-- ##### Création de la table des prix d'impôts par m² #####
CREATE TABLE prix_impot (
    id_prix VARCHAR2(50) PRIMARY KEY, -- Identifiant unique du prix d'impôt
    id_commune VARCHAR2(50) NOT NULL, -- Référence vers la commune
    valeur NUMBER(10, 2) NOT NULL,    -- Valeur du prix par m²
    mois NUMBER,  
    annee NUMBER,
    FOREIGN KEY (id_commune) REFERENCES commune(id_commune) -- Clé étrangère vers la table des communes
);

-- ##### Création de la table des propriétaires #####
CREATE TABLE proprietaire (
    id VARCHAR2(50) PRIMARY KEY, -- Identifiant unique du propriétaire
    nom VARCHAR2(100) NOT NULL   -- Nom du propriétaire
);
-- ##### Création de la table des bâtiments (maison) #####
CREATE TABLE maison (
    id_maison VARCHAR2(50) PRIMARY KEY, -- Identifiant unique du bâtiment
    id_proprietaire VARCHAR2(50) NOT NULL, -- Identifiant du propriétaire
    nom VARCHAR2(100) NOT NULL,        -- Nom du bâtiment
    longitude NUMBER NOT NULL,  -- Coordonnée longitude
    latitude NUMBER NOT NULL,
    FOREIGN KEY (id_proprietaire) REFERENCES proprietaire(id) 
);
-- ##### Création de la table type_tafo #####
CREATE TABLE type_tafo (
    id_type_tafo VARCHAR2(50) PRIMARY KEY,
    nom VARCHAR2(100) NOT NULL
);

-- ##### Création de la table type_rindrina #####
CREATE TABLE type_rindrina (
    id_type_rindrina VARCHAR2(50) PRIMARY KEY,
    nom VARCHAR2(100) NOT NULL
);

-- ##### Création de la table des surfaces des bâtiments #####
CREATE TABLE maison_details (
    id_maison_details VARCHAR2(50),
    id_maison VARCHAR2(50) NOT NULL,                                     
    longueur NUMBER(10, 2) NOT NULL,                             
    largeur NUMBER(10, 2) NOT NULL,                              
    nb_etages NUMBER NOT NULL, 
    id_type_tafo VARCHAR2(50) NOT NULL,
    id_type_rindrina VARCHAR2(50) NOT NULL,
    PRIMARY KEY (id_maison_details),                          
    FOREIGN KEY (id_maison) REFERENCES maison(id_maison),
    FOREIGN KEY (id_type_tafo) REFERENCES type_tafo(id_type_tafo),
    FOREIGN KEY (id_type_rindrina) REFERENCES type_rindrina(id_type_rindrina)
);

-- ##### Création de la table type_tafo_coefficient #####
CREATE TABLE type_tafo_coefficient (
    id_type_tafo VARCHAR2(50) NOT NULL,
    coefficient NUMBER NOT NULL,
    dates DATE NOT NULL,
    FOREIGN KEY (id_type_tafo) REFERENCES type_tafo(id_type_tafo)
);


-- ##### Création de la table type_rindrina_coefficient #####
CREATE TABLE type_rindrina_coefficient (
    id_type_rindrina VARCHAR2(50) NOT NULL,
    coefficient NUMBER NOT NULL,
    dates DATE NOT NULL,
    FOREIGN KEY (id_type_rindrina) REFERENCES type_rindrina(id_type_rindrina)
);


-- ##### Création de la table des mpiasa #####
CREATE TABLE mpiasa (
    id VARCHAR2(50) PRIMARY KEY, -- Identifiant unique de mpiasa
    id_commune VARCHAR2(50) NOT NULL, -- Référence vers la commune
    FOREIGN KEY (id_commune) REFERENCES commune(id_commune) -- Clé étrangère vers la table des communes
);

CREATE table paiement (
    id VARCHAR2(50) PRIMARY KEY,
    mois NUMBER,
    annee NUMBER,
    id_maison VARCHAR2(50) not null,
    dates date not null,
    FOREIGN KEY (id_maison) REFERENCES maison(id_maison)
);

-- Métadonnées spatiales pour la table arrondissements
INSERT INTO USER_SDO_GEOM_METADATA (TABLE_NAME, COLUMN_NAME, DIMINFO, SRID)
VALUES (
    'arrondissement',
    'GEOMETRY',
    SDO_DIM_ARRAY(
        SDO_DIM_ELEMENT('LONGITUDE', -180, 180, 0.0001),
        SDO_DIM_ELEMENT('LATITUDE', -90, 90, 0.0001)
    ),
    4326 -- SRID pour le système de coordonnées WGS 84
);

CREATE INDEX arrondissement_spatial_idx
ON arrondissement(geometry)
INDEXTYPE IS MDSYS.SPATIAL_INDEX;

-- View Pour savoir maison, arrondissement , commune
CREATE or REPLACE view maison_commune as
SELECT
    m.id_maison,
    a.id_arrondissement,
    a.id_commune 
FROM
    arrondissement a,
    maison m
WHERE
    SDO_CONTAINS(a.geometry, SDO_GEOMETRY(2001, 4326, SDO_POINT_TYPE(m.longitude, m.latitude, NULL), NULL, NULL)) = 'TRUE';
