create database if not exists aula9;
use aula9;

create table uf(
	id int unique not null primary key,
    sigla char(2) not null,
    nome varchar(100) not null
);

create table municipio(
	id int unique not null primary key,
    id_uf int not null,
    nome varchar(100) not null,
    foreign key (id_uf) references uf(id)
);

create table local_infracao(
	id int unique not null primary key,
    id_municipio int not null,
    descricao varchar(100) not null,
    velocidade_permitida float not null,
    foreign key (id_municipio) references municipio(id)
);

create table proprietario(
	id int unique not null primary key,
    id_municipio int not null,
    nome varchar(100) not null,
    cpf char(11) not null,
    data_nasc date not null,
    sexo char(1) not null,
    endereco varchar(100) not null,
    bairro varchar(100) not null,
    cnh char(11) not null,
    pontuacao int not null,
    foreign key (id_municipio) references municipio(id)
);

create table gravidade(
	id int unique not null primary key,
    nome varchar(100) not null,
    pontos int not null
);

create table tipo_infracao(
	id int unique not null primary key,
    id_gravidade int not null,
    codigo varchar(10) not null,
    descricao varchar(255) not null,
    valor decimal(8,2) not null,
    foreign key (id_gravidade) references gravidade(id)
);

create table agente(
	id int unique not null primary key,
    nome varchar(100) not null,
    data_contratacao date not null
);

create table categoria(
	id int unique not null primary key,
    descricao varchar(100) not null
);

create table modelo(
	id int unique not null primary key,
    id_categoria int not null,
    descricao varchar(100) not null,
    foreign key (id_categoria) references categoria(id)
);

create table veiculo(
	id int unique not null primary key,
    id_proprietario int not null,
    id_modelo int not null,
    placa char(7) not null,
    renavam char(9) not null,
    situacao char(1) not null,
    foreign key (id_proprietario) references proprietario(id),
    foreign key (id_modelo) references modelo(id)
);

create table infracao(
	id int unique not null primary key,
    id_agente int not null,
    id_tipo_infracao int not null,
    id_local_infracao int not null,
    id_veiculo int not null,
    data_infracao date not null,
    foreign key (id_agente) references agente(id),
    foreign key (id_tipo_infracao) references tipo_infracao(id),
    foreign key (id_local_infracao) references local_infracao(id),
    foreign key (id_veiculo) references veiculo(id)
);

--A--total de infrações de cada veículo cadastrado;
select veiculo.id as id_veiculo, count(infracao.id) as id_infracao
 from veiculo
inner join infracao on infracao.id_veiculo = veiculo.id
group by veiculo.id
 
--B--
select proprietario.nome,count(gravidade.pontos) as total_pontos
 from proprietario
inner join veiculo on veiculo.id_proprietario = proprietario.id
inner join infracao on infracao.id_veiculo = veiculo.id
inner join tipo_infracao on tipo_infracao.id = infracao.id_tipo_infracao
inner join gravidade on gravidade.id = tipo_infracao.id_gravidade

--C--
select modelo.descricao as modelo, veiculo.id as id_veiculo 
from veiculo
inner join modelo on modelo.id = veiculo.id_modelo








