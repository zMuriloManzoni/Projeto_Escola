unit DAO.Aluno;

interface

uses
  FireDAC.Comp.Client, Model.Aluno, System.Generics.Collections;
Type
  TAlunoDAO = Class
    private
      FConexao: TFDConnection;
      FQuery: TFDQuery;

    public
      Constructor Create(AConexao: TFDConnection);
      destructor Destroy; override;

      procedure Cadastrar(AAluno: TAluno);
      procedure Atualizar(AAluno: TAluno);
      procedure Consultar(AAluno: TAluno);
      procedure Excluir(AID_Aluno: Integer);
      procedure Listar(AListaAluno: TObjectList<TAluno>; ANomeAluno: String);

  End;

implementation

uses
  System.SysUtils, Vcl.Dialogs;

{ TAlunoDAO }

procedure TAlunoDAO.Atualizar(AAluno: TAluno);
begin
  with FQuery do
  begin
    SQL.Clear;
    SQL.Add('Update Alunos set');
    SQL.Add('Nome = :pNome,');
    SQL.Add('CPF = :pCPF,');
    SQL.Add('Sexo = :pSexo,');
    SQL.Add('Data_Nascimento = :pData_Nascimento,');
    SQL.Add('Email = :pEmail,');
    SQL.Add('Serie = :pSerie');
    SQL.Add('Where ID_Aluno = :pID_Aluno');

    with AAluno do
    begin
      ParamByName('pNome').AsString := Nome;
      ParamByName('pCPF').AsString := CPF;
      ParamByName('pSEXO').AsString := Sexo;
      ParamByName('pDATA_NASCIMENTO').AsDate := Data_Nascimento;
      ParamByName('pEMAIL').AsString := Email;
      ParamByName('pSERIE').AsString := Serie;

      ParamByName('pID_Aluno').AsInteger := ID_Aluno;
    end;

    ExecSQL;
  end;
end;

procedure TAlunoDAO.Cadastrar(AAluno: TAluno);
begin
  with FQuery do
  begin
    SQL.Clear;
    SQL.Add('Insert Into Alunos');
    SQL.Add('(Nome, CPF, SEXO, DATA_NASCIMENTO, EMAIL, SERIE, Excluido)');
    SQL.Add('Values');
    SQL.Add('(:pNome, :pCPF, :pSEXO, :pDATA_NASCIMENTO, :pEMAIL, :pSERIE, False)');

    with AAluno do
    begin
      ParamByName('pNome').AsString := Nome;
      ParamByName('pCPF').AsString := CPF;
      ParamByName('pSEXO').AsString := Sexo;
      ParamByName('pDATA_NASCIMENTO').AsDate := Data_Nascimento;
      ParamByName('pEMAIL').AsString := Email;
      ParamByName('pSERIE').AsString := Serie;
    end;

    ExecSQL;
  end;
end;

procedure TAlunoDAO.Consultar(AAluno: TAluno);
begin
  with Fquery do
  begin
    SQL.Clear;
    SQL.Add('Select * from Alunos');
    SQL.Add('Where (ID_aluno = :pID_Aluno) and (Excluido = False)');

    ParamByName('pID_Aluno').AsInteger := AAluno.ID_Aluno;

    Open;

    with AAluno do
    begin
      Nome := FieldByName('Nome').AsString;
      CPF := FieldByName('CPF').AsString;
      Sexo := FieldByName('SEXO').AsString;
      Data_Nascimento := FieldByName('DATA_NASCIMENTO').AsDateTime;
      Email := FieldByName('EMAIL').AsString;
      Serie := FieldByName('SERIE').AsString;
    end;
  end;
end;

constructor TAlunoDAO.Create(AConexao: TFDConnection);
begin
  FConexao := AConexao;
  FConexao.Connected := True;

  FQuery := TFDQuery.Create(Nil);
  FQuery.Connection := FConexao;
end;

destructor TAlunoDAO.Destroy;
begin
  FreeAndNil(FQuery);
  inherited;
end;

procedure TAlunoDAO.Excluir(AID_Aluno: Integer);
begin
  with FQuery do
  begin
    SQL.Clear;
    SQL.Add('Update Alunos set');
    SQL.Add('Excluido = True');
    SQL.Add('Where ID_Aluno = :pID_Aluno');

    ParamByName('pID_Aluno').AsInteger := AID_Aluno;

    ExecSQL;
  end;
end;

procedure TAlunoDAO.Listar(AListaAluno: TObjectList<TAluno>;
  ANomeAluno: String);
var
  TempAluno: TAluno;
begin
  with FQuery do
  begin
    SQL.Clear;
    SQL.Add('Select First 8 * from Alunos');
    SQL.Add('Where (Nome CONTAINING  ' + QuotedStr(ANomeAluno) + ') and (Excluido = False)');

    Open;

    while Not Eof do
    begin
      TempAluno := TAluno.Create;

      with TempAluno do
      begin
        ID_Aluno := FieldByName('ID_Aluno').AsInteger;
        Nome := FieldByName('Nome').AsString;
        CPF := FieldByName('CPF').AsString;
        Sexo := FieldByName('SEXO').AsString;
        Data_Nascimento := FieldByName('Data_Nascimento').AsDateTime;
        Email := FieldByName('Email').AsString;
        Serie := FieldByName('Serie').AsString;

        AListaAluno.Add(TempAluno);
      end;

      Next;
    end;
  end;
end;

end.
