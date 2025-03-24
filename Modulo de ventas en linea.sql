CREATE DATABASE restaurante;
GO
USE restaurante;
GO

CREATE TABLE cargo (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(50) UNIQUE,
    estado INT
);

CREATE TABLE categoria (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(50) UNIQUE,
    estado INT
);

CREATE TABLE empleados (
    id INT PRIMARY KEY IDENTITY(1,1),
    codigo INT UNIQUE,
    contrasena VARCHAR(255),
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    telefono VARCHAR(20),
    cargo_id INT FOREIGN KEY REFERENCES cargo(id),
    estado INT
);

CREATE TABLE mesas (
    id INT PRIMARY KEY IDENTITY(1,1),
    numero INT UNIQUE,
    capacidad INT,
    disponibilidad VARCHAR(20) CHECK (disponibilidad IN ('libre', 'ocupado')),
    estado INT
);

CREATE TABLE platos (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100),
    descripcion VARCHAR(255),
    precio DECIMAL(10,2),
    imagen VARCHAR(MAX),
    categoria_id INT FOREIGN KEY REFERENCES categoria(id),
    estado INT
);

CREATE TABLE combos (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100),
    descripcion VARCHAR(255),
    precio DECIMAL(10,2),
    categoria_id INT FOREIGN KEY REFERENCES categoria(id),
    estado INT
);

CREATE TABLE platos_combos (
    id INT PRIMARY KEY IDENTITY(1,1),
    estado INT,
    combo_id INT FOREIGN KEY REFERENCES combos(id),
    plato_id INT FOREIGN KEY REFERENCES platos(id)
);

CREATE TABLE promociones (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100),
    descripcion VARCHAR(255),
    descuento DECIMAL(5,2),
    estado INT,
    categoria_id INT FOREIGN KEY REFERENCES categoria(id)
);

CREATE TABLE combo_promocion (
    id INT PRIMARY KEY IDENTITY(1,1),
    combo_id INT FOREIGN KEY REFERENCES combos(id),
    promocion_id INT FOREIGN KEY REFERENCES promociones(id),
    fecha_inicio DATE,
    fecha_fin DATE,
    estado INT
);

CREATE TABLE menu (
    id INT PRIMARY KEY IDENTITY(1,1),
    tipo_menu VARCHAR(20) CHECK (tipo_menu IN ('desayuno', 'almuerzo', 'cena', 'temporada')),
    tipo_venta VARCHAR(20) CHECK (tipo_venta IN ('restaurante', 'online')),
    hora_inicio TIME,
    hora_fin TIME,
    fecha_inicio DATE,
    fecha_fin DATE,
    estado INT
);

CREATE TABLE menu_plato (
    id INT PRIMARY KEY IDENTITY(1,1),
    menu_id INT FOREIGN KEY REFERENCES menu(id),
    plato_id INT FOREIGN KEY REFERENCES platos(id),
    estado INT
);

CREATE TABLE menu_combo (
    id INT PRIMARY KEY IDENTITY(1,1),
    menu_id INT FOREIGN KEY REFERENCES menu(id),
    combo_id INT FOREIGN KEY REFERENCES combos(id),
    estado INT
);

CREATE TABLE Pedido_Local (
id_pedido INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
id_mesa INT NOT NULL,
nombre_cliente VARCHAR (100) NOT NULL,
fechaApertura DATETIME DEFAULT CURRENT_TIMESTAMP,
estado VARCHAR(20) CHECK(estado in ('Abierta', 'Cerrada')) NOT NULL DEFAULT 'Abierta',
id_mesero INT NOT NULL 
);

CREATE TABLE Detalle_Pedido (
id_detalle_pedido INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
encabezado_id INT NOT NULL,
tipo_venta varchar(10) CHECK(tipo_venta in ('Local', 'En Linea')),
tipo_Item varchar(10) CHECK(tipo_Item in ('Plato', 'Combo')) NOT NULL,
item_id INT NOT NULL,
cantidad INT NOT NULL,
comentarios VARCHAR(100) NULL,
estado varchar(20) CHECK(estado in ('Pendiente', 'En Proceso', 'Finalizado', 'Cancelado')) NOT NULL
DEFAULT 'Pendiente',
subtotal DECIMAL(10,2) NOT NULL,
FOREIGN KEY (encabezado_id) REFERENCES Pedido_Local(id_pedido) ON
DELETE CASCADE
);


-- Tabla de Facturas
CREATE TABLE Factura (
    factura_id INT PRIMARY KEY IDENTITY,
    cliente_nombre VARCHAR(50),
    codigo_factura VARCHAR(250),
    id_pedido INT,
    tipo_venta VARCHAR(10) CHECK (tipo_venta IN ('ONLINE', 'LOCAL')),
    empleado_id INT,
    total DECIMAL(10, 2),
    fecha DATETIME,
    FOREIGN KEY (empleado_id) REFERENCES Empleados(id) 
);

-- Tabla de Métodos de Pago
CREATE TABLE MetodoPago (
    metodo_pago_id INT PRIMARY KEY,
    nombre VARCHAR(50)
);

-- Tabla de Pagos
CREATE TABLE Pago (
    pago_id INT PRIMARY KEY IDENTITY,
    factura_id INT,
    metodo_pago_id INT,
    monto DECIMAL(10, 2),
    fecha DATETIME,
    FOREIGN KEY (factura_id) REFERENCES Factura(factura_id),
    FOREIGN KEY (metodo_pago_id) REFERENCES MetodoPago(metodo_pago_id)
);

-- Tabla de Pago con Tarjeta
CREATE TABLE PagoTarjeta (
    id_PagoTarjeta INT PRIMARY KEY IDENTITY,
    pago_id INT,
    tipo VARCHAR(20),
    digitos VARCHAR(20),
    titular VARCHAR(50),
    referencia VARCHAR(20),
    FOREIGN KEY (pago_id) REFERENCES Pago(pago_id)
);

-- Tabla de Detalles de Factura
CREATE TABLE Detalle_Factura (
    detalle_factura_id INT PRIMARY KEY IDENTITY,
    factura_id INT,
    detalle_pedido_id INT,
    subtotal DECIMAL(10, 2),
    FOREIGN KEY (factura_id) REFERENCES Factura(factura_id),
    FOREIGN KEY (detalle_pedido_id) REFERENCES Detalle_Pedido(id_detalle_pedido)
);

-- Secuencia para facturas de ventas en linea (OL)
CREATE SEQUENCE seq_factura_online
    START WITH 1
    INCREMENT BY 1;

-- Secuencia para facturas de ventas locales (L)
CREATE SEQUENCE seq_factura_local
    START WITH 1
    INCREMENT BY 1;


-- Tabla Login_Cliente (Antes era Login_Usuario)
CREATE TABLE Login_Cliente (
	loginid INT PRIMARY KEY NOT NULL,
	contraseña VARCHAR(200) NOT NULL
);

-- Tabla Cliente (Antes era Usuario)
CREATE TABLE Cliente (
	clienteId INT PRIMARY KEY,
	nombre VARCHAR(200) NOT NULL,
	telefono VARCHAR(200) NOT NULL,
	correo VARCHAR(200) UNIQUE NOT NULL,
	direccion VARCHAR(200) NOT NULL,
	latitud DECIMAL(10,6) NOT NULL,
	longitud DECIMAL(10,6) NOT NULL,
	loginid INT UNIQUE,  -- Relación uno a uno con Login_Cliente
	FOREIGN KEY (loginid) REFERENCES Login_Cliente(loginid)
);

--Tabla Pedido_online
CREATE TABLE Pedido_Online (
    id_pedido INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    id_cliente INT NOT NULL,
    fecha_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20) CHECK(estado IN ('Pendiente','Cancelado')) NOT NULL DEFAULT 'Pendiente',
    FOREIGN KEY (id_cliente) REFERENCES Cliente(clienteId)
);

--Tabla Ventas_linea
CREATE TABLE Ventas_linea (
    venta_lineaId INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    clienteId INT NOT NULL,
    pedido_id INT NOT NULL,
    plato_id INT NULL,
    combo_id INT NULL,
    cantidad INT NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    metodo_pago_id INT NOT NULL,
    estado VARCHAR(20) CHECK (estado IN ('Pendiente','Cancelado')) NOT NULL DEFAULT 'Pendiente',
    fecha_venta DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (clienteId) REFERENCES Cliente(clienteId),
    FOREIGN KEY (pedido_id) REFERENCES Pedido_Online(id_pedido),
    FOREIGN KEY (plato_id) REFERENCES Platos(id),
    FOREIGN KEY (combo_id) REFERENCES Combos(id),
    FOREIGN KEY (metodo_pago_id) REFERENCES MetodoPago(metodo_pago_id),
    CHECK ((plato_id IS NOT NULL AND combo_id IS NULL) OR (plato_id IS NULL AND combo_id IS NOT NULL))
);
