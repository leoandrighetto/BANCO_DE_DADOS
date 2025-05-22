/* Structered Query Language */

/* apagar todo o esquema (schema) */
drop database livraria;

create database livraria;

use livraria;  /* para executar todos os comandos abaixo no esquema (schrema) livraria */

create table livraria.clientes (
  codigo int not null auto_increment,
  nome varchar(45) not null,
  endereco_email varchar(200),
  cpf varchar(11),
  sexo ENUM('F','M') default 'M', 
  data_nascimento date default current_timestamp,
  primary key (codigo)
);

create table telefones_clientes (
  numero_telefone varchar(11) not null,
  clientes_codigo int not null,
  primary key (numero_telefone, clientes_codigo), 
  foreign key (clientes_codigo) references clientes(codigo)
);

/* comando para apagar uma tabela */
/* drop table telefones_clientes;*/ 

create table notas_fiscais (
  numero int not null  auto_increment, 
  data date default current_timestamp,
  clientes_codigo int not null,
  primary key (numero), 
  foreign key (clientes_codigo) references clientes(codigo)
);

CREATE TABLE gerentes (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  telefone_contato VARCHAR(13) NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE editoras (
  codigo INT NOT NULL AUTO_INCREMENT,
  telefone VARCHAR(13) NOT NULL,
  gerentes_id INT NOT NULL,
  PRIMARY KEY (codigo),
  CONSTRAINT chave_gerentes FOREIGN KEY (gerentes_id) REFERENCES gerentes(id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE areas_tematicas (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE livros (
  isbn VARCHAR(14) NOT NULL,
  titulo VARCHAR(100) NOT NULL,
  quantidade_estoque INT UNSIGNED NOT NULL,
  preco_unitario FLOAT UNSIGNED ZEROFILL NOT NULL,
  editoras_codigo INT NOT NULL,
  areas_tematicas_id INT NOT NULL,
  
  PRIMARY KEY (isbn),
  
  CONSTRAINT chave_editoras
     FOREIGN KEY (editoras_codigo) 
     REFERENCES editoras(codigo),
     
  CONSTRAINT chave_areas_tematicas FOREIGN KEY (areas_tematicas_id) REFERENCES areas_tematicas(id)
);

CREATE TABLE autores (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  
  PRIMARY KEY (id)
);


CREATE TABLE livros_has_autores (
  livros_isbn VARCHAR(14) NOT NULL,
  autores_id INT NOT NULL,
  
  PRIMARY KEY (livros_isbn, autores_id),
  
  CONSTRAINT estrangeira_para_livros
  FOREIGN KEY (livros_isbn)
  REFERENCES livros (isbn)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
  #CONSTRAINT cria o nome de uma chave estrangeira
  CONSTRAINT estrangeira_para_autores
  FOREIGN KEY (autores_id)
  REFERENCES autores(id)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
);

CREATE TABLE emails_editoras (
  endereco_email VARCHAR(100) NOT NULL,
  editoras_codigo INT NOT NULL,
  PRIMARY KEY (endereco_email, editoras_codigo),
  FOREIGN KEY (editoras_codigo) REFERENCES editoras (codigo)
  
  ON DELETE CASCADE
  #Quando uma EDITORA for excluída, seus EMAILS serão deletados em cascata
  
  ON UPDATE NO ACTION
);

CREATE TABLE notas_fiscais_has_livros (
  notas_fiscais_numero INT NOT NULL,
  livros_isbn VARCHAR(14) NOT NULL,
  quantidade INT NOT NULL,
  PRIMARY KEY (livros_isbn, notas_fiscais_numero),
  CONSTRAINT chave_notas_fiscais
    FOREIGN KEY (notas_fiscais_numero)
    REFERENCES notas_fiscais (numero)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT chave_para_livros2
    FOREIGN KEY (livros_isbn)
    REFERENCES livros(isbn)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);


ALTER TABLE notas_fiscais_has_livros
ADD column unidade varchar(3) default 'UNI';

CREATE TABLE unidades (
  sigla varchar(3) not null,
  descricao varchar(100) not null,
  primary key (sigla)
);


ALTER TABLE notas_fiscais_has_livros
ADD CONSTRAINT chave_para_unidades
    FOREIGN KEY (unidade)
    REFERENCES unidades(sigla)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
    
ALTER TABLE notas_fiscais_has_livros
DROP CONSTRAINT chave_para_unidades;

ALTER TABLE notas_fiscais_has_livros
CHANGE COLUMN quantidade 
              quantidade INT UNSIGNED ZEROFILL;
              
