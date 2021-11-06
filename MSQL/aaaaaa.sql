create database Atividade007;
use Atividade007;

create table proprietario(
	id int unique not null auto_increment primary key,
    id_municipio int not null,
    nome varchar(100) not null,
    cpf char(11) not null,
    data_nasc date not null,
    sexo char(1) not null,
    bairro varchar(100) not null,
    cnh char(11) not null,
    pontuacao int not null,
    foreign key (id_municipio) references municipio(id)
);
create table municipio (
	id int unique not null auto_increment primary key,
    id_uf int not null,
	nome varchar(100) not null,
	foreign key (id_uf) references uf(id)
);
create table uf (
	id int unique not null auto_increment primary key,
	sigla char(2) not null,
	nome varchar(100) not null
);
create table veiculos(
	id int unique not null auto_increment primary key,
    id_proprietarios int not null,
	id_modelo int not null,
    placa char(7) not null,
    renavan char (9) not null,
    situacao char (1) not null,
    foreign key (id_proprietarios) references  proprietario(id),
	foreign key (id_modelo) references modelo(id)
);
create table modelo(
	id int unique not null auto_increment primary key,
	id_categoria int not null,
	descricao varchar(100) not null,
    foreign key (id_categoria) references categoria(id)
);
create table categoria (
	id int unique not null auto_increment primary key,
	descricao varchar(100) not null
);
create table local_infracao(
	id  int unique not null auto_increment primary key,
	id_municipio int not null,
    descricao varchar(100) not null,
	velocidade_permitida float not null,
	foreign key (id_municipio) references municipio(id)
);

create table infracao (
	id int unique not null auto_increment primary key,
	id_agente int not null,
    id_tipo_infracao int not null,
	id_local_infracao int not null,
	id_veiculo int not null,
    data_infracao datetime not null,
	foreign key (id_agente) references agente(id),
    foreign key (id_tipo_infracao) references tipo_infracao(id),
	foreign key (id_local_infracao) references local_infracao(id),
	foreign key (id_veiculo) references veiculos(id)
);

create table agente (
	id int unique not null auto_increment primary key,
	nome varchar (100) not null,
    data_contratacao date not null
);
create table tipo_infracao(
	id int unique not null auto_increment primary key,
	id_gravidade int not null,
    codigo varchar(100) not null,
    descricao varchar (225) not null,
    valor decimal (8,2) not null,
	foreign key (id_gravidade) references gravidade(id)
);
create table gravidade (
	id int unique not null auto_increment primary key,
	descricao varchar (225) not null,
    pontos int
);


create database if not exists veiculos;
use veiculos;

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
)

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

--1--
select categoria.descricao as categoria, modelo.descricao as modelo from categoria
inner join modelo on categoria.id = modelo.id_categoria
inner join veiculo on modelo.id = veiculo.id_modelo
inner join infracao on veiculo.id = infracao.id_veiculo
group by categoria, modelo

--2--
select modelo.descricao as modelo from modelo
inner join veiculo on modelo.id = veiculo.id_modelo
inner join infracao on veiculo.id = infracao.id_veiculo
inner join tipo_infracao on tipo_infracao.id = infracao.id_tipo_infracao
where valor < 200
group by modelo

--3--
select proprietario.nome, count(infracao.id) as infracoes from proprietario 
inner join veiculo on proprietario.id = veiculo.id_proprietario
inner join infracao on veiculo.id = infracao.id_veiculo
group by proprietario.nome

--4--
delete from infracao where id_agente in (select id from agente where data_contratacao <= '2016/10/13')

--5-- 
select municipio.nome as municipio, gravidade.nome as infracao from municipio
inner join local_infracao on municipio.id = local_infracao.id_municipio
inner join infracao on local_infracao.id = infracao.id_local_infracao
inner join tipo_infracao on tipo_infracao.id = tipo_infracao.id
inner join gravidade on gravidade.id = tipo_infracao.id_gravidade
where gravidade.nome = 'gravissima'

--6--
select municipio.nome as municipio, sum(tipo_infracao.valor) as total from municipio
inner join local_infracao on municipio.id = local_infracao.id_municipio
inner join infracao on local_infracao.id = infracao.id_local_infracao
inner join tipo_infracao on tipo_infracao.id = tipo_infracao.id
where tipo_infracao.valor > 200


select agente.nome as agente, sum(tipo_infracao.valor) as valor from agente
inner join infracao on infracao.id_agente = agente.id
inner join tipo_infracao on tipo_infracao.id = infracao.id_tipo_infracao 
group by agente.nome
order by sum(tipo_infracao.valor) desc
limit 1

