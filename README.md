# 📚 Sistema de Gerenciamento de Biblioteca - SQL Server

## 📌 Sobre o Projeto

O projeto **Biblioteca1** consiste na criação e manipulação de um banco de dados para gerenciamento de uma biblioteca utilizando **SQL Server**.

O sistema permite o cadastro de autores, editoras, assuntos e livros, além de controlar os relacionamentos entre essas entidades através de tabelas associativas e chaves estrangeiras.

## 🛠 Tecnologias Utilizadas

- SQL Server
- SQL Management Studio (SSMS)
- T-SQL

## 🗄 Estrutura do Banco de Dados

### Tabela Autor
- IdAutor
- NomeAutor
- SobrenomeAutor

### Tabela Editora
- IdEditora
- NomeEditora

### Tabela Assunto
- IdAssunto
- NomeAssunto

### Tabela Livros
- IdLivro
- NomeLivro
- ISBN13
- DataPub
- PrecoLivro
- NumeroPaginas
- IdEditora
- IdAssunto
- Edicao

### Tabela LivroAutor
- IdLivro
- IdAutor

## 🔗 Relacionamentos

- Uma Editora pode publicar vários Livros.
- Um Assunto pode possuir vários Livros.
- Um Livro pode possuir vários Autores.
- Um Autor pode escrever vários Livros.

## ⚙️ Funcionalidades Implementadas

- CREATE DATABASE
- CREATE TABLE
- ALTER TABLE
- INSERT
- UPDATE
- DELETE
- TRUNCATE
- SELECT
- INNER JOIN
- UNION
- COUNT
- MAX
- MIN
- OPENROWSET

## 📂 Como Executar

1. Abra o SQL Server Management Studio.
2. Crie uma nova consulta.
3. Cole o script SQL.
4. Execute o script.
5. O banco Biblioteca1 será criado automaticamente.

## 🎯 Objetivos de Aprendizagem

- Modelagem Relacional
- SQL Server
- T-SQL
- Integridade Referencial
- Banco de Dados
- Data Science

## 👩‍💻 Autora

**Andressa Santos**

### Área de Estudo

- Banco de Dados
- Data Science
- Análise de Dados

## 📄 Licença

Projeto desenvolvido para fins educacionais e acadêmicos.
