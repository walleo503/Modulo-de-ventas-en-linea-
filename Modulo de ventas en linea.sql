CREATE DATABASE Modulo_de_ventas_en_linea;
USE Modulo_de_ventas_en_linea;

-- Tabla Usuario
CREATE TABLE Usuario (
    usuarioId INT PRIMARY KEY,
    nombre VARCHAR(200),
    telefono VARCHAR(200),
    direccion VARCHAR(200),
    ubicacionId INT,
    loginid INT,
    FOREIGN KEY (ubicacionId) REFERENCES Ubicacion(ubicacionId),
    FOREIGN KEY (loginid) REFERENCES Login_Usuario(loginid)
);

-- Tabla Login_Usuario con el campo correo
CREATE TABLE Login_Usuario (
    loginid INT PRIMARY KEY,
    usuarioId INT UNIQUE,  
    correo VARCHAR(200) UNIQUE NOT NULL,
    contraseña VARCHAR(200) NOT NULL,
    FOREIGN KEY (usuarioId) REFERENCES Usuario(usuarioId)
);

-- Tabla Ubicacion
CREATE TABLE Ubicacion (
    ubicacionId INT PRIMARY KEY,
    departamento VARCHAR(200),
    latitud DECIMAL(10,6),
    longitud DECIMAL(10,6)
);

-- Tabla Pedido
CREATE TABLE Pedido (
    pedidoId INT PRIMARY KEY,
    usuarioId INT,
    fecha DATETIME, 
    nombre VARCHAR(200),
    cantidad INT,
    precio DECIMAL(10,2),
    FOREIGN KEY (usuarioId) REFERENCES Usuario(usuarioId)
);

-- Tabla Recibo
CREATE TABLE Recibo (
    reciboId INT PRIMARY KEY IDENTITY(1,1),
    usuarioId INT,
    pedidoId INT,
    total DECIMAL(10,2),
    FOREIGN KEY (usuarioId) REFERENCES Usuario(usuarioId),
    FOREIGN KEY (pedidoId) REFERENCES Pedido(pedidoId)
);

-- Tabla Historial
CREATE TABLE Historial (
    historialId INT PRIMARY KEY IDENTITY(1,1),
    reciboId INT,
    FOREIGN KEY (reciboId) REFERENCES Recibo(reciboId)
);

-- Tabla Platos
CREATE TABLE Platos (
    id INT PRIMARY KEY,
    nombre VARCHAR(200),
    descripcion TEXT,
    precio DECIMAL(10,2)
);

-- Tabla Promociones
CREATE TABLE Promociones (
    id INT PRIMARY KEY,
    descripcion TEXT,
    descuento DECIMAL(5,2)
);

-- Nueva Tabla de Combos
CREATE TABLE Combos (
    id_combo INT PRIMARY KEY,
    nombre VARCHAR(200),
    descripcion TEXT,
    precio DECIMAL(10,2)
);

-- Tabla Menu (Ahora incluye los Combos)
CREATE TABLE Menu (
    id_menu INT PRIMARY KEY,
    id_plato INT NULL,
    id_promocion INT NULL,
    id_combo INT NULL,
    pedidoId INT,
    FOREIGN KEY (id_plato) REFERENCES Platos(id),
    FOREIGN KEY (id_promocion) REFERENCES Promociones(id),
    FOREIGN KEY (id_combo) REFERENCES Combos(id_combo),
    FOREIGN KEY (pedidoId) REFERENCES Pedido(pedidoId)
);

-- Tabla Ventas en línea
CREATE TABLE Ventas_linea (
    venta_lineaId INT PRIMARY KEY IDENTITY(1,1),
    usuarioId INT,
    id_menu INT,
    pedidoId INT,
    historialId INT,
    FOREIGN KEY (usuarioId) REFERENCES Usuario(usuarioId),
    FOREIGN KEY (id_menu) REFERENCES Menu(id_menu),
    FOREIGN KEY (pedidoId) REFERENCES Pedido(pedidoId),
    FOREIGN KEY (historialId) REFERENCES Historial(historialId)
);

