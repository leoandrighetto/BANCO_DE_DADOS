drop database if exists biblioteca;
Create database biblioteca;
use biblioteca;

create table Categorias(
id_categoria int primary key,
nome VARCHAR (20)
);

insert into Categorias VALUES
(1,"Romance"),
(2,"Aventura"),
(3,"Ficção"),
(4,"Terror"),
(5,"Fantasia"),
(6,"Infanto-Juvenil"),
(7,"História"),
(8,"Ciência"),
(9,"Mistério"),
(10,"Biografia");


create table Autores (
id_autor int primary key,
nome VARCHAR (20)
);

insert into Autores values
(1,"Machado de Assis"),
(2,"J.K Rowling"),
(3,"Mario Puzzo"),
(4,"Paulo Coelho"),
(5,"stephen hawking"),
(6,"William Shakespeare"),
(7,"George Orwell"),
(8,"Agatha Christie"),
(9,"Isaac Asimov"),
(10,"Haruki Murakami"),
(11,"Ernest Hemingway"),
(12,"J.R.R. Tolkien");

create table Livros (
id_livro int primary key,
id_autor int,
id_categoria int,
nome VARCHAR (50),
ano int,
FOREIGN KEY (id_autor) references Autores(id_autor),
FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria)
);

insert into Livros values
(1,6,1,"Hamlet",1623),
(2,5,3,"A Teoria De Tudo: A origem",2002),
(3,4,2,"O Alquimista",1988),
(4,3,1,"O Poderoso Chefão",1969),
(5,2,5,"Harry Potter Saga",2001),
(6,1,3,"Dom Casmurro",1988),
(7,12, 5,"O Senhor dos Anéis: A Sociedade do Anel", 1954),
(8,10, 7,"1984", 1949),
(9,8,9,"Assassinato no Expresso do Oriente", 1934),
(10,7,3,"Fundação", 1951),
(11,11,8,"O Velho e o Mar", 1952),
(12,9,6,"Kafka à Beira-Mar", 2002),
(13,6,4,"O Cemitério", 1983),
(14,4,2,"O Zahir", 2005),
(15,3,1,"O Godfather", 1969),
(16,2,10,"O Conto da Aia", 1985),
(17,1,4,"Memórias Póstumas de Brás Cubas", 1881);

create table Clientes(
id_cliente int primary key,
nome VARCHAR (50),
telefone VARCHAR (50),
endereco VARCHAR (50)
);

INSERT INTO Clientes VALUES
(1,'Lucas Linhares','993877613','Rua i 227'),
(2,'Mayara Linhares','993309038','Oscar Pereira 003'),
(3,'Millena Andrighetto','994521636','Acesso Bonar 2566'),
(4,'Mirella Andrighetto','923165785','Pinheiro Ambulante 8989'),
(5,'Toni Diel','945212587','Rua Piteurodáctilo 25'),
(6,'Tamine Diel','996583265','Rua Zizi Possi 4001'),
(7,'Rafael Santos','923445678','Avenida Brasil 345'),
(8,'Juliana Almeida','922334455','Rua das Flores 87'),
(9,'Paula Oliveira','944556677','Rua XV de Novembro 45'),
(10,'Carlos Silva','998877665','Rua do Comércio 123'),
(11,'Sofia Costa','995544332','Rua da Paz 45'),
(12,'Gustavo Ferreira','993211223','Avenida Paulista 98');


create table Emprestimos(
id_emprestimo int primary key,
id_livro int (50),
id_cliente int(50),
data_emprestimo VARCHAR (50),
prazo VARCHAR (50),
FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

insert into Emprestimos values

(1,4,6,"12/12/2024","21/01/2025"),
(2,5,5,"01/11/2024","22/02/2024"),
(3,1,4,"20/09/2024","02/03/2025"),
(4,2,3,"15/02/2024","15/03/2024"),
(5,6,2,"/02/05/2025","08/09/2026"),
(6,3,1,"20/02/2024","15/02/2038"),
(7,7,1,"01/10/2024","10/12/2024"),
(8,8,2,"02/12/2024","02/01/2025"),
(9,9,3,"03/01/2025","15/02/2025"),
(10,10,4,"10/02/2025","10/05/2025"),
(11,11,5,"20/03/2025","20/06/2025"),
(12,12,6,"22/03/2025","22/08/2025"),
(13,13,7,"25/03/2025","25/06/2025"),
(14,14,8,"30/04/2025","30/08/2025"),
(15,15,9,"15/05/2025","15/08/2025"),
(16,16,10,"20/06/2025","20/09/2025"),
(17,17,11,"01/07/2025","01/10/2025");

#Faça um JOIN entre Livros, Categorias e Empréstimos.

SELECT Livros.nome AS nome_do_Livro, Categorias.nome AS Nome_da_Categoria, Emprestimos.id_emprestimo
FROM Livros INNER JOIN Categorias on Livros.id_categoria= Categorias.id_categoria
INNER JOIN Emprestimos ON Livros.id_livro=Emprestimos.id_livro;

#Consulte o prazo dos empréstimos do cliente Lucas Linhares usando LEFT JOIN.

SELECT Emprestimos.prazo AS Prazo_do_Empréstimo, Clientes.nome AS Nome_do_Cliente FROM Emprestimos
LEFT JOIN CLientes ON Clientes.id_cliente = Emprestimos.id_cliente
WHERE Clientes.nome LIKE "%Lucas Linhares%"; 

#Consulte o telefone dos clientes que fizeram o empréstimo dos livros da categoria ficção usando RIGHT JOIN.

SELECT  Clientes.telefone as Telefone_de_cliente, Categorias.nome As Categoria_livro, Clientes.nome As Nome_do_cliente 
from Clientes 
join Emprestimos ON Emprestimos.id_cliente = Clientes.id_cliente
JOIN Livros ON Livros.id_livro = Emprestimos.id_livro 
RIGHT JOIN Categorias ON Livros.id_categoria = Categorias.id_categoria
WHERE Categorias.nome LIKE "%Ficção%";
