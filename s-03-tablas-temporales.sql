--@Autor(es):--Sánchez Díaz María Beatriz
			 --Pérez Quiroz Miguel Angel
--@Fecha creación: 03/06/2019
--@Descripción:Script 3- tablas temporales

--TABLA TEMPORAL DE LOS CENTORS DE OPERACIONES,
--CONTIENE TODOS LOS ATRIBUTOS DE SUBTIPOS

CREATE GLOBAL TEMPORARY TABLE CENTROS_OPERACIONES_TEMP(
	CENTRO_OPERACIONES_ID		NUMBER(10, 0),
    CLAVE_CENTRO_OPERACIONES	VARCHAR2(6),
    NUM_TELEFONICO				NUMBER(10, 0),
    DIRECCION					VARCHAR2(200),
    ALMACEN_CONTINGENCIA_ID		NUMBER(10, 0),
    TIPO						CHAR(1),
    DOCUMENTO					BLOB,
    RFC							VARCHAR2(12),
    PAGINA_WEB					VARCHAR2(100),
    GERENTE_ID					NUMBER(10,0),
    CALL_CENTER				NUMBER(12, 0),
    CLAVE_OFICINA				VARCHAR2(40),
    NOMBRE						VARCHAR2(40)
) on commit delete rows;

