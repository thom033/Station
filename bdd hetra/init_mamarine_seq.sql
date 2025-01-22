-- Supprimer les tables existantes si elles existent
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE type_tafo CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE type_rindrina CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE maison CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE maison_detaills CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE arrondissement CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE arrondissement_position CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE hetra CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE paiement CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

-- Supprimer les séquences existantes
BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE seq_type_tafo';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -2289 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE seq_type_rindrina';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -2289 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE seq_maison';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -2289 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE seq_maison_detaills';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -2289 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE seq_arrondissement';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -2289 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE seq_arrondissement_position';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -2289 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE seq_hetra';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -2289 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE seq_paiementP';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -2289 THEN
            RAISE;
        END IF;
END;
/
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

-- Recréer les séquences
CREATE SEQUENCE seq_type_tafo START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_type_rindrina START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_maison START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_maison_detaills START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_arrondissement START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_arrondissement_position START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_hetra START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_paiementP START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- Recréer les fonctions
CREATE OR REPLACE FUNCTION get_seq_type_tafo RETURN NUMBER IS
BEGIN
    RETURN seq_type_tafo.NEXTVAL;
END;
/

CREATE OR REPLACE FUNCTION get_seq_type_rindrina RETURN NUMBER IS
BEGIN
    RETURN seq_type_rindrina.NEXTVAL;
END;
/

CREATE OR REPLACE FUNCTION get_seq_maison RETURN NUMBER IS
BEGIN
    RETURN seq_maison.NEXTVAL;
END;
/

CREATE OR REPLACE FUNCTION get_seq_maison_detaills RETURN NUMBER IS
BEGIN
    RETURN seq_maison_detaills.NEXTVAL;
END;
/

CREATE OR REPLACE FUNCTION get_seq_arrondissement RETURN NUMBER IS
BEGIN
    RETURN seq_arrondissement.NEXTVAL;
END;
/

CREATE OR REPLACE FUNCTION get_seq_arrondissement_p RETURN NUMBER IS
BEGIN
    RETURN seq_arrondissement_position.NEXTVAL;
END;
/

CREATE OR REPLACE FUNCTION get_seq_hetra RETURN NUMBER IS
BEGIN
    RETURN seq_hetra.NEXTVAL;
END;
/

CREATE OR REPLACE FUNCTION get_seq_paiementP RETURN NUMBER IS
BEGIN
    RETURN seq_paiementP.NEXTVAL;
END;
/
