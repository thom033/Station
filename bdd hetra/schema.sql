CREATE TABLE type_tafo (
    id_type_tafo VARCHAR2(50) PRIMARY KEY,
    nom VARCHAR2(100),
    coefficient NUMBER
);

CREATE TABLE type_rindrina (
    id_type_rindrina VARCHAR2(50) PRIMARY KEY,
    nom VARCHAR2(100),
    coefficient NUMBER
);

CREATE TABLE maison (
    id VARCHAR2(50) PRIMARY KEY,
    nom VARCHAR2(100),
    longeur NUMBER,
    largeur NUMBER,
    nbr_etage NUMBER,
    position SDO_GEOMETRY
);
ALTER TABLE maison
ADD (
    latitude NUMBER,
    longitude NUMBER
);

CREATE OR REPLACE TRIGGER update_lat_long_after_insert
AFTER INSERT ON maison
FOR EACH ROW
BEGIN
    -- Vérifie si le type SDO_GEOMETRY est non nul
    IF :NEW.position IS NOT NULL THEN
        -- Extraction des coordonnées x (longitude) et y (latitude) du type SDO_GEOMETRY
        :NEW.latitude := :NEW.position.SDO_POINT.X;
        :NEW.longitude := :NEW.position.SDO_POINT.Y;
        
        -- Mise à jour des colonnes latitude et longitude
        UPDATE maison
        SET latitude = :NEW.latitude,
            longitude = :NEW.longitude
        WHERE id = :NEW.id;
    END IF;
END;
/



CREATE TABLE maison_detaills (
    id_maison_detaills VARCHAR2(50) PRIMARY KEY,
    id_maison VARCHAR2(50),
    id_type_rindrina VARCHAR2(50),
    id_type_tafo VARCHAR2(50),
    FOREIGN KEY (id_maison) REFERENCES maison(id),
    FOREIGN KEY (id_type_rindrina) REFERENCES type_rindrina(id_type_rindrina),
    FOREIGN KEY (id_type_tafo) REFERENCES type_tafo(id_type_tafo)
);

CREATE TABLE arrondissement (
    id_arrondissement VARCHAR2(50) PRIMARY KEY,
    nom VARCHAR2(100)
);

CREATE TABLE arrondissement_position (
    id_arrondissement VARCHAR2(50),
    position SDO_GEOMETRY,
    FOREIGN KEY (id_arrondissement) REFERENCES arrondissement(id_arrondissement)
);

CREATE TABLE paiement (
    id VARCHAR2(50) PRIMARY KEY,
    id_maison VARCHAR2(50),
    mois NUMBER, 
    annee NUMBER,
    date_paiement DATE,
    FOREIGN KEY (id_maison) REFERENCES maison(id)
);

CREATE TABLE hetra (
    id_hetra VARCHAR2(50) PRIMARY KEY,
    prix NUMBER(18, 2)
);