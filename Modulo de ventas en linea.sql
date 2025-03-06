CREATE DATABASE Modulo_de_ventas_en_linea;
USE Modulo_de_ventas_en_linea;

-- Tabla Usuario
CREATE TABLE Usuario (
    usuarioId INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(200),
    telefono VARCHAR(200),
    direccion VARCHAR(200),
    ubicacionId INT,
	loginid INT
    FOREIGN KEY (ubicacionId) REFERENCES Ubicacion(ubicacionId)
);
-- Tabla Login_Usuario con el campo correo
CREATE TABLE Login_Usuario (
    loginid INT PRIMARY KEY IDENTITY(1,1),
    usuarioId INT UNIQUE,  
    correo VARCHAR(200) UNIQUE NOT NULL,
    contraseña VARCHAR(200) NOT NULL,
    FOREIGN KEY (usuarioId) REFERENCES Usuario(usuarioId) -- Clave foránea hacia Usuario
);

-- Tabla Ubicacion
CREATE TABLE Ubicacion (
    ubicacionId INT PRIMARY KEY IDENTITY(1,1),
    departamento VARCHAR(200),
	latitud DECIMAL(10,6),
    longitud DECIMAL(10,6)
);

-- Tabla Pedido
CREATE TABLE Pedido (
    pedidoId INT PRIMARY KEY IDENTITY(1,1),
    fecha DATETIME, 
    nombre VARCHAR(200),
    cantidad INT,
    precio DECIMAL(10,2), 
    reciboId INT,
    FOREIGN KEY (reciboId) REFERENCES Recibo(reciboId)
);

-- Tabla Recibo
CREATE TABLE Recibo (
    reciboId INT PRIMARY KEY IDENTITY(1,1),
    usuarioId INT,
    total DECIMAL(10,2),
    FOREIGN KEY (usuarioId) REFERENCES Usuario(usuarioId)
);

-- Tabla Historial
CREATE TABLE Historial (
    historialId INT PRIMARY KEY IDENTITY(1,1),
    pedidoId INT,
    FOREIGN KEY (pedidoId) REFERENCES Pedido(pedidoId)
);

-- Tabla Ventas_linea
CREATE TABLE Ventas_linea (
    venta_lineaId INT PRIMARY KEY IDENTITY(1,1),
    usuarioId INT,
    id_plato INT,
    pedidoId INT,
    estado VARCHAR(300),
    historialId INT,
    FOREIGN KEY (usuarioId) REFERENCES Usuario(usuarioId),
    FOREIGN KEY (pedidoId) REFERENCES Pedido(pedidoId),
    FOREIGN KEY (historialId) REFERENCES Historial(historialId)
);
