create table Fornecedor(
	Fcodigo int NOT NULL,
	Fnome varchar(15) NOT NULL,
	Fcidade varchar(20) not null,
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

alter table Venda add constraint ckQuant check quantidade>0
