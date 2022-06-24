unit Controller.Aluno;

interface

uses
  DAO.Aluno, Model.Aluno, System.Generics.Collections;
Type
  TAlunoController = Class
    private
      FAlunoDAO: TAlunoDAO;

    public
      Constructor Create;
      destructor Destroy; override;

      procedure Salvar(AAluno: TAluno);
      procedure Consultar(AAluno: TAluno);
      procedure Excluir(AID_Aluno: Integer);
      procedure Listar(AListaAluno: TObjectList<TAluno>; ANomeAluno: String);

  End;

implementation

uses
  DataModule, System.SysUtils, Model.Validacao;

{ TAlunoController }

procedure TAlunoController.Consultar(AAluno: TAluno);
begin
  FAlunoDAO.Consultar(AAluno);
end;

constructor TAlunoController.Create;
begin
  FAlunoDAO := TAlunoDAO.Create(Conexao);
end;

destructor TAlunoController.Destroy;
begin
  FreeAndNil(FAlunoDAO);
  inherited;
end;

procedure TAlunoController.Excluir(AID_Aluno: Integer);
begin
  Try
    FAlunoDAO.Excluir(AID_Aluno);

    Conexao.Commit
  except
    raise Exception.Create('Erro ao excluir aluno, por favor feche o sistema e tente novamente.');
    Conexao.Rollback;
  End;
end;

procedure TAlunoController.Listar(AListaAluno: TObjectList<TAluno>; ANomeAluno: String);
begin
  FAlunoDAO.Listar(AListaAluno, ANomeAluno);
end;

procedure TAlunoController.Salvar(AAluno: TAluno);
var
  IValidar: IValidacao;
begin
  IValidar := TValidar.Create;

  with AAluno do
  begin
    //Verificação dos dados obrigatórios do Aluno
    if Nome = '' then
      raise Exception.Create('Nome não pode ser vazio');

    if Data_Nascimento = 0 then
      raise Exception.Create('Informe uma data válida');

    if (Not IValidar.ValidarEmail(Email)) and (Email <> '') then
      raise exception.Create('Email inválido.');

    if (Not IValidar.ValidarCPF(CPF)) and (CPF <> '') then
      raise exception.Create('CPF inválido.');

    Try
      //Cadastrar ou Atualizar o Aluno
      if AAluno.ID_Aluno = 0 then
        FAlunoDAO.Cadastrar(AAluno)
      else
        FAlunoDAO.Atualizar(AAluno);

      Conexao.Commit;
    Except
      raise Exception.Create('Erro ao salvar Aluno, por favor feche o sistema e tente novamente.');
      Conexao.Rollback;
    End;
  end;
end;

end.
