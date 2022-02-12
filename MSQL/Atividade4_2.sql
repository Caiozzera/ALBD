create database atividade45;
 use atividade45;

create table planos(
	id bigint unsigned not null unique primary key,
    nome varchar(100) not null
);

create table clientes(
	id bigint unsigned not null unique primary key,
    id_plano bigint unsigned not null,
	nome varchar(100) not null,
    cpf varchar(11) not null unique,
    nro_plano varchar(100),
    telefone varchar(14) not null,
    email varchar(100),
	foreign key (id_plano) references planos(id)
);

create table  especialidades(
	id bigint unsigned not null unique primary key,
    nome varchar(100) not null
);

create table  medicos(
	id bigint unsigned not null unique primary key,
    id_especialidade bigint unsigned not null unique,
	nome varchar(100) not null,
    crm varchar(50) not null,
    cpf varchar(11) not null,
    telefone varchar(14) not null,
    email varchar(100),
    foreign key (id_especialidade) references especialidades(id)
);

create table consultas(
		id bigint unsigned not null unique primary key,
        id_medico bigint unsigned not null,
        id_cliente bigint unsigned not null,
        agendamento datetime not null,
        valor decimal(10,2) not null,
        foreign key (id_medico) references medicos(id),
        foreign key (id_cliente) references clientes(id)
);

insert into planos 
	values (1, 'SUS'), 
	(2, 'São Camilo'), 
	(3, 'Unimed');

insert into especialidades
 values (1,'Psicólogo '), 
	(2,  'Psiquiatra'), 
	(3, 'Neurologista');
    
insert into medicos
	values(1, 1, 'Caio', '12345', '11111111111', '123456789', 'caio@gmail.com'),
    (2, 3, 'Gabriela', '1424', '2222222222','987654321', 'gabriela@gmail.com'),
     (3, 2, 'Poliana', '123123', '33333333333', '123123123','poliana@gmail.com');

insert into clientes 
	values (1, 1, 'Bruna', '12312312312', '1111', '999929292', 'bruna@gmail.com'),
	(2, 2, 'João', '43214321432', '2222', '987645632', 'joao@gmail.com'),
	(3, 3, 'Maria', '12121212121', '3333', '090987699', 'maria@gmail.com'),
	(4, 1, 'Vinícius', '17767753882', '4444', '987456382', 'vinicius@gmail.com');

insert into consultas
	values (1, 2, 1, '2021-09-08 10:20:00', 200),
	(2, 1, 1, '2021-09-10 11:30:00', 300),
	(3, 2, 3, '2021-10-13 20:00:00', 400),
	(4, 1, 1, '2021-09-15 10:00:00', 500),
	(5, 3, 3, '2021-10-17 14:00:00', 600),
	(6, 2, 3, '2021-10-19 10:30:00', 700),
	(7, 2, 4, '2021-11-21 21:20:00', 800),
	(8, 3, 1, '2021-11-23 11:00:00', 900);

select * from consultas where id_medico = 2 and agendamento >  '2021/10/01' and agendamento < '2021/11/01';

select * from consultas where id_medico=3;

select * from consultas 
	inner join clientes on consultas.id_cliente = clientes.id
	where id_plano = null;

select * from medicos
	inner join consultas on consultas.id_medico = medicos.id
	where id_cliente =1;