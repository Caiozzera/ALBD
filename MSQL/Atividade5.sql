create database atividade05;
use atividade05;

create table paises(
	id bigint unique not null auto_increment primary key,
    nome varchar(100) not null,
    sigla varchar(3) not null
);

create table estados(
	id bigint unique not null auto_increment primary key,
    id_pais bigint not null,
    nome varchar(100) not null,
    sigla varchar(3) not null,
    foreign key (id_pais) references paises(id)
);

create table cidades(
	id bigint unique not null auto_increment primary key,
    id_estados bigint not null,
    nome varchar(100) not null,
    foreign key (id_estados) references estados(id)
);

create table clientes(
	id bigint unique not null auto_increment primary key,
    id_cidade bigint not null,
    nome_fantaisa varchar(150),
    razao_social varchar(150) not null,
    cnpj varchar(18) not null,
    telefone varchar(11),
    foreign key (id_cidade) references cidades(id)
);

create table usuarios(
	id bigint unique not null auto_increment primary key,
    id_clientes bigint not null,
    nome varchar(150) not null,
    email varchar(150) not null,
    cpf varchar(11) not null,
    senha varchar(11) not null,
    foreign key (id_clientes) references clientes(id)
);

create table veiculos(
	id bigint unique not null auto_increment primary key,
    id_clientes bigint not null,
    placa varchar(9) not null,
    renavan varchar(100) not null,
    chassi varchar(200) not null,
    foreign key (id_clientes) references clientes(id)
);

create table motoristas(
	id bigint unique not null auto_increment primary key,
    id_clientes bigint not null,
    nome varchar(150) not null,
    email varchar(150) not null,
    cpf varchar(11) not null,
    nro_cnh varchar(50) not null,
    nivel_habilitacao varchar(2),
    foreign key (id_clientes) references clientes(id)
);

create table produtos(
	id bigint unique not null auto_increment primary key,
    nome varchar(150) not null
);

create table viagens(
	id bigint unique not null auto_increment primary key,
    id_cliente bigint not null,
    id_motorista bigint not null,
    id_cidade_origen bigint not null,
    id_cidade_destino bigint not null,
    valor_carga decimal(12,2) not null,
    foreign key (id_cliente) references clientes(id),
    foreign key (id_cidade_origen) references cidades(id),
    foreign key (id_cidade_destino) references cidades(id),
    foreign key (id_motorista) references motoristas(id)
);

create table produtos_viagens(
	id bigint unique not null auto_increment primary key,
    id_produto bigint not null,
    id_viagem bigint not null,
	foreign key (id_produto) references produtos(id),
    foreign key (id_viagem) references viagens(id)
);

insert into paises
	values (null, 'Brasil', 'BR');

insert into estados (id, id_pais, nome, sigla)
	values (1, 1, 'Santa Catarina','BR'), (2, 1, 'Paraná','BR'), (3, 1, 'Rio Grande Do sul','BR');
 
insert into clientes 
	values (null, 2, 'Josue', 'Josue lanches', '11101177000104', '34410500'),
	(null, 2, 'Bruna', 'Bruna Carolina', '111111177771111111', '11111-8888'),
	(null, 2, 'Gabriela', 'Gabriela Fornari', '123456789055555555', '8888-11111');
    
insert into usuarios
	values (1, 1, 'Jos', 'jos@gmail.com', '10293847561', 'j1j2j3j4'),
	(2, 1, 'Jos', 'jos@gmail.com', '11193847561', 'j1j2j3j4'),
	(3, 2, 'Bru', 'bru@gmail.com', '22229394959', 'b1b2b3b4'),
	(4, 2, 'Bru', 'bru@gmail.com', '91929394959', 'b1b2b3b4'),
	(5, 3, 'Gabi', 'gabi@gmail.com', '33321314151', 'g1g2g3g4'),
	(6, 3, 'Gabi', 'gabi@gmail.com', '11121314151', 'g1g2g3g4');

insert into veiculos
 values (1, 1, 'XLY-890', '11010101-0', 'A2341V134V2424V22'),
	(2, 1, 'ABC-234', '91911919-9','B5B6V134V2SSR43'),
	(3, 1, 'CDE-563', '89282328-8', 'C1BC2B5134V2GH77'),
	(4, 2, 'LKZ-364', '73787389-7', 'HSH4H563566H903'),
	(5, 2, 'MLK-414', '66634546-6','AB3845DJSRKJG48'),
	(6, 2, 'MKK-111', '54555657-5', 'JA4J5J6J3JK7K45'),
	(7, 3, 'JKJ-001', '41225976-4','N3H4HGS6G5G3G56'),
	(8, 3, 'QWE-678', '33737963-3', 'J3J4J5J6J8J9J65'),
	(9, 3,'SDI-345',  '22848252-2','P8P4PDO0G4GV4V5');
    
insert into produtos
	values (1, 'Maça'),
	(2, 'Abacate'),
	(3, 'Laranja');
    
insert into motoristas 
	values (1, 1, 'Joelma', 'joelma@gmail.com', '13254578594', '0000001', 'BC'),
	(2, 2, 'Bruno', 'bruno@gmail.com', '12345678910', '0000002', 'AC'),
	(3, 3, 'Gabriel', 'gabriel@gmail.com', '98765456721', '0000003', 'BC');

insert into viagens 
 values (1, 1, 1, 1, 2, 500),
	(2, 2, 2, 3, 5, 700),
	(3, 3, 3, 3, 5, 600),
	(4, 1, 1, 4, 3, 800),
	(5, 2, 2, 5, 4, 400);
    
delete from viagens where id=1;

insert into viagens 
 values (1, 1, 1, 1, 2, 50000);
 
select * from viagens
inner join clientes on viagens.id_cliente  = clientes.id
inner join  usuarios on clientes.id = usuarios.id_clientes
where usuarios.id = 1;

select * from viagens 
where id_cidade_destino = 3;

select * from viagens
inner join produtos_viagens on viagens.id = produtos_viagens.id_produto
inner join produtos on produtos_viagens.id_produto = produtos.id
where produtos.id = 2;

select * from produtos
inner join produtos_viagens on produtos_viagens.id_produto = produtos.id
inner join viagens on viagens.id = produtos_viagens.id_produto
where viagens.id_cidade_origen = 4;

select * from viagens 
inner join motoristas on viagens.id_motorista = motoristas.id
inner join usuarios on viagens.id_cliente = usuarios.id_clientes
where id_motorista = 1 and usuarios.id = 2;

select * from viagens
where valor_carga >= 50000