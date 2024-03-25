USE master

DROP DATABASE funcionario

CREATE DATABASE funcionario
GO
USE funcionario
GO
CREATE TABLE funcionario
(
	codigo				INT 			NOT NULL,
	nome				VARCHAR(50) 	NOT NULL,
	salario				DECIMAL(7, 2)	NOT NULL
	PRIMARY KEY (codigo)
)
GO
CREATE TABLE dependente
(
	codigo_dep			INT				NOT NULL,
	codigo_funcionario	INT				NOT NULL,
	nome_dependente		VARCHAR(50)		NOT NULL,
	salario_dependente	DECIMAL(7, 2)	NOT NULL
	PRIMARY KEY (codigo_dep)
	FOREIGN KEY (codigo_funcionario) REFERENCES funcionario (codigo)
)

-- Inserções na tabela funcionario
INSERT INTO funcionario (codigo, nome, salario) 
VALUES 
(1, 'João', 5000.00),
(2, 'Maria', 5500.00),
(3, 'Pedro', 4800.00),
(4, 'Ana', 5200.00),
(5, 'Carlos', 5100.00),
(6, 'Julia', 5300.00),
(7, 'Lucas', 4900.00),
(8, 'Mariana', 5400.00),
(9, 'Rodrigo', 4700.00),
(10, 'Camila', 5200.00)

-- Inserções na tabela dependente
INSERT INTO dependente (codigo_dep, codigo_funcionario, nome_dependente, salario_dependente) 
VALUES 
(1, 1, 'Paula', 1000.00),
(2, 1, 'Mateus', 800.00),
(3, 2, 'Laura', 1200.00),
(4, 3, 'Gabriel', 900.00),
(5, 4, 'Carolina', 1100.00),
(6, 5, 'Matheus', 950.00),
(7, 6, 'Bruna', 850.00),
(8, 7, 'Pedro', 800.00),
(9, 8, 'Giovana', 1000.00),
(10, 9, 'Rafael', 950.00)

/*
1.Criar uma database, criar as tabelas abaixo, definindo o tipo de dados e a relação PK/FK e popular
com alguma massa de dados de teste (Suficiente para testar UDFs)

Funcionário (Código, Nome, Salário)
Dependendente (Código_Dep, Código_Funcionário, Nome_Dependente, Salário_Dependente)

a) Código no Github ou Pastebin de uma Function que Retorne uma tabela:
(Nome_Funcionário, Nome_Dependente, Salário_Funcionário, Salário_Dependente)

b) Código no Github ou Pastebin de uma Scalar Function que Retorne a soma dos Salários dos
dependentes, mais a do funcionário.
*/

CREATE FUNCTION fn_funcionario_dependente()
RETURNS @tabela TABLE
(
	nome_funcionario	VARCHAR(50),
	nome_dependente		VARCHAR(50),
	salario_funcionario	DECIMAL(7, 2),
	salario_dependente	DECIMAL(7, 2)
)
BEGIN
	INSERT INTO @tabela
		SELECT f.nome, d.nome_dependente, f.salario, d.salario_dependente FROM funcionario f, dependente d
		WHERE f.codigo = d.codigo_funcionario
	
	RETURN
END

SELECT * FROM fn_funcionario_dependente() 

CREATE FUNCTION fn_soma_func_depend()
RETURNS INT
AS
BEGIN
	DECLARE @salarios_funcionario INT,
			@salarios_dependente  INT,
			@salarios INT
	SELECT @salarios_funcionario = SUM(f.salario), @salarios_dependente = SUM(d.salario_dependente)FROM funcionario f, dependente d WHERE f.codigo = d.codigo_funcionario
	SET @salarios = @salarios_funcionario + @salarios_dependente
	
	RETURN @salarios
END

SELECT dbo.fn_soma_func_depend() AS soma_salario



