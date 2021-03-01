ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
commit;
CREATE USER clinica_oracl IDENTIFIED BY admin;
commit;
GRANT CONNECT, RESOURCE TO clinica_oracl;
commit;
ALTER USER clinica_oracl
QUOTA UNLIMITED ON USERS;
commit;
GRANT CREATE VIEW TO clinica_oracl;
commit;
CREATE TABLE empleado (
        id_em       INT NOT NULL,
       apellido_em       VARCHAR(50) NOT NULL,
       nombre_em      VARCHAR(30) NOT NULL,
       dni    INT NOT NULL,
      correo  VARCHAR (100) NULL,
       telefono   INT NOT NULL,
       CONSTRAINT PKEmpleado 
              PRIMARY KEY (id_em)
);
commit;

CREATE TABLE usuario (
       id_usu      INT   NOT NULL,
       usuario      VARCHAR(25) NOT NULL,
       contraseña      VARCHAR(200) NOT NULL,
 
    
       CONSTRAINT PKUsuario 
              PRIMARY KEY ( id_usu)
       
           
);
commit;




CREATE TABLE especialidad (
       id_espe      INT   NOT NULL,
       nombre_espe  VARCHAR(40) NOT NULL,
       capacidad      INT NOT NULL,
       
       CONSTRAINT PKTipoMovimiento 
              PRIMARY KEY (id_espe)
);
commit;


CREATE TABLE medico (
      id_med       INT  NOT NULL,
      nombre_med     VARCHAR(25) NOT NULL,
      apellido_med      VARCHAR(25) NOT NULL,
      dni        INT  NOT NULL, 
      vch_clieemail       VARCHAR(50) NULL,
      telefono_med      INT NULL,
      id_espe   INT NOT NULL,        
              CONSTRAINT PKMedico
              PRIMARY KEY (id_med),
              CONSTRAINT fk_asignado_empleado_1
              FOREIGN KEY (id_espe)
                             REFERENCES especialidad
);
commit;


CREATE TABLE consultorio (
       id_con       INT  NOT NULL,
       nombre_con  INT  NOT NULL,
       piso  INT  NOT NULL,
       numero_con  INT  NOT NULL,
       CONSTRAINT PKConsultorio 
              PRIMARY KEY (id_con)
);
commit;


CREATE TABLE turno (
       id_turn      INT  NOT NULL,
       feche_ini  DATE  NOT NULL,
       fecha_salida  DATE  NOT NULL,
    
       CONSTRAINT PKTurno 
              PRIMARY KEY (id_turn)
);
commit;

CREATE TABLE programacion(
        id_pro       INT NOT NULL,
       fecha_pro      DATE  NOT NULL,
       capacidad      INT NOT NULL,
       citas    INT NOT NULL,
      precio  VARCHAR (100) NULL,
       telefono   INT NOT NULL,
       id_con  INT NOT NULL,
       id_turn INT NOT NULL,
       id_med  INT NOT NULL,
       id_em  INT NOT NULL,
       CONSTRAINT PKProgramacion 
              PRIMARY KEY (id_pro),
                CONSTRAINT fk_asignado_consultorio1
              FOREIGN KEY (id_con)
                             REFERENCES consultorio,
                CONSTRAINT fk_asignado_turno1
              FOREIGN KEY (id_turn)
                             REFERENCES turno,
                CONSTRAINT fk_asignado_medico1
              FOREIGN KEY (id_med)
                             REFERENCES especialidad,
                CONSTRAINT fk_asignado_empleado2
              FOREIGN KEY (id_em)
                             REFERENCES empleado
);
commit;

CREATE TABLE paciente (
        id_pac       INT NOT NULL,
       apellido_pac       VARCHAR(50) NOT NULL,
       nombre_pac      VARCHAR(30) NOT NULL,
       dni_pac    INT NOT NULL,
       telefono_pac   INT NOT NULL,
       CONSTRAINT XPKPaciente 
              PRIMARY KEY (id_pac)
);
commit;

CREATE TABLE cita (
       id_cita       INT NOT NULL,
       fecha_registro       DATE NOT NULL,
       orden        INT NOT NULL,
       atendido      INT NOT NULL,
       id_em  INT NOT NULL,
       id_pro  INT NOT NULL,
       id_pac  INT NOT NULL,
       CONSTRAINT PKCita
              PRIMARY KEY (id_cita), 
       CONSTRAINT fk_movimiento_empleado
              FOREIGN KEY (id_em)
                             REFERENCES empleado, 
       CONSTRAINT fk_movimiento_programacion
              FOREIGN KEY (id_pro)
                             REFERENCES programacion, 
       CONSTRAINT fk_movimiento_paciente
              FOREIGN KEY (id_pac)
                             REFERENCES paciente
);
commit;

CREATE SEQUENCE Secuencia_Usuario
INCREMENT BY 1
START WITH 1;
commit;

CREATE OR REPLACE TRIGGER Trigger_Usuario_Id
BEFORE INSERT ON usuario
REFERENCING NEW AS NEW FOR EACH ROW
DECLARE valorSecuencia NUMBER := 0;
BEGIN
SELECT Secuencia_Usuario.NEXTVAL INTO valorSecuencia FROM DUAL;
:NEW.id_usu := valorSecuencia;
END;
commit;
select * from usuario;
