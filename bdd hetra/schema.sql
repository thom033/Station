-- ##### Création de la table des Communes #####
CREATE TABLE commune (
    id_commune VARCHAR2(50) PRIMARY KEY, -- Identifiant unique de la commune
    nom VARCHAR2(100) NOT NULL UNIQUE    -- Nom unique de la commune
);

-- ##### Création de la table des Arrondissements #####
CREATE TABLE arrondissement (
    id_arrondissement VARCHAR2(50) PRIMARY KEY, -- Identifiant unique de l'arrondissement
    id_commune VARCHAR2(50) NOT NULL,           -- Référence vers la commune
    nom VARCHAR2(100) NOT NULL,                 -- Nom de l'arrondissement
    FOREIGN KEY (id_commune) REFERENCES commune(id_commune) -- Clé étrangère vers la table des communes
);

-- ##### Création de la table des Polygones #####
CREATE TABLE polygone (
    id_polygone VARCHAR2(50) PRIMARY KEY, -- Identifiant unique du polygone
    id_arrondissement VARCHAR2(50) NOT NULL, -- Référence vers l'arrondissement
    longitude NUMBER(10, 6) NOT NULL,        -- Coordonnée longitude
    latitude NUMBER(10, 6) NOT NULL,         -- Coordonnée latitude
    FOREIGN KEY (id_arrondissement) REFERENCES arrondissement(id_arrondissement) -- Clé étrangère vers la table des arrondissements
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

-- ##### Création de la table des bâtiments (Trano) #####
CREATE TABLE maison (
    id_trano VARCHAR2(50) PRIMARY KEY, -- Identifiant unique du bâtiment
    id_proprietaire VARCHAR2(50) NOT NULL, -- Identifiant du propriétaire
    nom VARCHAR2(100) NOT NULL,        -- Nom du bâtiment
    longitude NUMBER(10, 6) NOT NULL,  -- Coordonnée longitude
    latitude NUMBER(10, 6) NOT NULL    -- Coordonnée latitude
);

-- ##### Création de la table des surfaces des bâtiments #####
CREATE TABLE maison_detaills (
    id_trano VARCHAR2(50) NOT NULL,                                     
    longueur NUMBER(10, 2) NOT NULL,                             
    largeur NUMBER(10, 2) NOT NULL,                              
    nb_etages NUMBER NOT NULL, 
    id_type_tafo VARCHAR2(50) NOT NULL,
    id_type_rindrina VARCHAR2(50) NOT NULL,
    PRIMARY KEY (id_trano),                          
    FOREIGN KEY (id_trano) REFERENCES maison(id_trano),
    FOREIGN KEY (id_type_tafo) REFERENCES type_tafo(id_type_tafo),
    FOREIGN KEY (id_type_rindrina) REFERENCES type_rindrina(id_type_rindrina)
);

-- ##### Création de la table type_tafo #####
CREATE TABLE type_tafo (
    id_type_tafo VARCHAR2(50) PRIMARY KEY,
    nom VARCHAR2(100) NOT NULL
);

-- ##### Création de la table type_tafo_coefficient #####
CREATE TABLE type_tafo_coefficient (
    id_type_tafo VARCHAR2(50) NOT NULL,
    coefficient NUMBER NOT NULL,
    date DATE NOT NULL,
    FOREIGN KEY (id_type_tafo) REFERENCES type_tafo(id_type_tafo)
);

-- ##### Création de la table type_rindrina #####
CREATE TABLE type_rindrina (
    id_type_rindrina VARCHAR2(50) PRIMARY KEY,
    nom VARCHAR2(100) NOT NULL
);

-- ##### Création de la table type_rindrina_coefficient #####
CREATE TABLE type_rindrina_coefficient (
    id_type_rindrina VARCHAR2(50) NOT NULL,
    coefficient NUMBER NOT NULL,
    date DATE NOT NULL,
    FOREIGN KEY (id_type_rindrina) REFERENCES type_rindrina(id_type_rindrina)
);

-- ##### Création de la table des propriétaires #####
CREATE TABLE proprietaire (
    id VARCHAR2(50) PRIMARY KEY, -- Identifiant unique du propriétaire
    nom VARCHAR2(100) NOT NULL   -- Nom du propriétaire
);

-- ##### Création de la table des mpiasa #####
CREATE TABLE mpiasa (
    id VARCHAR2(50) PRIMARY KEY, -- Identifiant unique de mpiasa
    id_commune VARCHAR2(50) NOT NULL, -- Référence vers la commune
    FOREIGN KEY (id_commune) REFERENCES commune(id_commune) -- Clé étrangère vers la table des communes
);