USE master

DROP DATABASE function_produto

CREATE DATABASE function_produto
GO
USE function_produto
GO
CREATE TABLE produto
(
	codigo			INT 			NOT NULL,
	nome			VARCHAR(50)		NOT NULL,
	valor_unitario	DECIMAL(7, 2)	NOT NULL,
	qtd_estoque		INT				NOT NULL
	PRIMARY KEY (codigo)
)

INSERT INTO produto (codigo, nome, valor_unitario, qtd_estoque) 
VALUES 
(1, 'Camiseta', 25.99, 100),
(2, 'Calça Jeans', 49.99, 50),
(3, 'Tênis', 79.99, 80),
(4, 'Boné', 15.00, 30),
(5, 'Meia', 5.99, 200),
(6, 'Jaqueta', 99.99, 20),
(7, 'Saia', 35.99, 40),
(8, 'Moletom', 45.00, 25),
(9, 'Bermuda', 29.99, 60),
(10, 'Vestido', 59.99, 70),
(11, 'Chinelo', 19.99, 150),
(12, 'Cinto', 12.50, 80),
(13, 'Pulseira', 8.99, 100),
(14, 'Relógio', 69.99, 30),
(15, 'Óculos de Sol', 29.99, 50),
(16, 'Brinco', 4.99, 200),
(17, 'Anel', 7.99, 150),
(18, 'Gravata', 14.99, 40),
(19, 'Sapato Social', 89.99, 20),
(20, 'Lenço', 9.99, 100)

/*
Fazer uma Function que retorne
a) a partir da tabela Produtos (codigo, nome, valor unitário e qtd estoque), quantos produtos
estão com estoque abaixo de um valor de entrada

b) Uma tabela com o código, o nome e a quantidade dos produtos que estão com o estoque
abaixo de um valor de entrada
*/

-- Inserções na tabela produto

CREATE FUNCTION fn_estoque_abaixo(@estoque_min INT)
RETURNS INT
AS
BEGIN
	DECLARE @qtd_estoque INT
	
	SELECT @qtd_estoque = COUNT(qtd_estoque) FROM produto WHERE qtd_estoque < @estoque_min 
	
	RETURN @qtd_estoque
END

SELECT dbo.fn_estoque_abaixo(100) AS qtd_estoque

CREATE FUNCTION fn_estoque_tabela(@estoque_min INT)
RETURNS @tabela TABLE
(
	codigo 	INT,
	nome 	VARCHAR(50),
	qtd		INT
)
AS
BEGIN
	INSERT INTO @tabela
		SELECT codigo, nome, qtd_estoque FROM produto WHERE qtd_estoque < @estoque_min
	
	RETURN
END

SELECT * FROM fn_estoque_tabela(50) 

