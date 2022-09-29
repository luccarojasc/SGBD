create table Fornecedor(
	Fcodigo int NOT NULL,
	Fnome varchar(15) NOT NULL,
	Fcidade varchar(20),
	constraint pkFornecedor primary key (Fcodigo)
);
create table Peca(
	Pcodigo int NOT NULL,
	Pnome varchar(15) NOT NULL,
	Pdescricao varchar(50) NOT NULL,
	constraint pkPeca primary key (PCodigo)
);
create table Venda(
	codForn int NOT NULL,
	codPeca int NOT NULL,
	Vquantidade int,
	Vdata date,
	constraint fkFcodigo foreign key (codForn) references Fornecedor(Fcodigo),
	constraint fkPcodigo foreign key (codPeca) references Peca(Pcodigo)
);

alter table Venda add constraint ckQuant check (Vquantidade>'0');

--O código acima é da Aula 2 e será usado como base para os exercícios propostos 
--nos slides da Aula 4.
--Ex 1 e 2:
create user USER1;
create user USER2;
grant insert (Fcodigo, Fnome) on Fornecedor to USER1 with grant option;
grant select on Fornecedor, Peca to USER1;

--Ex 3 e 4:
--Conectado como USER1:

insert into Fornecedor(FCodigo, Fnome)
	values('298154', 'Joao');
select ALL from Fornecedor;
select ALL from Peca;

grant insert (Fcodigo, Fnome) on Fornecedor to USER2;
grant select on Fornecedor, Peca to USER2;

--Ex 5:
--Conectado como USER2:

insert into Fornecedor(FCodigo, Fnome)
	values('471928', 'Fabiana');
select ALL from Fornecedor;
select ALL from Peca;

--Ex 6:

revoke insert(Fcodigo, Fnome) on fornecedor from USER1;
revoke select on Fornecedor, Peca from USER1;

--Ex 7:
-- Caso tente refazer os testes utilizando USER1 e USER2,
-- em nenhum dos 2 usuários seria obtido sucesso.
-- No USER1 pois foi utilizado o comando "revoke" para
-- retirar suas permissões, e no USER2 pois suas permissões
-- foram concedidas pelo USER1 a partir do comando
--"with grant option", então ao serem revogadas as 
--permissões do USER1, as do USER2 tambem seriam revogadas.
