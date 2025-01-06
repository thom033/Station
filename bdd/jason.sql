-- table prelevement lubrifiant

CREATE TABLE PrelevementLub(
    id VARCHAR2(20) NOT NULL ENABLE,
    idPompiste VARCHAR2(20) ,
    idMagasin VARCHAR2(20) ,
    idProduit VARCHAR2(20) ,
    daty DATE ,
    heure VARCHAR2(10) ,
    qte NUMBER(10,2) ,
    idPrelevementAnterieur VARCHAR2(20) ,
    CONSTRAINT "PRELEVEMENTLUB_pk" PRIMARY KEY (id)
);

CREATE SEQUENCE SEQPRELEVEMENTLUB INCREMENT BY 1 MINVALUE 1 MAXVALUE 999999 NOCYCLE NOCACHE NOORDER; 

CREATE OR REPLACE FUNCTION GETSEQPRELEVEMENTLUB RETURN NUMBER
IS
	retour NUMBER;
BEGIN
	SELECT SEQPRELEVEMENTLUB.NEXTVAL INTO retour FROM DUAL;
	RETURN retour;
END ;
/

