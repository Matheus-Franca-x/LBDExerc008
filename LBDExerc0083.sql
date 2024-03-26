USE master

DROP DATABASE func_cliente

CREATE DATABASE func_cliente
GO
USE func_cliente
GO
CREATE TABLE cliente
(
	codigo 			INT 			NOT NULL,
	nome			VARCHAR(100) 	NOT NULL
	PRIMARY KEY (codigo)
)
GO
CREATE TABLE produto
(
	codigo			INT				NOT NULL,
	nome			VARCHAR(50) 	NOT NULL,
	valor			DECIMAL(7, 2)	NOT NULL
	PRIMARY KEY (codigo)
)
GO
/*
Criar, uma UDF, que baseada nas tabelas abaixo, retorne
Nome do Cliente, Nome do Produto, Quantidade e Valor Total, Data de hoje

Tabelas iniciais:
Cliente (Codigo, nome)
Produto (Codigo, nome, valor)
*/
		
INSERT INTO cliente VALUES
(1, 'Pedro Miguel'),
(2, 'Alberto Moreira'),
(3, 'Jandira Etelvina'),
(4, 'Maria de Jesus'),
(5, 'Francisco Aguimar'),
(6, 'Enzo Valentim')

INSERT INTO produto VALUES
(1, 'Panela de Pressão', 150.00),
(2, 'Kit de Talheres Tramontina', 100.00),
(3, 'Champanhe', 500.00),
(4, 'Bicicleta Esportiva Caloi', 950.00),
(5, 'Kit de Toalhas', 50.00),
(6, 'Jogo de Panelas Tramontina', 190.00)

CREATE FUNCTION fn_compra(@codigo_cliente INT, @codigo_produto INT, @qtd INT)
RETURNS @tabela TABLE
(
	nome_cliente	VARCHAR(100),
	nome_produto	VARCHAR(50),
	qtd_produto		INT,
	valor_total		DECIMAL(7,2)
)
AS
BEGIN
	INSERT INTO @tabela
		SELECT (SELECT nome FROM cliente WHERE codigo = @codigo_cliente) AS nome_cliente, nome, @qtd AS qtd_produto, valor * @qtd AS valor_total FROM produto p WHERE codigo = @codigo_produto
	
	RETURN
END

SELECT * FROM fn_compra(1, 2, 5) 

SELECT * FROM produto

