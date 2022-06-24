unit Controller.Professor;

interface

uses
  DAO.Professor, Model.Professor;
Type
  TProfessorController = Class
    private
      FProfessorDAO: TProfessorDAO;

    public
      Constructor Create;
      destructor Destroy; override;

      procedure Salvar(AProfessor: TProfessor);
      procedure Consultar(AProfessor: TProfessor);
      procedure Excluir(AID_Professor: Integer);

  End;

implementation

uses
  DataModule, System.SysUtils, Model.Validacao, Vcl.Dialogs;

{ TProfesssorController }

procedure TProfessorController.Consultar(AProfessor: TProfessor);
begin
  FProfessorDAO.Consultar(AProfessor);
end;

constructor TProfessorController.Create;
begin
  FProfessorDAO := TProfessorDAO.Create(Conexao);
end;

destructor TProfessorController.Destroy;
begin
  FreeAndNil(FProfessorDAO);
  inherited;
end;

procedure TProfessorController.Excluir(AID_Professor: Integer);
begin
  Try
    FProfessorDAO.Excluir(AID_Professor);
    Conexao.Commit
  except
    raise Exception.Create('Erro ao excluir professor, por favor feche o sistema e tente novamente.');
    Conexao.Rollback;
  End;
end;

procedure TProfessorController.Salvar(AProfessor: TProfessor);
var
  IValidar: IValidacao;
begin
  IValidar := TValidar.Create;

  with AProfessor do
  begin
    //Verifica��o dos dados obrigat�rios do Professor
    if Nome = '' then
      raise Exception.Create('Nome n�o pode ser vazio');

    if Data_Nascimento = 0 then
      raise Exception.Create('Informe uma data v�lida');

    if (Not IValidar.ValidarEmail(Email)) and (Email <> '') then
      raise exception.Create('Email inv�lido.');

    if (Not IValidar.ValidarCPF(CPF)) and (CPF <> '') then
      raise exception.Create('CPF inv�lido.');

    Try
      //Cadastrar ou atualizar professor
      if ID_Professor = 0 then
      begin
        FProfessorDAO.Cadastrar(AProfessor);
        ShowMessage('Professor cadastrado com sucesso!');
      end
      else
      begin
        FProfessorDAO.Atualizar(AProfessor);
        ShowMessage('Professor Atualizado com sucesso!');
      end;

      Conexao.Commit;
    Except
      raise Exception.Create('Erro ao salvar professor, por favor feche o sistema e tente novamente.');
      Conexao.Rollback;
    End;
  end;
end;

end.
