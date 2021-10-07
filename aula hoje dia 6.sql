create database if not exists exercicio5;

use exercicio5;

create table pais(
	id bigint unsigned unique not null primary key,
    nome varchar (100) not null,
    sigla varchar(3) not null
    );

create table estados(
	id bigint unsigned unique  not null primary key,
    id_pais bigint unsigned not null,
    nome varchar (100) not null,
    sigla varchar(3) not null,
    foreign key (id_pais) references estados(id)
    );


create table cidades(
	id bigint unsigned unique  not null primary key,
    id_estado bigint unsigned not null,
	nome varchar (100) not null,
	foreign key (id_estado) references cidades(id)
    );
    
create table viagens(
	id bigint unsigned unique  not null primary key,
	id_estado bigint unsigned not null,
    id_motorista bigint unsigned not null,
    id_cidade_origem bigint unsigned not null,
    id_cidade_destino bigint unsigned not null,
    valor_carga decimal(11,2) not null,
    foreign key (id_estado) references viagens(id),
	foreign key (id_motorista) references viagens(id),
	foreign key (id_cidade_origem) references viagens(id),
	foreign key (id_cidade_destino) references viagens(id)
    );
    
       
create table produto_viagens(
	id bigint unsigned unique  not null primary key,
    id_produto bigint unsigned not null,
	id_viagem bigint unsigned not null,
    foreign key (id_produto) references produto_viagens(id),
	foreign key (id_viagem) references produto_viagens(id)
);

create table produtos(
	id bigint unsigned unique not null primary key,
    nome varchar (100) not null
    );
    
create table motorista(
	id bigint unsigned unique not null primary key,
    id_cliente bigint unsigned not null,
	nome varchar (150) not null,
    email varchar (150) not null,
    cpf varchar (11) not null,
    nro_cnh varchar (50) not null,
    nivel_habilitacao varchar(2),
    foreign key (id_cliente) references motorista(id)
   ); 
   
       
create table clientes(
	id bigint unsigned unique not null primary key,
    id_cidade bigint unsigned not null,
	nome_fantasia varchar (150),
    razao_social varchar (150) not null,
    cpfj varchar (18) not null,
    telefone varchar (50),
	email varchar (100) not null,
    foreign key (id_cidade) references clientes(id)
   ); 
   
          
create table veiculos(
	id bigint unsigned unique not null primary key,
    id_cliente bigint unsigned not null,
	placa varchar (150) not null,
    renavan varchar (150) not null,
    chassi varchar (18) not null,
	foreign key (id_cliente) references veiculos(id)
   ); 
   
         
create table usuarios(
	id bigint unsigned unique not null primary key,
    id_cliente bigint unsigned not null,
	nome varchar (150) not null,
    email varchar (100) not null,
    cpf varchar (11) not null,
    senha varchar (100) not null,
	foreign key (id_cliente) references u(id)
   ); 
   
select * from pais;

insert into pais (id, nome, sigla)
	values (1, 'Brasil', 'BR');

select * from estados;

insert into estados (id, id_pais, nome, sigla)
	values (1, 1, 'Santa Catarina','BR'), (2, 1, 'Paraná','BR'), (3, 1, 'Rio Grande Do sul','BR');
    
select * from cidades;

insert into cidades ( id, id_estado, nome)
	values (1, 1, 'Floriánopolis'), (2, 1, 'Concórdia'), (3, 1, 'Irani'), (4, 1, 'Lages'),  (5, 1, 'Chapecó'),
    (6, 2, 'Curitiba'), (6, 2, 'Londrina'), (8, 2, 'Maringá'), (9, 2, 'Cascavel'), (10, 2, 'Foz do Iguaçu'),
    (11, 3, 'Porto Alegre'), (12, 3, 'Santa Maria'), (13, 3, 'Erechim'), (14, 3, 'Pelotas'), (15, 3, 'Caxias do Sul');
	
select * from clientes;

insert into clientes ( id, id_cidade, nome_fantasia, razao_social, cnpj, telefone, email)
	values ( 1, 1 , 'Caio', '
   
    