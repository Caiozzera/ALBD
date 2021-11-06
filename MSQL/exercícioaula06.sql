create database ExercícioAula06;
use ExercícioAula06;

create table semestre (
	id int unique not null auto_increment primary key,
    descrisao varchar(100) not null,  
    data_inicio date not null,
    data_termino date not null
);
create table curso(
	id int unique not null auto_increment primary key,
	nome varchar (100) not null
    );

create table disciplinas(
	id int unique not null auto_increment primary key,
	id_curso int not null,
    nome varchar(100) not null,
    foreign key (id_curso) references curso(id)
);
create table turma(
	id int unique not null auto_increment primary key,
	id_disciplinas int not null,
    id_semestre int not null,
	descricao varchar (100) not null,
    foreign key (id_disciplinas) references disciplinas(id),
    foreign key (id_semestre) references semestre(id)
);

create table aluno(
	id int unique not null auto_increment primary key,
    nome varchar (100) not null,
    endereco varchar(100) not null,
    email varchar(200) not null,
    situacao char(1) not null
);
    
create table matricula(
	id int unique not null auto_increment primary key,
	id_aluno int not null,
	id_turma int not null,
	foreign key (id_aluno) references aluno(id),
	foreign key (id_turma) references turma(id)
 );

 #Escreva o script SQL para popular todas as tabelas do banco criado com dados fictícios.
insert into curso values ( 1, 'Jovem Programador'), ( 2, 'Técnico em Administração'), ( 3, 'Auxiliar Administrativo Flexível');

insert into disciplinas values(1, 1, 'Banco de Dados' ), (2, 2, 'Auxiliar na Execução de Atividades Relacionadas a Operaçoes Logisticas em Organizações' ), (3, 3, 'Funções Excel' );
 
insert into semestre values(1, 'Semestre1', '2021-02-01', '2021-06-19'), (2, 'Semestre2', '2021-06-19', '2021-12-10');
 
insert into turma values ('1', null, 'AAF'), (2, null, 'TA'), (3,null, 'JP');

insert into aluno 
values ( '1', 1,'1','José', '012234','10203040','Concórdia', 'jose@gmail.com', 'situação pendente'), ( '2', 2,'2','Pedro', '111111','12345678','Concórdia', null , 'Inativo');
 
 insert into matricula 
 
--Escreva o script SQL para alterar a situação de todos os alunos que estão sem e-mail cadastrado para "situação pendente".
 update aluno set situacao = 'p' where email is null
 
--Escreva o script SQL para listar o nome de cada disciplina oferecida pela universidade e a quantidade de alunos matriculados no semestre 2012‐01.
 
 select d.nome count(m.id_aluno) as total_alunos
 from disciplinas as d 
 inner join turma as t on t.id_disciplinas = d.id
 inner join semestre as s on s.id = t.id_semestre
 inner join matricula as m on id_turma = t.id
 where s.descrisao = 'semestre 2012‐01.'
 group by s.id 
 
--Escreva o script SQL para listar a descrição de todos os semestres e a quantidade de alunos matriculados.
select s.descrisao, count(m.id) as total_alunos
from semestre as s 
inner join turma as t on t.id_semestre = s.id
inner join matricula as m on m.id_turma = t.id
group by s.descrisao 
 
--Escreva o script SQL para listar o nome das disciplinas que tiveram mais de uma turma oferecida em um mesmo semestre.
select
 d.nome
from disciplinas as d
inner join turmas as t om t.id_disciplina = d.id
inner join semestre as s on s.id = t.id_semestre
group by d.nome
having count(t.id) > 1

 
 
 
    
 