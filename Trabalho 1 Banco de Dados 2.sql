drop TABLE peça;
create table peça(
	PeNro int NOT NULL,
	PeNome varchar(30) NOT NULL,
	PePreço NUMERIC(10,2),
	PeCor varchar(10),
	constraint pkPeça primary key (PeNro)
);

create table fornecedor(
	FNro int NOT NULL,
	FNome varchar(30) NOT NULL,
	FCidade varchar(30),
	FCateg	varchar(10),
	constraint pkFornecedor primary key (FNro)
);
drop table grupo_pesquisa;
create table grupo_pesquisa(
	GNro int NOT NULL,
	GNome varchar(30) NOT NULL,
	constraint pkGrupo_pesquisa primary key(GNro)
);
drop table projeto;
create table projeto(
	PNro int NOT NULL,
	PNome varchar(30) NOT NULL,
	PDuração int, 
	PCusto numeric(10,2),
	GNro integer,
	constraint pkProjeto Primary Key(PNro)
);
Alter table projeto add Constraint fkProjeto Foreign Key (GNro)
	references grupo_pesquisa(GNro) 
	on update cascade
	on delete set null;
	
/*(Ex2)Para a criação das chaves extrangeiras, foi utilizado o comando "cascade" para o "on update",ou seja,
ao atualizar algo na tabela principal a mesma alteração seria feita na secundária. Para o caso "on delete",
da tabela ser excluida, foi atribuído "set null".*/

drop table fornece_para;
create table fornece_para(
	PeNro integer, 
	FNro integer,
	PNro integer,
	Quant int,
	constraint pkFornece_para primary key (PeNro, FNro, PNro)
);

alter table fornece_para add constraint fkFornece_para1 Foreign Key (PeNro)
	references peça(PeNro)
	on update cascade
	on delete set null;
	
alter table fornece_para add constraint fkFornece_para2 Foreign Key (FNro)
	references fornecedor(FNro)
	on update cascade
	on delete set null;

alter table fornece_para add constraint fkFornece_para3 Foreign Key (PNro)
	references projeto(PNro)
	on update cascade
	on delete set null;
	
/*A tabela FORNECE_PARA recebe a identificação do projeto, peça e fornecedor então é necessario que quando eles são atualizados
na suas tabelas eles tambem sejam mudados na tabela FORNECE_PARA, pois é mudado com muita frequencia e no caso de ser deletada são deixadas nulas.*/

	
drop table empregado;
create table empregado(
 	ENro int NOT NULL,
	ENome varchar(30) NOT NULL,
	ENascimento date,
	ESalario numeric(10,2),
	PNro integer,
	constraint pkEmpregado primary key(ENro)

);

Alter table empregado add constraint fkEmpregado foreign key(PNro)
	references projeto(PNro) 
	on update set null
	on delete cascade;

/*No caso da identificação do projeto(GNro) ser mudada é necessario a identificação que o empregado trabalha seja anulada caso tenha grandes mudanças
no projeto e é necessario mudala diretamente. E no caso do projeto ser deletado o envolvimento do empregado tambem seria deletado.*/
	
/*3.
R: Quando um grupo de pesquisa for apagado o mesmo GNro Armazenado em projeto 
que for igual á um apagado sera deletado.
	Quando o Fnro for atualizado na tabela fornecedor ele tambem sera atualizado
na tabela FORNECE_PARA aonde ele é  uma foreign key.*/

CREATE DOMAIN PeCor as varchar(45)
constraint checar_cores
CHECK (VALUE in('Vermelho','Verde','Azul'));

CREATE DOMAIN PDuracao as integer
constraint tempo_min_projeto_meses
CHECK (VALUE >=2);

CREATE DOMAIN PCusto as numeric(5,2)
constraint valor_min
CHECK (VALUE is not NULL);

Insert into Peça 
Values(1,'Motor',400.99,'Azul');

Insert into Peça 
Values(2,'Chassis',999.99,'Azul');

Insert into Peça 
Values(3,'Base do piloto',800.50,'Vermelho');

Insert into Peça 
Values(4,'Interior dos tripulantes',1000.75,'Verde');

Insert into Fornecedor 
Values(1,'Jeff','São Paulo','Equipamentos de naves');

Insert into Fornecedor 
Values(2,'Godofredo','New York','Equipamentos de interiores');

Insert into Fornecedor 
Values(3,'Zaques','Tokyo','Equipamentos militares');

Insert into Fornecedor  
Values(4,'Paulo','Paris','Decorações');

Insert into grupo_pesquisa 
Values(1,'Enterprise expertos');

Insert into grupo_pesquisa 
Values(2,'Enterprise 1');

Insert into grupo_pesquisa 
Values(3,'Enterprise Novatos');

Insert into grupo_pesquisa  
Values(4,'Enterprise Trainees');

Insert into Projeto 
Values(1,'Enterprise 5000',12,10000.50,1);

Insert into Projeto 
Values(2,'Enterprise 300',1,5000.70,3);

Insert into Projeto 
Values(3,'Federation Comerce',4,4000.50,4);

Insert into Projeto 
Values(4,'Enterprise 1000',8,7500.50,2);
	   
	   
Insert into fornece_para 
Values(1,1,2,50);

Insert into fornece_para 
Values(2,3,4,32);

Insert into fornece_para 
Values(3,4,2,12);

Insert into fornece_para 
Values(4,2,3,100);

Insert into empregado 
Values(1,'Kirk',3/2/45,1000.20,2);

Insert into empregado 
Values(2,'Spock',5/9/12,5000.20,1);

Insert into empregado 
Values(3,'Zulu',7/12/39,700.98,4);

Insert into empregado 
Values(4,'Uhura',5/8/42,800.70,3);

--EXERCICIO 6A
CREATE USER Kirk WITH PASSWORD '123';
CREATE USER Spock WITH PASSWORD '333';
CREATE USER Uhura WITH PASSWORD '456';
CREATE USER McCoy WITH PASSWORD '222';

--EXERCICIO 6B
GRANT INSERT, DELETE on empregado to Spock;

--EXERCICIO 6C
GRANT SELECT on projeto to Uhura WITH Grant Option;

-- EXERCICIO 6D
GRANT CREATE ON SCHEMA StarTrek TO Kirk;

-- EXERCICIO 6E
REVOKE DELETE ON empregado FROM Spock;

-- EXERCICIO 6F
GRANT UPDATE (PDuração, PCusto) on projeto to Spock;

-- EXERCICIO 6G
ALTER USER McCoy RENAME TO Zulu;

-- EXERCICIO 6H
GRANT SELECT (FNome) ON fornecedor TO Spock;
GRANT SELECT (ENome) ON empregado TO Spock;

-- EXERCICIO 6I
GRANT SELECT to Zulu with grant option;

-- EXERCICIO 6J
REVOKE SELECT on projeto from Uhura
Cascade;

-- EXERCICIO 6K
DROP USER Zulu;

-- EXERCICIO 6L
GRANT SELECT (PeCor, 'Vermelho') on peça to Uhura;