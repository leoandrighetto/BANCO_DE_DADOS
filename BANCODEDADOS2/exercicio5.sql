drop database if exists imobiliaria;
create database imobiliaria;

CREATE TABLE imobiliaria.proprietarios (
  codigo INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  PRIMARY KEY (codigo)
);

CREATE TABLE imobiliaria.telefones (
  numero_telefone INT NOT NULL,
  proprietarios_codigo INT NOT NULL,
  PRIMARY KEY (numero_telefone, proprietarios_codigo),
  CONSTRAINT chave_para_proprietarios
    FOREIGN KEY (proprietarios_codigo)
    REFERENCES imobiliaria.proprietarios(codigo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);



CREATE TABLE imobiliaria.categorias (
  id INT NOT NULL AUTO_INCREMENT,
  nome_categoria VARCHAR(45) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE imobiliaria.estados (
  sigla VARCHAR(2) NOT NULL,
  nome VARCHAR(45) NOT NULL,
  PRIMARY KEY (sigla)
);

CREATE TABLE imobiliaria.cidades (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  estados_sigla VARCHAR(2) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT chave_para_estados
    FOREIGN KEY (estados_sigla)
    REFERENCES imobiliaria.estados (sigla)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE imobiliaria.enderecos (
  id INT NOT NULL AUTO_INCREMENT,
  logradouro VARCHAR(100),
  bairro VARCHAR(45),
  numero VARCHAR(10),
  complemento VARCHAR(45),
  cidades_id INT NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT chave_para_cidades
    FOREIGN KEY (cidades_id)
    REFERENCES imobiliaria.cidades (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE imobiliaria.imoveis (
  codigo INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  descricao TEXT,
  disponibilidade TINYINT NOT NULL DEFAULT 0,
  estado_de_conservacao ENUM('RUIM', 'REGULAR', 'BOM', 'OTIMO'),
  valor_locacao DECIMAL(6,2) NOT NULL,
  endereco_id INT,
  proprietarios_codigo INT NOT NULL,
  categorias_id INT NOT NULL,
  PRIMARY KEY (codigo),
  CONSTRAINT chave_para_proprietarios_imovel
    FOREIGN KEY (proprietarios_codigo)
    REFERENCES imobiliaria.proprietarios(codigo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT chave_para_enderecos
    FOREIGN KEY (endereco_id)
    REFERENCES imobiliaria.enderecos(id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT chave_para_categorias
    FOREIGN KEY (categorias_id)
    REFERENCES imobiliaria.categorias(id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE imobiliaria.clientes (
  codigo INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  cpf VARCHAR(11) NOT NULL,
  rg VARCHAR(45) NOT NULL,
  data_nascimento DATE,
  PRIMARY KEY (codigo)
);

CREATE TABLE imobiliaria.emails (
  endereco_email VARCHAR(100) NOT NULL,
  clientes_codigo INT NOT NULL,
  PRIMARY KEY (endereco_email),
  CONSTRAINT chave_para_clientes
    FOREIGN KEY (clientes_codigo)
    REFERENCES imobiliaria.clientes (codigo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE imobiliaria.locacoes (
  codigo INT NOT NULL AUTO_INCREMENT,
  data_locacao DATE NOT NULL,
  tempo_aluguel INT NULL,
  imoveis_codigo INT NOT NULL,
  clientes_codigo INT NOT NULL,
  PRIMARY KEY (codigo),
  CONSTRAINT chave_para_imoveis_locacao
    FOREIGN KEY (imoveis_codigo)
    REFERENCES imobiliaria.imoveis (codigo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT chave_para_clientes_locacao
    FOREIGN KEY (clientes_codigo)
    REFERENCES imobiliaria.clientes(codigo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE imobiliaria.pagamentos (
  codigo INT NOT NULL AUTO_INCREMENT,
  valor FLOAT NULL,
  data_pagamento DATE,
  PRIMARY KEY (codigo)
);

CREATE TABLE imobiliaria.pagamentos_has_locacoes (
  pagamentos_codigo INT NOT NULL,
  locacoes_codigo INT NOT NULL,
  PRIMARY KEY (pagamentos_codigo, locacoes_codigo),
  CONSTRAINT chave_para_pagamentos
    FOREIGN KEY (pagamentos_codigo)
    REFERENCES imobiliaria.pagamentos (codigo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT chave_para_locacoes
    FOREIGN KEY (locacoes_codigo)
    REFERENCES imobiliaria.locacoes (codigo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS imobiliaria.Formas_de_pagamento (
  id INT NOT NULL AUTO_INCREMENT,
  forma_de_pagamento VARCHAR(45) NULL,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS imobiliaria.Pagamentos_has_Formas_de_pagamento (
  Pagamentos_codigo INT NOT NULL,
  Formas_de_pagamento_id INT NOT NULL,
  data_operacao DATE NULL,
  PRIMARY KEY (Pagamentos_codigo, Formas_de_pagamento_id),
  CONSTRAINT fk_Pagamentos_has_Formas_de_pagamento_Pagamentos1
    FOREIGN KEY (Pagamentos_codigo)
    REFERENCES imobiliaria.Pagamentos (codigo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Pagamentos_has_Formas_de_pagamento_Formas_de_pagamento1
    FOREIGN KEY (Formas_de_pagamento_id)
    REFERENCES imobiliaria.Formas_de_pagamento (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS imobiliaria.paises (
  sigla VARCHAR(3) NOT NULL,
  nome_pais VARCHAR(45) NOT NULL,
  PRIMARY KEY (sigla)
  );
  
alter table imobiliaria.estados
add column sigla_paises varchar(3) DEFAULT 'BRA';

alter table imobiliaria.estados
add constraint chave_estrangeira_paises foreign key (sigla_paises) references imobiliaria.paises(sigla);

insert into imobiliaria.clientes 
(nome,cpf,rg,data_nascimento) values
('José Carlos Almeida', '12345678974','78795258', str_to_date('15/05/1979', '%d/%m/%Y'));

select max(codigo) into @var from imobiliaria.clientes;

insert into imobiliaria.emails (endereco_email,clientes_codigo)
values ('jose.carlos@gmail.com',@var), ('almeidinha@hotmail.com',@var);

select max(codigo) into @var2 from imobiliaria.proprietarios;

insert into imobiliaria.proprietarios (codigo,nome) values
(@var2,'Maria Clara Silva'),(@var2,'Paulo aguiar');

select max(codigo) -1 into @codigomaria from imobiliaria.proprietarios;

insert into imobiliaria.telefones (numero_telefone,proprietarios_codigo) values
('987568523',@codigomaria),(' 856988625',@var2),('33395689',@var2);

