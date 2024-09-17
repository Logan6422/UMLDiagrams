/*NIVEL 1*/
CREATE TABLE PROVINCIA(
    COD_PROVINCIA   SMALLINT    NOT NULL,
    NOM_PROVINCIA   SMALLINT    NOT NULL,
    CONSTRAINT  PK_PROVINCIA    PRIMARY KEY (COD_PROVINCIA)
);

CREATE TABLE ESPECIALIDAD(
    COD_ESPECIALIDAD    SMALLINT    NOT NULL,
    NOM_ESPECIALIDAD    VARCHAR(40) NOT NULL,
    CONSTRAINT  PK_ESPECIALIDAD PRIMARY KEY (COD_ESPECIALIDAD)
);

CREATE TABLE CARGO(
    COD_CARGO   SMALLINT NOT NULL,
    NOM_CARGO   VARCHAR(30) NOT NULL,
    CONSTRAINT  PK_CARGO    PRIMARY KEY (COD_CARGO)
);

CREATE TABLE SECCION(
    COD_SECCION SMALLINT    NOT NULL,
    NOM_SECCION VARCHAR(30) NOT NULL,
    CONSTRAINT  PK_SECCION  PRIMARY KEY (COD_SECCION) 
);

/*NIVEL 2*/
CREATE TABLE LOCALIDAD(
    COD_LOCALIDAD   SMALLINT    NOT NULL,   
    NOM_LOCALIDAD    VARCHAR(40)    NOT NULL,
    COD_PROVINCIA   SMALLINT    NOT NULL,
    CONSTRAINT  FK_LOCALIDAD_PROVINCIA FOREIGN KEY (COD_PROVINCIA)
        REFERENCES PROVINCIA(COD_PROVINCIA),
    CONSTRAINT  PK_LOCALIDAD    PRIMARY KEY (COD_LOCALIDAD)
);

CREATE TABLE SECTOR(
    COD_SECCION SMALLINT    NOT NULL,
    CONSTRAINT FK_COD_SECCION FOREIGN KEY (COD_SECCION)
        REFERENCES SECCION(COD_SECCION),   
    COD_SECTOR  SMALLINT    NOT NULL,    
    NOM_SECTOR  VARCHAR(30) NOT NULL
);

/*NIVEL 3*/
CREATE TABLE PERSONA(
    TIPODOC CHAR    NOT NULL,
    NRODOC  INT2    NOT NULL,
    SEXO    CHAR    NOT NULL,
    APENOM  VARCHAR(40) NULL,
    DOMICILIO   VARCHAR(50) NULL,
    FENACI  DATE    NOT NULL,
    COD_PROVIVIVE   SMALLINT NULL,
    COD_LOCAVIVE    SMALLINT    NULL,
    COD_PROVINACE   SMALLINT NULL,
    COD_LOCANACE    SMALLINT NULL,
    TIPODOCPADRE    CHAR    NULL,
    NRODOCPADRE     INT2    NULL,
    SEXOPADRE       CHAR    NULL,
    TIPODOCMADRE    CHAR    NULL,
    NRODOCMADRE     INT2    NULL,
    SEXOMADRE       CHAR    NULL,
    CONSTRAINT  PK_PERSONA  PRIMARY KEY (TIPODOC,NRODOC,SEXO),
    CONSTRAINT  FK_PROVIVIVE    FOREIGN KEY (COD_PROVIVIVE,COD_LICAVIVE)
        REFERENCES LOCALIDAD(COD_PROVINCIA,COD_LOCALIDAD),
    CONSTRAINT  FK_PROVINACE    FOREIGN KEY (COD_PROVINACE,COD_LOCANACE)
        REFERENCES LOCALIDAD(COD_PROVINCIA,COD_LOCALIDAD),
    CONSTRAINT FK_PADRE_PERSONA FOREIGN KEY (TIPODOCPADRE,NRODOCPADRE,SEXOPADRE)
        REFERENCES PERSONA(TIPODOC,NRODOC,SEXO),
    CONSTRAINT FK_MADRE_PERSONA FOREIGN KEY (TIPODOCMADRE,NRODOCMADRE,SEXOMADRE)
        REFERENCES PERSONA(TIPODOC,NRODOC,SEXO)
);
/*NIVEL 4*/
CREATE TABLE EMPLEADO(
    COD_EMPLEADO    INT2    NOT NULL,
    TIPODOC CHAR    UNIQUE  NOT NULL,
    NRODOC  INT2    UNIQUE  NOT NULL,
    SEXO    CHAR    UNIQUE  NOT NULL,
    FEINGRESO   DATE    NOT NULL,
    CONSTRAINT PK_EMPLEADO  PRIMARY KEY (COD_EMPLEADO),
    CONSTRAINT FK_PERSONA_EMPLEADO  FOREIGN KEY(TIPODOC,NRODOC,SEXO)
        REFERENCES PERSONA(TIPODOC,NRODOC,SEXO),
);

CREATE TABLE MEDICO(
    MATRICULA   SMALLINT    NOT NULL,
    COD_ESPECIALIDAD    SMALLINT    NOT NULL,
    TIPODOC CHAR    UNIQUE  NOT NULL,
    NRODOC  INT2    UNIQUE  NOT NULL,
    SEXO    CHAR    UNIQUE  NOT NULL,
    CONSTRAINT  PK_MEDICO   PRIMARY KEY (MATRICULA),
    CONSTRAINT  FK_ESPECIALIDAD_MEDICO  FOREIGN KEY (COD_ESPECIALIDAD)
        REFERENCES ESPECIALIDAD(COD_ESPECIALIDAD),
    CONSTRAINT FK2_PERSONA_MEDICO   FOREIGN KEY (TIPODOC,NRODOC,SEXO)
        REFERENCES  PERSONA(TIPODOC,NRODOC,SEXO)
);

/*NIVEL 5*/
CREATE TABLE HISTORIAL(
    COD_EMPLEADO    INT2    NOT NULL,
    COD_CARGO   SMALLINT    NOT NULL,
    FECHAINICIO DATE    NOT NULL,
    FECHAFIN    DATE    NULL,
    CONSTRAINT FK_EMPLEADO_HISTORIAL    FOREIGN KEY (COD_EMPLEADO)
        REFERENCES EMPELADO(COD_EMPLEADO),
    CONSTRAINT  PK_HISTORIAL    PRIMARY KEY (COD_EMPLEADO,FECHAINICIO),
);
CREATE TABLE SALA(
    COD_SECCION SMALLINT    NOT NULL,
    NRO_SALA    SMALLINT    NOT NULL,
    COD_SECTOR  SMALLINT    NOT NULL,
    COD_ESPECIALIDAD    SMALLINT    NOT NULL,
    COD_EMPLEADO    INT2    NOT NULL,
    NOM_ESPECIALIDAD    VARCHAR(30) NOT NULL,
    CAPACIDAD   SMALLINT    NULL,
    CONSTRAINT  PK_SAL  PRIMARY KEY (COD_SECCION,NRO_SALA,COD_SECTOR),
    CONSTRAINT FK_SECTOR_SALA   FOREIGN KEY (COD_SECCION,COD_SECTOR)
        REFERENCES  SECTOR(COD_SECCION,COD_SECTOR),
    CONSTRAINT FK_ESPECIALIDAD_SALA FOREIGN KEY (COD_ESPECIALIDAD)
        REFERENCES ESPECIALIDAD(COD_ESPECIALIDAD),
    CONSTRAINT  FK_EMPLEADO_SALA    FOREIGN KEY(COD_EMPLEADO)
        REFERENCES EMPLEADO(COD_EMPLEADO)
);
/*NIVEL 6*/
CREATE TABLE ASIGNACION(
  NRO_ASIGNACION    INT2    NOT NULL,
  MATRICULA         SMALLINT  NOT NULL,
  TIPODOC   CHAR    NOT NULL,
  NRODOC    INT2    NOT NULL,
  SEXO  CHAR    NOT NULL,
  COD_EMPLEADO  INT2    NOT NULL,
  NRO_SALA  SMALLINT    NOT NULL,
  COD_SECTOR SMALLINT   NOT NULL,
  COD_SECCION   SMALLINT    NOT NULL,
  FEASIGNA  DATE    NOT NULL,
  FESALIDA  DATE    NULL,
  CONSTRAINT PK_ASIGNACION  PRIMARY KEY (NRO_ASIGNACION),
  CONSTRAINT FK_MEDICO_ASIGNACION   FOREIGN KEY (MATRICULA)
    REFERENCES MEDICO(MATRICULA),
  CONSTRAINT FK_PERSONA_ASIGNACION  FOREIGN KEY (TIPODOC,NRODOC,SEXO)
    REFERENCES  PERSONA(TIPODOC,NRODOC,SEXO),
  CONSTRAINT FK_EMPLEADO_ASIGNACION FOREIGN KEY (COD_EMPLEADO)
    REFERENCES  EMPOLEADO(COD_EMPLEADO),
  CONSTRAINT FK_SALA_ASIGNACION FOREIGN KEY (NRO_SALA,COD_SECTOR,COD_SECCION)
    REFERENCES SALA(COD_SECCION,NRO_SALA,COD_SECTOR)
);