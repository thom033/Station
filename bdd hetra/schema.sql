CREATE TABLE type_tafo (
    id_type_tafo NUMBER PRIMARY KEY,
    nom VARCHAR2(100),
    coefficient NUMBER
);

CREATE TABLE type_rindrina (
    id_type_rindrina NUMBER PRIMARY KEY,
    nom VARCHAR2(100),
    coefficient NUMBER
);
CREATE TABLE maison (
    id NUMBER PRIMARY KEY,
    nom VARCHAR2(100),
    longeur NUMBER,
    largeur NUMBER,
    nbr_etage NUMBER,
    position SDO_GEOMETRY
);

CREATE TABLE maison_detaills (
    id_maison_detaills NUMBER PRIMARY KEY,
    id_maison varchar(50),
    id_type_rindrina varchar(50),
    id_type_tafo varchar(50),
    FOREIGN KEY (id_maison) REFERENCES maison(id),
    FOREIGN KEY (id_type_rindrina) REFERENCES type_rindrina(id_type_rindrina),
    FOREIGN KEY (id_type_tafo) REFERENCES type_tafo(id_type_tafo)
);

CREATE TABLE arrondissement (
    id_arrondissement varchar(50) PRIMARY KEY,
    nom VARCHAR2(100)
);

CREATE TABLE arrondissement_position (
    id_arrondissement varchar(50),
    position SDO_GEOMETRY,
    FOREIGN KEY (id_arrondissement) REFERENCES arrondissement(id_arrondissement)
);

table hetra{
    id
    prix
    date
}

table paiementP{
    id
    id_maison
    
    date
}