📚 Sistema de Biblioteca - SQL Server

Este projeto contém a criação e manipulação de um banco de dados chamado Biblioteca1, desenvolvido em SQL Server, com foco em práticas de modelagem relacional e comandos SQL.

🗂️ Estrutura do Banco de Dados
👤 Autor
IdAutor (PK)
NomeAutor
SobrenomeAutor
🏢 Editora
IdEditora (PK)
NomeEditora
📖 Assunto
IdAssunto (PK)
NomeAssunto
📚 Livros
IdLivro (PK)
NomeLivro
ISBN13
DataPub
PrecoLivro
NumeroPaginas
IdEditora (FK)
IdAssunto (FK)
Edicao

📌 Regras:

Preço não pode ser negativo
Relacionamentos com Editora e Assunto
ON DELETE CASCADE
🔗 LivroAutor

Tabela de relacionamento (muitos para muitos)

IdLivro (FK)
IdAutor (FK)
PK composta (IdLivro, IdAutor)
⚙️ Funcionalidades
🏗️ Criação do banco
CREATE DATABASE
CREATE TABLE
PRIMARY KEY / FOREIGN KEY
✏️ Alterações
ALTER TABLE
DROP CONSTRAINT
sp_rename
📥 Inserção de dados
INSERT manual
INSERT em lote
Importação CSV (OPENROWSET)
🔎 Consultas
SELECT
WHERE
ORDER BY
DISTINCT
TOP
LIKE
BETWEEN
🔗 JOINs
INNER JOIN (Livros + Assunto / Editora)
📊 Funções agregadas
COUNT
MAX
MIN
🔁 Outros comandos
UPDATE
DELETE
TRUNCATE
UNION
Subqueries
🎯 Objetivo

Praticar:

SQL Server
Modelagem de banco de dados
Consultas SQL
Relacionamentos
👨‍💻 Tecnologias
SQL Server
T-SQL