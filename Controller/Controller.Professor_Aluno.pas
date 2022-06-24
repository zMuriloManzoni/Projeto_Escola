unit Controller.Professor_Aluno;

interface

uses
  DAO.Professor_Aluno, Model.Professor_Aluno, System.Generics.Collections;
Type
  TProfessor_AlunoController = Class
    private
      FProfessor_AlunoDAO: TProfessor_AlunoDAO;

    public
      Constructor Create;
      destructor Destroy; override;

      function Salvar(AProfessor_Aluno: TProfessor_Aluno): Boolean;
      procedure Listar(AListaProfessor_Aluno: TObjectList<TProfessor_Aluno>; AID_Professor: Integer);
      procedure Excluir(AID_Professor_Aluno: Integer);
  End;

implementation

uses
  DataModule, System.SysUtils;

{ TProfessor_Aluno_Controller }

constructor TProfessor_AlunoController.Create;
begin
  FProfessor_AlunoDAO := TProfessor_AlunoDAO.Create(Conexao);
end;

destructor TProfessor_AlunoController.Destroy;
begin
  FreeAndNil(FProfessor_AlunoDAO);
  inherited;
end;

procedure TProfessor_AlunoController.Excluir(AID_Professor_Aluno: Integer);
begin
  Try
    FProfessor_AlunoDAO.Excluir(AID_Professor_Aluno);
    Conexao.Commit;
  Except
    Conexao.Rollback;
    raise Exception.Create('Erro ao excluir aluno do professor, por favor feche o sistema e tente novamente.');
  End;
end;

procedure TProfessor_AlunoController.Listar(
  AListaProfessor_Aluno: TObjectList<TProfessor_Aluno>; AID_Professor: Integer);
begin
  FProfessor_AlunoDAO.Listar(AListaProfessor_Aluno , AID_Professor)
end;

function TProfessor_AlunoController.Salvar(AProfessor_Aluno: TProfessor_Aluno): Boolean;
begin
  with AProfessor_Aluno do
  begin
    //Verificação dos dados obrigatórios do Aluno do Professor
    if Professor.ID_Professor = 0 then
      raise Exception.Create('Primeiro é necessario cadastrar o professor.');

    if Aluno.ID_Aluno = 0 then
      raise Exception.Create('Informe um Aluno.');

    if Nota_1_Bimestre = -1 then
      raise Exception.Create('Nota do 1º Bimestre inválida.');

    if Nota_2_Bimestre = -1 then
      raise Exception.Create('Nota do 2º Bimestre inválida.');

    if Nota_3_Bimestre = -1 then
      raise Exception.Create('Nota do 3º Bimestre inválida.');

    if Nota_4_Bimestre = -1 then
      raise Exception.Create('Nota do 4º Bimestre inválida.');

    if Ano = '' then
      raise Exception.Create('Ano inválido.');
  end;

  Try
    //Cadastrar ou Atualizar o Aluno do professor
    if AProfessor_Aluno.ID_Professor_Aluno = 0 then
      FProfessor_AlunoDAO.Cadastrar(AProfessor_Aluno)
    else
      FProfessor_AlunoDAO.Atualizar(AProfessor_Aluno);

    Conexao.Commit;
    Result := True;
  Except
    raise Exception.Create('Erro ao cadastrar Aluno do professor, por favor feche o sistema e tente novamente.');
    Conexao.Rollback;
    Result := False;
  End;
end;

end.
