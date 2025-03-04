Create database Modulo_de_ventas_en_linea;

CREATE TABLE Ventas_linea (
    ventas_lineaId INT PRIMARY KEY IDENTITY(1,1),
	usuarioId int,
	administradorId int,
	pedidoId int,
	estado varchar(300),
	historialId int
);

