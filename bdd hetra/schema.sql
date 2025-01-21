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
    id_maison NUMBER,
    id_type_rindrina NUMBER,
    id_type_tafo NUMBER,
    FOREIGN KEY (id_maison) REFERENCES maison(id),
    FOREIGN KEY (id_type_rindrina) REFERENCES type_rindrina(id_type_rindrina),
    FOREIGN KEY (id_type_tafo) REFERENCES type_tafo(id_type_tafo)
);

CREATE TABLE arrondissement (
    id_arrondissement NUMBER PRIMARY KEY,
    nom VARCHAR2(100)
);

CREATE TABLE arrondissement_position (
    id_arrondissement NUMBER,
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