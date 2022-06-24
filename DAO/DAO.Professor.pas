unit DAO.Professor;

interface

uses
  FireDAC.Comp.Client, Model.Professor;
Type
  TProfessorDAO = Class
    private
      FConexao: TFDConnection;
      FQuery: TFDQuery;

    public
      Constructor Create(AConexao: TFDConnection);
      destructor Destroy; override;

      procedure Cadastrar(AProfessor: TProfessor);
      procedure Atualizar(AProfessor: TProfessor);
      procedure Consultar(AProfessor: TProfessor);
      procedure Excluir(AID_Professor: Integer);
  End;

implementation

uses
  System.SysUtils;

{ TProfessorDAO }

procedure TProfessorDAO.Atualizar(AProfessor: TProfessor);
begin
  with FQuery do
  begin
    SQL.Clear;
    SQL.Add('Update Professores set');
    SQL.Add('Nome = :pNome,');
    SQL.Add('CPF = :pCPF,');
    SQL.Add('SEXO = :pSEXO,');
    SQL.Add('DATA_NASCIMENTO = :pDATA_NASCIMENTO,');
    SQL.Add('Email = :pEmail,');
    SQL.Add('DISCIPLINA = :pDISCIPLINA');
    SQL.Add('Where ID_Professor = :pID_Professor');

    with AProfessor do
    begin
      ParamByName('pNome').AsString := Nome;
      ParamByName('pCPF').AsString := CPF;
      ParamByName('pSEXO').AsString := Sexo;
      ParamByName('pDATA_Nascimento').AsDate := Data_Nascimento;
      ParamByName('pEmail').AsString := Email;
      ParamByName('pDisciplina').AsString := Disciplina;

      ParamByName('pID_Professor').AsInteger := ID_Professor;
    end;

    ExecSQL;
  end;
end;

procedure TProfessorDAO.Cadastrar(AProfessor: TProfessor);
begin
  with FQuery do
  begin
    SQL.Clear;
    SQL.Add('Insert Into Professores');
    SQL.Add('(Nome, CPF, SEXO, DATA_Nascimento, Email, Disciplina, Excluido)');
    SQL.Add('Values');
    SQL.Add('(:pNome, :pCPF, :pSEXO, :pDATA_Nascimento, :pEmail, :pDisciplina, False)');
    SQL.Add('Returning ID_Professor');

    with AProfessor do
    begin
      ParamByName('pNome').AsString := Nome;
      ParamByName('pCPF').AsString := CPF;
      ParamByName('pSEXO').AsString := Sexo;
      ParamByName('pDATA_Nascimento').AsDate := Data_Nascimento;
      ParamByName('pEmail').AsString := Email;
      ParamByName('pDisciplina').AsString := Disciplina;
    end;

    Open;

    AProfessor.ID_Professor := FieldByName('ID_Professor').AsInteger;
  end;
end;

procedure TProfessorDAO.Consultar(AProfessor: TProfessor);
begin
  with FQuery do
  begin
    SQL.Clear;
    SQL.Add('Select * from Professores');
    SQL.Add('Where (ID_Professor = :pID_Professor) and (Excluido = False)');

    with AProfessor do
    begin
      ParamByName('pID_Professor').AsInteger := ID_Professor;

      Open;

      Nome := FieldByName('Nome').AsString;
      CPF := FieldByName('CPF').AsString;
      Sexo := FieldByName('SEXO').AsString;
      Data_Nascimento := FieldByName('DATA_NASCIMENTO').AsDateTime;
      Email := FieldByName('EMAIL').AsString;
      Disciplina := FieldByName('DISCIPLINA').AsString;
    end;

  end;
end;

constructor TProfessorDAO.Create(AConexao: TFDConnection);
begin
  FConexao := AConexao;
  FConexao.Connected := True;

  FQuery := TFDQuery.Create(Nil);
  FQuery.Connection := FConexao;
end;

destructor TProfessorDAO.Destroy;
begin
  FreeAndNil(FQuery);
  inherited;
end;

procedure TProfessorDAO.Excluir(AID_Professor: Integer);
begin
  with FQuery do
  begin
    SQL.Clear;
    SQL.Add('Update Professores set');
    SQL.Add('Excluido = True');
    SQL.Add('Where ID_Professor = :pID_Professor');

    ParamByName('pID_Professor').AsInteger := AID_Professor;

    ExecSQL;
  end;
end;

end.
