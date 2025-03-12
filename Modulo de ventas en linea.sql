CREATE DATABASE Modulo_de_ventas_en_linea;
USE Modulo_de_ventas_en_linea;

-- Tabla Cliente (Antes era Usuario)
CREATE TABLE Cliente (
    clienteId INT PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    telefono VARCHAR(200) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    latitud DECIMAL(10,6) NOT NULL,
    longitud DECIMAL(10,6) NOT NULL,
    loginid INT UNIQUE,  -- Relación uno a uno con Login_Cliente
    FOREIGN KEY (loginid) REFERENCES Login_Cliente(loginid)
);

-- Tabla Login_Cliente (Antes era Login_Usuario)
CREATE TABLE Login_Cliente (
    loginid INT PRIMARY KEY NOT NULL,
    correo VARCHAR(200) UNIQUE NOT NULL,
    contraseña VARCHAR(200) NOT NULL
);

-- Tabla Ventas en Línea (Relacionada con Cliente y Pedido)
CREATE TABLE Ventas_linea (
    venta_lineaId INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    clienteId INT NOT NULL,
    id_menu INT NOT NULL,
    pedido_id INT NOT NULL,
    FOREIGN KEY (clienteId) REFERENCES Cliente(clienteId),
    FOREIGN KEY (id_menu) REFERENCES Menu(id_menu),
    FOREIGN KEY (pedido_id) REFERENCES Pedido(pedidoId)
);
