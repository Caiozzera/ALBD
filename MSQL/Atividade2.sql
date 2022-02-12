create database  transações;
use transações;

create table conta(
	id int unique not null auto_increment primary key,
    saldo decimal(14,2)
);

create table operacao(
	id int unique not null auto_increment primary key,
    id_conta int not null,
    tipo char (1) not null,
    data_operacao datetime not null,
    valor decimal(14,2),
    foreign key (id_conta) references conta(id)
);

start transaction;
insert into operacao values (null, C, 'S', now(), V);
update conta set saldo= (saldo-V) where id_conta = C;
if (( select saldo from conta where id_conta = C) > 0 )
	rollback;
else
	commit