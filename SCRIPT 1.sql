drop database if exists obra;
CREATE DATABASE obra;
USE obra;

CREATE TABLE projetos(
  id_projeto int primary key,
  nome VARCHAR (50),
  n_funcionarios int,
  status_obra VARCHAR (50),
  prazo VARCHAR (50)
  );
  
INSERT INTO projetos VALUES
(1,"predio_1",25,NULL,"3 Meses"),
(2,"predio_2",25,"Planejamento","4 Meses"),
(3,"predio_3",25,NULL,"5 Meses"),
(4,"predio_4",25,"Planejamento","7 Meses"),
(5,"pavilhão_1",NULL,NULL,"Indeterminado"),
(6,"pavilhão_2",NULL,NULL,"Indeterminado");

CREATE TABLE funcionarios(
  id_funcionario int primary key,
  id_projeto int,
  nome VARCHAR (50),
  profissao VARCHAR (50),
  FOREIGN KEY (id_projeto) REFERENCES projetos(id_projeto)
  );
  
INSERT INTO funcionarios VALUES
(1,1,"Gabriel","pedreiro"),
(2,1,"João","azulejista"),
(3,2,"Lucas","pintor"),
(4,2,"Mateus","gesseiro"),
(5,3,"Pedro","eletricista"),
(6,3,"Rafael","eletricista_instalador"),
(7,4,"Felipe","pintor"),
(8,4,"Henrique","serralheiro"),
(9,NULL,"Dirnei","Rebocador"),
(10,NULL,"Crisnei","Designer");


 CREATE TABLE materiais(
   id_material int primary key,
   id_funcionario int,
   nome VARCHAR (50),
   quantidade VARCHAR (50),
   FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario)
   );
   
INSERT INTO materiais VALUES
(1,1,"cimento","100_Kg"),
(2,2,"azulejo","500 M²"),
(3,3,"massa_corrida","200 L"),
(4,4,"placa_de_drywall","300 M²"),
(5,5,"eletrodutos","2 Km"),
(6,6,"cabo_elétrico","3 Km"),
(7,7,"tintas","200 L"),
(8,8,"maquina_de_solda","20");
