create table Aluno(
	Nome varchar(15) NOT NULL,
	RA int,
	Idade int NOT NULL,
	DataNasc date,
	constraint pkAluno primary key (RA)
);

create table Professor(
	Nome varchar(15) NOT NULL,
	NFunc int,
	Idade int NOT NULL,
	Titulacao varchar(15),
	constraint pkProfessor primary key (NFunc)
);

create table Disciplina(
	Sigla char(5),
	Nome varchar(30) NOT NULL,
	NCred int,
	Professor int,
	Livro varchar(15),
	constraint pkDisciplina primary key (Sigla),
	constraint fkNProf foreign key (Professor) references Professor(NFunc)
);

create table Turma(
	sigla char(5),
	numero int,
	NAlunos int,
	constraint pkTurma primary key(sigla, numero)
);

create table Matricula(
	sigla char(5),
	numero int,
	Aluno varchar(15),
	Ano int,
	Nota float,
	constraint pkMatricula primary key(sigla, numero, Aluno, Ano),
	constraint fkTurma foreign key(sigla, numero) references Turma(sigla, numero)
	on delete cascade
	on update cascade
);

alter table Aluno add cidade varchar(45);
alter table Matricula add constraint ckNota check(nota>=0);
alter table Disciplina drop constraint fkNProf cascade;
alter table Aluno alter cidade set default 'Cornelio';
drop table Professor cascade;

create domain DomFreq as int

alter table Matricula add frequencia DomFreq;

create assertion ProfDoutor
check((select count(Titulacao) from Professor) = 'doutorado')

--A restrição de tabela equivalente a asserção seria:
--constraint pkTitulo primary key(Titulacao),
--check ((select count(Titulacao) from Professor) = 'doutorado')
--A asserção seria uma melhor opção pois não estaria
--diretamente associada a Professor, facilitando alterações

insert into Aluno(Nome, RA, datanasc, idade, cidade)
	values('Juliana', 222, '1989-04-10', 33, 'Londrina');

insert into Disciplina(Sigla, Nome, NCred)
	values('IF65B', 'Banco de Dados 2', 4);
	
insert into Matricula(Aluno, sigla, numero)
	values('Juliana', 'IF65B', 1);

create table Alunos_menores(
	Nome varchar(15) NOT NULL,
	RA int,
	Idade int NOT NULL,
	DataNasc date,
	cidade varchar(45),
	constraint pkAlunomenor primary key (RA)
);	


insert into Alunos_menores(Nome, RA, datanasc, idade, cidade)
	SELECT Nome, Ra, datanasc, idade, cidade FROM Aluno WHERE idade<18;
	
	
update matricula 
	set frequencia='70'
		where nota>'5' and frequencia<'70';
		 
delete from matricula where sigla='IF65B' and numero ='2'
delete from disciplina where NCred >'6'


