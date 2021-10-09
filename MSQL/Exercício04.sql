create database if not exists Exercicio4;

use Exercicio4;

create table pais(
	id int unsigned unique not null primary key,
    nome varchar (100) not null,
    idioma char (3) not null
);
alter table pais drop column idioma; 
alter table pais add idioma char(5);

create table estados(
	id int unsigned unique not null primary key,
	id_pais int unsigned not null,
	nome varchar (100) not null,
	foreign key (id_pais) references estados(id)
);

create table cidade(
	id int unsigned unique not null primary key,
    id_estados int unsigned not null,
    nome varchar (150) not null,
	foreign key (id_estados) references cidade(id)
);

create table clientes(
	id int unsigned unique not null primary key ,
    id_cidade int unsigned not null,
    razao_social varchar(100) not null,
    nome_fantasia varchar(100) not null, 
    cnpj char(14) not null,
    endereco varchar(100) not null,
    cep char(8) not null,
    telefone char(14) not null, 
    email varchar(100) not null,
    situacao char(1) not null,
    foreign key (id_cidade) references clientes(id)
);

create table vendas(
	id int unsigned unique not null primary key,
    id_vendedor int unsigned  not null,
	id_clientes int unsigned  not null,
    data_venda datetime not null,
    situacao char(1),
    foreign key (id_vendedor) references vendas(id),
	foreign key (id_clientes) references vendas(id)
);

 
create table vendedor(
	id int unsigned unique not null primary key,
    nome varchar (100) not null,
   telefone char(14) not null,
   email varchar (100) not null,
   endereco varchar (100) not null
);

create table item_venda(
	id int unsigned unique not null primary key,
    id_venda int unsigned  not null,
	id_produto int unsigned  not null,
    id_unidade_medida  int unsigned  not null,
    preco_unitario decimal (11,2),
    quantidade decimal (11,2),
    total decimal (11,2),
    foreign key (id_venda) references item_venda(id),
    foreign key (id_produto) references item_venda(id),
	foreign key (id_unidade_medida) references item_venda(id)
);


create table unidade_medida(
	id int unsigned unique not null primary key,
	sigla char(2) not null,
    descricao varchar (100) not null
);

create table produto(
	id  int unsigned unique not null primary key,
    id_drupo_produto  int unsigned  not null,
	descricao varchar (100) not null,
    custo decimal (11,2) not null,
    saldo_estoque decimal(11,2) not null,
    situacao char (1) not null,
    foreign key (id_drupo_produto) references produto(id)
);

create table grupo_produto(
	id  int unsigned unique not null primary key,
    descricao varchar (100)
);

insert into pais (id, nome, idioma)
	values (1, 'Brasil', 'PT-BR'), (2, 'EUA', 'EN');
    
insert into estados (id, id_pais, nome)
	values (1, 1, 'Santa Catarina'), (2, 1, 'Paraná'), (3, 1, 'Rio Grande Do sul'), (4, 1, 'São Paulo'), (5, 2, 'Califoria');
    
insert into cidade (id, id_estados, nome)
	values (1, 1, 'Joaçaba'),  (2, 1, 'Joinville'), (3, 1, 'Florianópolis'), (4, 2, 'Curitiba'), (5 ,2 , 'londrina'), (6, 3, 'Porto Alegre'), (7, 4, 'São Paulo'), (8 , 5 , 'Moutain View');

select* from pais;
select * from estados;
select * from cidade;

select* from vendas;
select * from vendedor;
select * from clientes;
select * from produto; 
select * from item_venda;
select * from grupo_produto;

select vendas.data_venda,
 vendedor.nome as nome_vendedor,
 clientes.razao_social,
 cidades.nome as cidade_cliente,
 estado.nome as estado_cliente,
 pais.nome as pais_cliente,
 produto.descrisao as produto,
 item_venda.quantidade as quantidade_vendida, 
 unidade_medida.descricao as descricao_un_med,
 item_venda.preco_unitario,
 item_venda.total
 from vendas
 inner join vendedor on vendas.id_vendedor = vendedor.id
 inner join clientes on vendas.id_clientes = clientes.id
 inner join cidade on clientes.id_cidade = cidade.id
 inner join estados on cidade.id_estados = estados.id
 inner join pais on estado.id_pais = pais.id
 inner join item_venda on vendas.id = item_venda.id_venda
 inner join produto on item_venda.id = descricao.id_produto
 inner join unidade_medida on item_venda.id_unidade_medida = unidade_medida.id
inner join produto on item_venda.id_produto = produto.id
inner join grupo_produto on produto.id_grupo_produto = grupo_produto.id;

