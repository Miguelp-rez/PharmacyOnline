--@Autor(es):--Sánchez Díaz María Beatriz
			 --Pérez Quiroz Miguel Angel
--@Fecha creación: 02/06/2019
--@Descripción:Script 2- ddl del caso de estudios


-- CENTRO_OPERACIONES 
CREATE TABLE CENTRO_OPERACIONES(
    CENTRO_OPERACIONES_ID		NUMBER(10, 0)    NOT NULL,
    ES_FARMACIA		NUMBER(1, 0)     NOT NULL,
    ES_OFICINA		NUMBER(1, 0)     NOT NULL,
    ES_ALMACEN		NUMBER(1, 0)     NOT NULL,
    CLAVE		VARCHAR2(6)      NOT NULL,
    NUM_TELEFONICO		NUMBER(10, 0)    NOT NULL,
    DIRECCION		VARCHAR2(200)    NOT NULL,
    CONSTRAINT CENTRO_OPERACIONES_PK PRIMARY KEY (CENTRO_OPERACIONES_ID),
    CONSTRAINT CEN_OPER_OFICINA_FARMARIA_CHK CHECK	((ES_OFICINA + ES_FARMACIA)<=1),
    CONSTRAINT CEN_OPER_OFICINA_ALMACEN_CHK	 CHECK  ((ES_FARMACIA+ ES_ALMACEN)<=1)
);
--ALMACEN
CREATE TABLE ALMACEN(
    CENTRO_OPERACIONES_ID		NUMBER(10, 0)    NOT NULL,
    ALMACEN_CONTINGENCIA_ID		NUMBER(10, 0)    NOT NULL,
    TIPO		CHAR(1)          NOT NULL,
    DOCUMENTO		BLOB             NOT NULL,
    CONSTRAINT ALMACEN_PK PRIMARY KEY (CENTRO_OPERACIONES_ID),
    CONSTRAINT ALMACEN_CENTRO_OPERACIONES_FK FOREIGN KEY (CENTRO_OPERACIONES_ID)
    REFERENCES CENTRO_OPERACIONES(CENTRO_OPERACIONES_ID),
    CONSTRAINT ALMACEN_CONTINGENCIA_ID_FK FOREIGN KEY(ALMACEN_CONTINGENCIA_ID)
    REFERENCES ALMACEN(CENTRO_OPERACIONES_ID),
    CONSTRAINT ALMACEN_TIPO_CHK	CHECK(TIPO IN('M','D','C'))
);

--FARMACIA

CREATE TABLE FARMACIA(
	CENTRO_OPERACIONES_ID		NUMBER(10, 0)    NOT NULL,
    RFC							VARCHAR2(12)     NOT NULL,
    PAGINA_WEB					VARCHAR2(100)    NOT NULL,
    GERENTE_ID					NUMBER(10,0)	 NOT NULL,
    CONSTRAINT FARMACIA_PK PRIMARY KEY (CENTRO_OPERACIONES_ID),
    CONSTRAINT FARMACIA_DENTRO_OPERACIONES_FK FOREIGN KEY (CENTRO_OPERACIONES_ID)
    REFERENCES CENTRO_OPERACIONES(CENTRO_OPERACIONES_ID),
    CONSTRAINT FARMACIA_GERENTE_ID_FK	FOREIGN KEY(GERENTE_ID)
    REFERENCES EMPLEADO(EMPLEADO_ID)
);

--OFICINA

CREATE TABLE OFICINA(
    CENTRO_OPERACIONES_ID		NUMBER(10, 0)    NOT NULL,
    NUM_TELEFONICO				NUMBER(12, 0)    NOT NULL,
    CLAVE						VARCHAR2(40)     NOT NULL CONSTRAINT OFICINA_CLAVE_UK UNIQUE,
    NOMBRE						VARCHAR2(40)     NOT NULL,
    CONSTRAINT OFICINA_PK PRIMARY KEY (CENTRO_OPERACIONES_ID),
    CONSTRAINT OFICINA_CENTRO_OPERACIONES_FK FOREIGN KEY (CENTRO_OPERACIONES_ID)
    REFERENCES CENTRO_OPERACIONES(CENTRO_OPERACIONES_ID),

);

--MEDICAMENTO

CREATE TABLE MEDICAMENTO(
    MEDICAMENTO_ID      NUMBER(10, 0)    NOT NULL,
    SUSTANCIA_ACTIVA    VARCHAR2(40)     NOT NULL,
    DESCRIPCION         VARCHAR2(40)     NOT NULL,
    CONSTRAINT PK5 PRIMARY KEY (MEDICAMENTO_ID)
);

--NOMBRES_MEDICAMENTO

CREATE TABLE NOMBRE_MEDICAMENTO(
    NOMBRE_MEDICAMENTO_ID    	NUMBER(10,0)    NOT NULL,
    NOMBRE 						VARCHAR2(40)    NOT NULL,
    MEDICAMENTO_ID           	NUMBER(10,0)    NOT NULL,
    CONSTRAINT NOMBRES_MEDICAMENTO_PK PRIMARY KEY (NOMBRES_MEDICAMENTO_ID),
    CONSTRAINT NOMBRES_MEDICAMENTO_ID_FK FOREING KEY(MEDICAMENTO_ID)
    REFERENCES MEDICAMENTO(MEDICAMENTO_ID)
);

--PRESENTACION_MEDICAMENTO

CREATE TABLE PRESENTACION_MEDICAMENTO(
    PRESENTACION_MEDICAMENTO_ID    NUMBER(10,0)    NOT NULL,
    MEDICAMENTO_ID 				   NUMBER(10,0)
    DESCRIPCION                    VARCHAR2(40)     NOT NULL,
    CANTIDAD                       VARCHAR2(40)     NOT NULL,
    CONSTRAINT PRESENTACION_MEDICAMENTO_PK PRIMARY KEY (PRESENTACION_MEDICAMENTO_ID, MEDICAMENTO_ID),
    CONSTRAINT PRE_MED_MEDICAMENTO_ID_FK FOREIGN KEY (MEDICAMENTO_ID)
    REFERENCES MEDICAMENTO(MEDICAMENTO_ID)
);



--FARMACIA-MEDICAMENTO
------------------
CREATE TABLE FARMACIA_MEDICAMENTO(
	UNIDADES_DISPONIBLES 	NUMBER(10,0)	NOT NULL,
	MEDICAMENTO_ID 		 	NUMBER(10,0)	NOT NULL,
	FARMACIA_ID 			NUMBER(10,0)	NOT NULL,
	PRESENTACION_MEDICAMENTO_ID 	NUMBER(10,0) 	NOT NULL,
	CONSTRAINT FARMACIA_MED_MEDICAMENTO_ID_FK FOREIGN KEY(MEDICAMENTO_ID)
	REFERENCES PRESENTACION_MEDICAMENTO(MEDICAMENTO_ID),
	CONSTRAINT FARMACIA_MED_FARMACIA_ID_FK FOREIGN KEY(FARMACIA_ID)
	REFERENCES FARMACIA(CENTRO_OPERACIONES_ID),
	CONSTRAINT FARMACIA_MED_PRESENTACION_MED_ID_FK FOREIGN KEY(PRESENTACION_MEDICAMENTO_ID)
	REFERENCES PRESENTACION_MEDICAMENTO(PRESENTACION_MEDICAMENTO_ID)

);


--EMPLEADO

CREATE TABLE EMPLEADO(
    EMPLEADO_ID              NUMBER(10, 0)    NOT NULL,
    NOMBRE                   VARCHAR2(40)     NOT NULL,
    RFC                  	 VARCHAR2(12)     NOT NULL,
    APELLIDO_PATERNO         VARCHAR2(40)     NOT NULL,
    APELLIDO_MATERNO         VARCHAR2(40)     NOT NULL,
    FECHA_INGRESO            DATE             NOT NULL,
    CONSTRAINT EMPLEADO_PK PRIMARY KEY (EMPLEADO_ID),
    CONSTRAINT EMPLEADO_RFC_UK	UNIQUE (RFC)
);

--OPERACION_ALMACEN

CREATE TABLE OPERACION_ALMACEN(
	OPERACION_ALMACEN_ID		 NUMBER(10,0)	  NOT NULL,
    UNIDADES_TOTALES             NUMBER(10, 0)    NOT NULL,
    FECHA_EVENTO                 DATE             DEFAULT SYSDATE,
    TIPO_EVENTO                  CHAR(1)          NOT NULL,
    ALMACEN_ID        			 NUMBER(10, 0)    NOT NULL,
    EMPLEADO_ID                  NUMBER(10, 0)    NOT NULL,
    CONSTRAINT OPERACION_ALMACEN_PK PRIMARY KEY(OPERACION_ALMACEN_ID),
    CONSTRAINT OPER_ALMACEN_ALMACEN_ID_FK	FOREIGN KEY(ALMACEN_ID)
    REFERENCES ALMACEN(CENTRO_OPERACIONES_ID),
    CONSTRAINT OPER_ALMACEN_EMPLEADO_ID_FK	FOREIGN KEY(EMPLEADO_ID)
    REFERENCES EMPLEADO(EMPLEADO_ID),
    CONSTRAINT OPERACION_ALMACEN_TIPO_EVENTO_CHK CHECK(TIPO_EVENTO IN('SALIDA','ENTRADA'))
);

--ALMACEN_MEDICAMENTO

CREATE TABLE ALMACEN_MEDICAMENTO(
    ALMACEN_MEDICAMENTO_ID       NUMBER(10, 0)    NOT NULL,
    UNIDADES_MEDICAMENTO         NUMBER(10, 0)    NOT NULL,
    OPERACION_ALMACEN_ID   		 NUMBER(10, 0)    NOT NULL,
    MEDICAMENTO_ID               NUMBER(10, 0)    NOT NULL,
    CONSTRAINT ALMACEN_MEDICAMENTO_PK PRIMARY KEY (ALMACEN_MEDICAMENTO_ID)
    CONSTRAINT ALM_MED_OPERACION_ALMACEN_ID_FK FOREIGN KEY(OPERACION_ALMACEN_ID)
    REFERENCES OPERACION_ALMACEN(OPERACION_ALMACEN_ID),
    CONSTRAINT ALM_MED_MEDICAMENTO_ID_FK	FOREIGN KEY(MEDICAMENTO_ID)
    REFERENCES MEDICAMENTO(MEDICAMENTO_ID)
);

--CLIENTE


CREATE TABLE CLIENTE(
    CLIENTE_ID          NUMBER(10, 0)    NOT NULL,
    NOMBRE              VARCHAR2(40)     NOT NULL,
    APELLIDO_PATERNO    VARCHAR2(40)     NOT NULL,
    APELLIDO_MATERNO    VARCHAR2(40)     NOT NULL,
    NUM_TELEFONICO      NUMBER(10,0)    NOT NULL,
    EMAIL               VARCHAR2(100),
    CURP                VARCHAR2(16)     NOT NULL,
    DIRECCION			VARCHAR2(400)	 NOT NULL,
    RFC AS (SUBSTR(CURP,0,10)) VIRTUAL,  --COLUMNA VIRTUAL
    CONSTRAINT CLIENTE_PK PRIMARY KEY (CLIENTE_ID),
    CONSTRAINT CLIENTE_RFC_UK	UNIQUE(RFC),


);


--TARJETA
CREATE TABLE TARJETA(
    TARJETA_ID     NUMBER(10, 0)    NOT NULL,
    NUM_TARJETA    NUMBER(16, 0)    NOT NULL,
    MES            NUMBER(2, 0)     NOT NULL,
    ANIO           NUMBER(2, 0)     NOT NULL,
    CLIENTE_ID     NUMBER(10, 0)    NOT NULL,
    CONSTRAINT TARJETA_ID PRIMARY KEY (TARJETA_ID),
    CONSTRAINT TARJETA_CLIENTE_ID_FK  FOREIGN KEY(CLIENTE_ID)
    REFERENCES CLIENTE(CLIENTE_ID)
);

--UBICACION
CREATE TABLE UBICACION(
    UBICACION_ID    NUMBER(10, 0)    NOT NULL,
    LATITUD         VARCHAR2(40)     NOT NULL,
    LONGITUD        VARCHAR2(40)     NOT NULL,
    CONSTRAINT UBICACION_PK PRIMARY KEY (UBICACION_ID)
);

--STATUS_PEDIDO

CREATE TABLE STATUS_PEDIDO(
    STATUS_PEDIDO_ID      NUMBER(10, 0)    NOT NULL,
    CLAVE          VARCHAR2(40)     NOT NULL,
    DESCRIPCION    VARCHAR2(100)    NOT NULL,
    CONSTRAINT STATUS_PEDIDO_ID PRIMARY KEY (STATUS_PEDIDO_ID)
);


--PEDIDO
CREATE TABLE PEDIDO(
    PEDIDO_ID        NUMBER(10, 0)    NOT NULL,
    FECHA            DATE             NOT NULL,
    FOLIO            VARCHAR2(13)     NOT NULL,
    IMPORTE_TOTAL    NUMBER(10, 2)    NOT NULL,
    STATUS_ID        NUMBER(10, 0)    NOT NULL,
    UBICACION_ID     NUMBER(10, 0)    NOT NULL,
    CLIENTE_ID       NUMBER(10, 0)    NOT NULL,
    RESPONSABLE_ID      NUMBER(10, 0)    NOT NULL,
    CONSTRAINT PEDIDO PRIMARY KEY (PEDIDO_ID),
    CONSTRAINT PEDIDO_STATUS_ID_FK FOREIGN KEY (STATUS_ID)
    REFERENCES STATUS_PEDIDO(STATUS_PEDIDO_ID),
    CONSTRAINT PEDIDO_UBICACION_ID_FK	FOREIGN KEY(UBICACION_ID)
    REFERENCES UBICACION(UBICACION_ID),
    CONSTRAINT PEDIDO_CLIENTE_ID_FK FOREIGN KEY (CLIENTE_ID)
    REFERENCES CLIENTE(CLIENTE_ID),
    CONSTRAINT PEDIDO_EMPLEADO_ID_FK FOREIGN KEY(RESPONSABLE_ID)
    REFERENCES EMPLEADO(EMPLEADO_ID)
);


--HISTORICO_STATUS_PEDIDO

CREATE TABLE HISTORICO_STATUS_PEDIDO(
	HISTORICO_STATUS_PEDIDO_ID		NUMBER(10,0)	NOT NULL,
	FECHA_STATUS_PEDIDO				DATE			DEFAULT SYSDATE,
	PEDIDO_ID 						NUMBER(10,0)	NOT NULL,
	STATUS_PEDIDO_ID 				NUMBER(10,0)	NOT NULL

	CONSTRAINT HISTORICO_STATUS_PEDIDO_PK	PRIMARY KEY(HISTORICO_STATUS_PEDIDO_ID),
	CONSTRAINT HISTORICO_PEDIDO_ID_FK FOREIGN KEY(PEDIDO_ID)
	REFERENCES PEDIDO(PEDIDO_ID),
	CONSTRAINT	HISTORICO_SP_STATUS_PEDIDO_ID_FK FOREIGN KEY(HISTORICO_STATUS_PEDIDO_ID)
	REFERENCES	STATUS_PEDIDO(STATUS_PEDIDO_ID)
);

--DETALLE_PEDIDO

CREATE TABLE DETALLE_PEDIDO(
	DETALLE_PEDIDO_ID 		NUMBER(10,0)	NOT NULL,
	PEDIDO_ID 				NUMBER(10,0)	NOT NULL,
	CENTRO_OPERACIONES_ID	NUMBER(10,0)	NOT NULL,
	PRESENTACION_MEDICAMENTO_ID 	NUMBER(10,0)	NOT NULL,
	UNIDADES_MEDICAMENTO 	NUMBER(10,0)	NOT NULL,
	MEDICAMENTO_ID 			NUMBER(10,0)	NOT NULL,
	CONSTRAINT DET_PED_PEDIDO_ID_FK 	FOREIGN KEY(DETALLE_PEDIDO_ID)
	REFERENCES PEDIDO(PEDIDO_ID),
	CONSTRAINT DET_PED_CENTRO_OPERACIONES_ID_FK FOREIGN KEY(CENTRO_OPERACIONES_ID)
	REFERENCES FARMACIA(CENTRO_OPERACIONES_ID),
	CONSTRAINT DET_PED_PRESENTACION_MED_ID_FK 	FOREIGN KEY(PRESENTACION_MEDICAMENTO_ID)
	REFERENCES PRESENTACION_MEDICAMENTO(PRESENTACION_MEDICAMENTO_ID),
	CONSTRAINT DET_PED_MEDICAMENTO_ID_FK 	FOREIGN KEY(MEDICAMENTO_ID)
	REFERENCES PRESENTACION_MEDICAMENTO(MEDICAMENTO_ID)
);


