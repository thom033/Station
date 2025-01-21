-- Sequence for type_tafo
CREATE SEQUENCE seq_type_tafo
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Sequence for type_rindrina
CREATE SEQUENCE seq_type_rindrina
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Sequence for maison
CREATE SEQUENCE seq_maison
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Sequence for maison_detaills
CREATE SEQUENCE seq_maison_detaills
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Sequence for arrondissement
CREATE SEQUENCE seq_arrondissement
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Sequence for arrondissement_position
CREATE SEQUENCE seq_arrondissement_position
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Sequence for hetra
CREATE SEQUENCE seq_hetra
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Sequence for paiementP
CREATE SEQUENCE seq_paiementP
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Function for seq_type_tafo
CREATE OR REPLACE FUNCTION get_seq_type_tafo RETURN NUMBER IS
BEGIN
    RETURN seq_type_tafo.NEXTVAL;
END;
/

-- Function for seq_type_rindrina
CREATE OR REPLACE FUNCTION get_seq_type_rindrina RETURN NUMBER IS
BEGIN
    RETURN seq_type_rindrina.NEXTVAL;
END;
/

-- Function for seq_maison
CREATE OR REPLACE FUNCTION get_seq_maison RETURN NUMBER IS
BEGIN
    RETURN seq_maison.NEXTVAL;
END;
/

-- Function for seq_maison_detaills
CREATE OR REPLACE FUNCTION get_seq_maison_detaills RETURN NUMBER IS
BEGIN
    RETURN seq_maison_detaills.NEXTVAL;
END;
/

-- Function for seq_arrondissement
CREATE OR REPLACE FUNCTION get_seq_arrondissement RETURN NUMBER IS
BEGIN
    RETURN seq_arrondissement.NEXTVAL;
END;
/

-- Function for seq_arrondissement_position
CREATE OR REPLACE FUNCTION get_seq_arrondissement_p RETURN NUMBER IS
BEGIN
    RETURN seq_arrondissement_position.NEXTVAL;
END;
/

-- Function for seq_hetra
CREATE OR REPLACE FUNCTION get_seq_hetra RETURN NUMBER IS
BEGIN
    RETURN seq_hetra.NEXTVAL;
END;
/

-- Function for seq_paiementP
CREATE OR REPLACE FUNCTION get_seq_paiementP RETURN NUMBER IS
BEGIN
    RETURN seq_paiementP.NEXTVAL;
END;
/
