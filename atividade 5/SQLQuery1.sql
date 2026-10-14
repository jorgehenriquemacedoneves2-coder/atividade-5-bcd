use Doisem_db;

select * from aluno;

exec sp_help aluno;

alter procedure adicionar_usuario
@id int,
@nome varchar(50),
@nascimento date,
@cpf varchar(15),
@Registro_escolar varchar(10),
@cidade varchar(50
as
begin
	insert into aluno(id, nome, nascimento, cpf, Registro_escolar, cidade)
	values
	(@id, @nome, @nascimento, @cpf, @Registro_escolar, @cidade);
	end;

	exec adicionar_usuario 5, 'Ronaldo', '2026-05-14', '1222333334', '67453451', 'Marilia');

	select * from aluno;

	create functiom calcular_idade (@data-nascimento date)
	returns int 
	as
	begin
		return datediff(year @data_nascimento, getdate()) -
		case
			when month (@data_nascimento) > month(getdate())
			or (month(@data_nascimento) = month(getdate()) and day(@data_nascimento) > day(getdate()))
			then 1
			else 0
		end;
	end;

	select
		nome,
		dbo.calcular_idade(nascimento) as idade
		from aluno
		order by nome asc;




