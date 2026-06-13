CREATE DATABASE Biblioteca1; 

USE Biblioteca1;

--- Criando tabela AUTOR
CREATE TABLE Autor(
idAutor SMALLINT IDENTITY,
NomeAutor VARCHAR(50),
SobrenomeAutor VARCHAR(60),
CONSTRAINT pk_id_autor PRIMARY KEY(IdAutor)
);

--- Criando tabela EDITORA
CREATE TABLE Editora(
idEditora SMALLINT PRIMARY KEY IDENTITY,
NomeEditora VARCHAR(50) NOT NULL
);
GO

--- Criando tabela ASSUNTO
CREATE TABLE Assunto(
IdAssunto TINYINT PRIMARY KEY IDENTITY,
NomeAssunto VARCHAR(25) NOT NULL
);
GO

--- Criado tabela LIVROS

CREATE TABLE Livros (
IdLivro SMALLINT NOT NULL PRIMARY KEY IDENTITY (100,1), -- Começa no valor 100 de 1 em 1
NomeLivro VARCHAR(70) NOT NULL,
ISBN13 CHAR(13) UNIQUE NOT NULL,
DataPub DATE,
PrecoLivro MONEY NOT NULL,
NumeroPaginas SMALLINT NOT NULL,
IdEditora SMALLINT NOT NULL,  --- Chave estrangeira
IdAssunto TINYINT NOT NULL,  --- Chave estrangeira
CONSTRAINT fk_id_editora FOREIGN KEY(IdEditora)
REFERENCES Editora(IdEditora) ON DELETE CASCADE,   --- Se relaciona com tabela EDITORA
--- ON DELETE CASCADE  -> Deletar registro ou seja uma "editora" na tabela editora
--- Todos os livros da tabela que forem da editora serão excluidos
CONSTRAINT fk_id_assunto FOREIGN KEY(IdAssunto)
REFERENCES Assunto(IdAssunto) ON DELETE CASCADE,  --- Se relaciona com tabela ASSUNTO
--- Todos os livros da tabela que forem do mesmo assunto serão excluidos
CONSTRAINT verifica_preco CHECK (PrecoLivro >=0) --- Regra 
);
GO

--- Criar tabela LIVROAUTOR (Tabela Associativa)
CREATE TABLE LivroAutor(
IdLivro SMALLINT NOT NULL,
IdAutor SMALLINT NOT NULL,
CONSTRAINT fk_id_livros FOREIGN KEY (IdLivro) REFERENCES Livros(IdLivro),
CONSTRAINT fk_id_autores FOREIGN KEY(IdAutor) REFERENCES Autor(IdAutor),
CONSTRAINT pk_livro_autor PRIMARY KEY (IdLivro, IdAutor)
);
GO

-- Comando que lista as tabelas de um BD
SELECT name FROM Biblioteca1.sys.tables;

-- Adicionar uma coluna na tabela "LIVROS"
ALTER TABLE Livros
ADD Edicao SMALLINT;

ALTER TABLE Assunto
ADD NomeAssunto VARCHAR(25) NOT NULL;

-- Alterar tipo de dados de uma colunas
ALTER TABLE Livros
ALTER COLUMN Edicao TINYINT;

-- Excluir CONSTRAINT de uma coluna
/*
ALTER TABLE NomeTabela
DROP CONSTRAINT NomeConstraint
*/

-- Verificar nomes das contraint 
EXEC sp_help Livros;


-- Excluir tabela
/*
DROP TABLE NomeTabela
*/

-- Renomear tabela
-- sp_rename 'Livro', 'Livros'


-- Exibir dados da tabela
SELECT * FROM Assunto;

-- Renomear colunas
EXEC sp_rename 'Livros.NomeLivroS','NomeLivro','COLUMN';

-- Inserir Dados em Assusntos
INSERT INTO Assunto (NomeAssunto)
VALUES
('Ficção Ciêntifica'), ('Botânica'),
('Eletronica'), ('Matemática'),
('Aventura'), ('Romance'),
('Finanças'), ('Gastronomia'),
('Terror'), ('Administração'),
('Informática'), ('Suspense');
GO

--	Listar dados em uma tabela
SELECT * FROM Autor;

-- Listar partes especifica da tabela
SELECT NomeEditora FROM Editora;


-- Inserir dados em Editora
INSERT INTO Editora (NomeEditora)
VALUES ('Prentice Hall'), ('Botânica');
GO

INSERT INTO Editora (NomeEditora)
VALUES ('Aleph'), ('Microsoft Press'),
('Wiley'), ('HarperCollins'),
('Érica'), ('NovaTec'),
('McGraw-Hill'), ('Apress'),
('Francisco Alves'), ('Sybex'),
('Globo'), ('Companhia das Letras'),
('Morro Branco'), ('Penguin Books'),('Martin Claret'),
('Redord'), ('Springer'),('Melhoramentos'),
('Oxford'), ('Taschen'),('Ediouro'),('Bookman');
GO

-- Inserir dados em Editora
INSERT INTO Autor(NomeAutor, SobrenomeAutor)
VALUES ('Umberto', 'Eco');
GO

SELECT * FROM Autor;

INSERT INTO Autor(NomeAutor, SobrenomeAutor)
VALUES 
('Daniel','Barret'), ('Gerald','Carter'), ('Mark','Sobell'),
('Willian','Stanek'), ('Christiane','Bresnahan'), ('William','Gibson'),
('James', 'Joyce'), ('John','Emsley'), ('José','Saramago'),
('Richard','Silverman'), ('Robert','Bynes'), ('Jay','Ts'),
('Robert', 'Eckstein'), ('Paul','Horowitz'), ('Winfield','Hill'),
('Joel','Murach'), ('Paul','Scherz'), ('Simon','Monk'),
('George','Orwell'), ('Ítalo','Calvino'), ('Machado','de Assis'),
('Oliver','Sacks'), ('Ray','Bradbury'), ('Water','Isaacson'), 
('Benjamin','Graham'), ('Júlio','Verne'), ('Marcelo','Gleiser'),
('Hari','Lorenzi'), ('Humphrey','Carpenter'), ('Isaac','Asimov');
GO

--Inserir dados tabela Livros
INSERT INTO Livros(NomeLivro, ISBN13, DataPub, PrecoLivro, NumeroPaginas, IdAssunto, IdEditora)
VALUES ('A arte da Eletrônica', '9788582604342', '20170308', 300.74,1160,3,24);

SELECT * FROM Livros;

INSERT INTO Livros(NomeLivro, ISBN13, DataPub, PrecoLivro, NumeroPaginas, IdAssunto, IdEditora)
VALUES 
('Vinte Mill Leguas Submarinas', '9788582850022', '20140916', 24.50, 488,1,16),
('O Inventor Inteligênte', '9788595080805', '20160125',79.90, 450,7,6);


--Inserir dados a partir de um arquivo CSV
INSERT INTO Livros(NomeLivro, ISBN13, DataPub, PrecoLivro, NumeroPaginas, IdAssunto, IdEditora)
SELECT
NomeLivro, ISBN13, DataPub,PrecoLivro, NumeroPaginas, IdAssunto, IdEditora
FROM OPENROWSET(
BULK 'C:\SQL\Livros.CSV',
FORMATFILE= 'C:\SQL\Formato.xml',
CODEPAGE='65001', --UTF-8
FIRSTROW=2 
) AS LivrosCSV;

-- Selecioar uma coluna especifica 
SELECT NomeLivro FROM Livros;

-- Listar itens distintos ou sem recepção 
SELECT DISTINCT IdEditora FROM Livros;

-- Criar tabela com dados de outra
SELECT NomeLivro, ISBN13
INTO LivroISBN
FROM Livros

-- Apagar tabela que criamos
DROP TABLE LivroISBN;

-- Criar tabela com todos os dados relacionado ao ID = 1
SELECT * 
INTO LivrosFiccao
FROM Livros
WHERE IdAssunto = 1;

SELECT * FROM LivrosFiccao;

DROP TABLE LivrosFiccao;

-- SEM o Order by 
SELECT * FROM Livros;

-- COM o Order by (Orem Crescente AUTO)
SELECT * FROM Livros
ORDER BY NomeLivro;

-- Order by DESC (Ordem Decrescente)
SELECT NomeLivro, PrecoLivro
FROM Livros
ORDER BY PrecoLivro DESC;


-- Exercicio 2
SELECT NomeLivro, PrecoLivro, DataPub FROM Livros;

-- Exercicio 3 
SELECT SobrenomeAutor From Autor;

-- Exercicio 4 
SELECT NomeEditora, IdEditora FROM Editora

-- Exercicio 5 
SELECT DISTINCT IdAssunto FROM Livros;

-- Exercicio 6
SELECT * INTO LivrosFiccao FROM Livros WHERE IdAssunto = 1; 

-- Exerccio 7 
DROP TABLE LivrosFiccao;

-- Mostrar valores ordenados em ordem crescente
SELECT NomeLivro FROM Livros ORDER BY NomeLivro;

-- Mostrar os 2 primeiros livos que estão no topo do BD
SELECT TOP(2) NomeLivro FROM Livros ORDER BY NomeLivro;

-- Mostrar 15% do valores do topo do BD
SELECT TOP (15) PERCENT NomeLivro FROM Livros ORDER BY NomeLivro;

-- Mostrar os 3 últimos nomes de livro em ordem decrescente
SELECT TOP(3) NomeLivro FROM Livros ORDER BY NomeLivro DESC;

-- Mostrar os 4 livros mais caros em ordem Decrescente
SELECT TOP(4) NomeLivro, PrecoLivro FROM Livros ORDER BY PrecoLivro DESC;

-- Mostrar os 4 mais baratos em ordem crescente
SELECT TOP(4) NomeLivro, PrecoLivro FROM Livros ORDER BY PrecoLivro;

-- Mostrar o 3 primeiros livros junto com os Ids
-- WITH TIES força SQL a trazer todos que possuem o mesmo ID 
-- Sem ele ele trará somente os 3 primeiros
SELECT TOP (3) WITH TIES NomeLivro, IdAssunto FROM Livros ORDER BY IdAssunto DESC;

-- Mostrar somente os livros com o ID = 3
SELECT NomeLivro, DataPub, IdEditora FROM Livros WHERE idEditora = 3;

-- Mostrar somente valores com o sobrenome especifico
SELECT IdAutor, NomeAutor FROM Autor WHERE SobrenomeAutor = 'Verne';

-- Mostrar Livros com o valor maior que 100,00
SELECT NomeLivro, PrecoLivro FROM Livros WHERE PrecoLivro > 100.00;

-- Mostrar 

SELECT NomeLivro, DataPub FROM Livros 
WHERE IdEditora = (
	SELECT IdEditora
	FROM Editora
	WHERE NomeEditora = 'Aleph'
)
ORDER BY NomeLivro;


SELECT * FROM Editora;

-- Deletar nome do assunto
DELETE FROM Assunto
WHERE NomeAssunto = 'Gastronomia'


SELECT * FROM Assunto;

DELETE FROM Assunto
WHERE IdAssunto = 12;




 -- Limpar todas as linhas da tabela

 CREATE TABLE teste (
 IdTeste SMALLINT PRIMARY KEY IDENTITY,
 ValorTeste SMALLINT NOT NULL
 );


 --- Incrementar dados automaticamente 
 DECLARE @Contador INT = 1
 WHILE @Contador <= 100
 BEGIN 
	INSERT INTO teste(ValorTeste) VALUES (@Contador * 3)
	SET @Contador = @Contador + 1
END


SELECT * FROM teste;

-- Limpar dados da tabela
TRUNCATE TABLE teste;

-- Verificar o valor atual do IDENTITY
SELECT IDENT_CURRENT('teste');


--- Atualizar nome do livro 

UPDATE Livros
SET NomeLivro = 'Eu, Robô'
WHERE IdLivro = 161;

SELECT * FROM Livros;

-- Alterar Preço do livro

SELECT IdLivro, NomeLivro, PrecoLivro
FROM Livros

UPDATE Livros
SET PrecoLivro	= 60.00
WHERE IdLivro = 102

UPDATE Livros
SET PrecoLivro	= PrecoLivro * 1.10
WHERE IdLivro = 102

-- Realizar duas alterações 
UPDATE Livros
SET PrecoLivro = 60.00, NumeroPaginas = 320
WHERE IdLivro = 102;

SELECT IdLivro, NomeLivro, PrecoLivro, NumeroPaginas 
FROM Livros

-- Se quiser alterar a resposta do id (Dar um apelido) 
SELECT NomeLivro AS Livros
FROM Livros

SELECT NomeAutor AS Nome, SobrenomeAutor AS Sobrenome
FROM Autor AS A;


SELECT TOP(3) NomeLivro AS 'Livros mais Caros', PrecoLivro AS 'Preço do Livro'
FROM Livros as L
ORDER BY [Preço do Livro] DESC;



SELECT * FROM Livros 
WHERE IdLivro = 102;

-- AND
SELECT * FROM Livros 
WHERE IdLivro > 102 AND IdEditora <4;

SELECT * FROM Livros 
WHERE IdLivro > 102 AND IdEditora < 102;

-- OR
SELECT * FROM Livros 
WHERE IdLivro > 102 OR IdEditora < 4;

-- NOT
SELECT * FROM Livros 
WHERE IdLivro > 102 OR NOT IdEditora < 4;

-- BETWEEN
SELECT * FROM Livros
WHERE DataPub BETWEEN '20040507' AND '20140507'



SELECT NomeLivro Livro, PrecoLivro Preço
FROM Livros
WHERE PrecoLivro BETWEEN 50.00 AND 100.00


SELECT NomeLivro, DataPub, PrecoLivro
FROM Livros
WHERE PrecoLivro > 60.00
AND DataPub BETWEEN '20050620' AND '20100620'
OR DataPub BETWEEN '20160101' AND '20200101'
ORDER BY DataPub DESC;

SELECT NomeLivro, DataPub, PrecoLivro
FROM Livros
WHERE PrecoLivro >=20.00
AND DataPub BETWEEN '20050620' AND '20100620'
OR DataPub BETWEEN '20160101' AND '20200101'
ORDER BY DataPub DESC;



-- Filtro trazendo o tipo de livro: o Autor e Editora
SELECT NomeAutor Nom, 'Autor' AS Tipo FROM Autor
UNION 
SELECT NomeEditora Nome, 'Editora' AS tIPO FROM Editora


-- Filtro trazendo o tipo de livro: o nome do Livro e Assunto
SELECT NomeLivro Nome, 'Livro' AS Tipo FROM Livros
UNION
SELECT NomeAssunto Nome, 'Assunto' AS Tipo FROM Assunto;

-- 
SELECT COUNT (*) as 'Total Autores'
FROM Autor

SELECT MAX (PrecoLivro) AS 'Preço mais Caro'
FROM Livros;

SELECT MIN(NumeroPaginas) AS 'Menor Número de Páginas'
FROM Livros

SELECT NomeLivro, PrecoLivro
FROM Livros
WHERE PrecoLivro = (
	SELECT MAX(PrecoLivro)
	FROM Livros
);

-- Começando com 'F'
SELECT * FROM Livros
WHERE NomeLivro LIKE 'F%'

-- Não tem 'F'
SELECT * FROM Autor
WHERE NomeAutor NOT LIKE 'S%';

-- Começam COM f OU d
SELECT * FROM Livros
WHERE NomeLivro LIKE '[FD]%';

-- Livros com F e D
SELECT * FROM Livros
WHERE NomeLivro LIKE '[F^D]%';


-- Termina com 'F'
SELECT * FROM Livros
WHERE NomeLivro LIKE '%F';

--INNER JOIN: Filtrando Nome do Livro com o tema do Livro
SELECT Livros.NomeLivro, Assunto.NomeAssunto
FROM Livros
INNER JOIN Assunto
ON Livros.IdAssunto = Assunto.IdAssunto



SELECT NomeLivro AS Livros, NomeEditora AS Editora
FROM Livros
iNNER JOIN Editora
ON Livros.IdEditora = Editora.idEditora
WHERE Editora.NomeEditora LIKE '[MN]%'
ORDER BY Livros.NomeLivro;

-- Organizando
SELECT L.NomeLivro Livros, E.NomeEditora Editora
FROM Livros L
iNNER JOIN Editora E
ON L.IdEditora = E.idEditora
WHERE E.NomeEditora LIKE '[MN]%'
ORDER BY L.NomeLivro;
