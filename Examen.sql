--CREACION DE TABLAS
CREATE TABLE VENTAS(
    ID_VENTA VARCHAR2(12) PRIMARY KEY,
    FECHA_VENTA DATE,
    CLIENTE VARCHAR2(100),
    CVE_VENDEDOR VARCHAR2(10),
    TIPO_COBRO VARCHAR2(8),
    ESTATUS_ENTREGA_VENTA VARCHAR2(26),
    FECHA_ENVIO DATE,
    FECHA_ENTREGA DATE,
    ESTATUS_PAGO VARCHAR(100),
    COMISION_VENTA_CENT VARCHAR2(5),
    FECHA_ALTA DATE,
    FECHA_ACTUALIZACION DATE
);
SELECT * FROM VENTAS;

CREATE TABLE DETALLE_VENTAS(
    ID_VENTA VARCHAR2(12) PRIMARY KEY,
    FECHA_VENTA DATE,
    PRODUCTO VARCHAR2(32),
    CANTIDAD VARCHAR(8),
    PRECIO_UNITARIO_CENT VARCHAR2(100),
    CONSTRAINT DETALLE_VENTA_VENTA FOREIGN KEY(ID_VENTA) REFERENCES VENTAS(ID_VENTA)
);

--HACER UN TRIGGER  
CREATE OR REPLACE TRIGGER FECHA_CREACION_VENTAS
AFTER INSERT ON VENTAS
FOR EACH ROW
DECLARE
ID_V INT;
FECHA_C DATE ;
BEGIN 
SELECT SYSDATE INTO FECHA_C FROM DUAL;
UPDATE VENTAS SET FECHA_ALTA=FECHA_C WHERE ID_VENTA=:NEW.ID;
END;

--HACER UN SEGUNDO TRIGGER
CREATE OR REPLACE TRIGGER FECHA_ACTUALIZACION_VENTAS
AFTER UPDATE ON VENTAS
FOR EACH ROW
DECLARE
FECHA_C DATE ;
ID_B NVARCHAR2(10);
BEGIN 
SELECT SYSDATE INTO FECHA_C FROM DUAL;
UPDATE VENTAS SET FECHA_ACTUALIZACION = FECHA_C WHERE ID_VENTA = :OLD.ID_VENTA;
END;

--PROCEDIMIENTO ALMACENADO 

CREATE OR REPLACE PROCEDURE CONSULTAS_VENTAS
IS
BEGIN
SELECT * FROM VENTAS;
END;


--LLENADO DE UNA TABLA MEDIANTE UN ARCHIVO CSV
--PRIMERO SE DEBE CREAR LA TABLA POSTERIORMENTE HACER LO SIGUIENTE
BULK 
INSERT NOMBRE_TABLA
FROM 'RUTA DONDE ESTA EL ARCHIVO'
WITH 
    ( 
        FIRSTROW = 1, 
        MAXERRORS = 0, 
        FIELDTERMINATOR = ',', 
        ROWTERMINATOR = '\n' 
    )
