unit DAO.Professor_Aluno;

interface

uses
  FireDAC.Comp.Client, Model.Professor_Aluno, System.Generics.Collections;
Type
  TProfessor_AlunoDAO = Class
    private
      FConexao: TFDConnection;
      FQuery: TFDQuery;

    public
      Constructor Create(AConexao: TFDConnection);
      destructor Destroy; override;

      procedure Cadastrar(AProfessor_Aluno: TProfessor_Aluno);
      procedure Atualizar(AProfessor_Aluno: TProfessor_Aluno);
      procedure Listar(AListaProfessor_Aluno: TObjectList<TProfessor_Aluno>; AID_Professor: Integer);
      procedure Excluir(AID_Professor_Aluno: Integer);

  End;

implementation

uses
  System.SysUtils, Vcl.Dialogs;

{ TProfessor_AlunoDAO }

procedure TProfessor_AlunoDAO.Atualizar(AProfessor_Aluno: TProfessor_Aluno);
begin
  with FQuery do
  begin
    SQL.Clear;
    SQL.Add('Update Professor_Aluno set');
    SQL.Add('ID_PROFESSOR = :pID_PROFESSOR,');
    SQL.Add('ID_ALUNO = :pID_ALUNO,');
    SQL.Add('ANO = :pANO,');
    SQL.Add('NOTA_1_BIMESTRE = :pNOTA_1_BIMESTRE,');
    SQL.Add('NOTA_2_BIMESTRE = :pNOTA_2_BIMESTRE,');
    SQL.Add('NOTA_3_BIMESTRE = :pNOTA_3_BIMESTRE,');
    SQL.Add('NOTA_4_BIMESTRE = :pNOTA_4_BIMESTRE');
    SQL.Add('Where ID_PROFESSOR_ALUNO = :pID_PROFESSOR_ALUNO');

    with AProfessor_Aluno do
    begin
      ParamByName('pID_PROFESSOR').AsInteger := Professor.ID_Professor;
      ParamByName('pID_ALUNO').AsInteger := Aluno.ID_Aluno;
      ParamByName('pANO').AsString := Ano;
      ParamByName('pNOTA_1_BIMESTRE').AsCurrency := Nota_1_Bimestre;
      ParamByName('pNOTA_2_BIMESTRE').AsCurrency := Nota_2_Bimestre;
      ParamByName('pNOTA_3_BIMESTRE').AsCurrency := Nota_3_Bimestre;
      ParamByName('pNOTA_4_BIMESTRE').AsCurrency := Nota_4_Bimestre;

      ParamByName('pID_PROFESSOR_ALUNO').AsInteger := ID_Professor_Aluno;
    end;

    ExecSQL;
  end;
end;

procedure TProfessor_AlunoDAO.Cadastrar(AProfessor_Aluno: TProfessor_Aluno);
begin
  with FQuery do
  begin
    SQL.Clear;
    SQL.Add('Insert Into PROFESSOR_ALUNO');
    SQL.Add('(ID_PROFESSOR, ID_ALUNO, ANO, NOTA_1_BIMESTRE, NOTA_2_BIMESTRE, NOTA_3_BIMESTRE, NOTA_4_BIMESTRE, EXCLUIDO)');
    SQL.Add('Values');
    SQL.Add('(:pID_PROFESSOR, :pID_ALUNO, :pANO, :pNOTA_1_BIMESTRE, :pNOTA_2_BIMESTRE, :pNOTA_3_BIMESTRE, :pNOTA_4_BIMESTRE, False)');
    SQL.Add('Returning ID_Professor_Aluno');

    with AProfessor_Aluno do
    begin
      ParamByName('pID_PROFESSOR').AsInteger := Professor.ID_Professor;
      ParamByName('pID_ALUNO').AsInteger := Aluno.ID_Aluno;
      ParamByName('pANO').AsString := Ano;
      ParamByName('pNOTA_1_BIMESTRE').AsCurrency := Nota_1_Bimestre;
      ParamByName('pNOTA_2_BIMESTRE').AsCurrency := Nota_2_Bimestre;
      ParamByName('pNOTA_3_BIMESTRE').AsCurrency := Nota_3_Bimestre;
      ParamByName('pNOTA_4_BIMESTRE').AsCurrency := Nota_4_Bimestre;
    end;

    Open;

    AProfessor_Aluno.ID_Professor_Aluno := FieldByName('ID_Professor_Aluno').AsInteger;
  end;
end;

constructor TProfessor_AlunoDAO.Create(AConexao: TFDConnection);
begin
  FConexao := AConexao;
  FConexao.Connected := True;

  FQuery := TFDQuery.Create(Nil);
  FQuery.Connection := FConexao;
end;

destructor TProfessor_AlunoDAO.Destroy;
begin
  FreeAndNil(FQuery);
  inherited;
end;

procedure TProfessor_AlunoDAO.Excluir(AID_Professor_Aluno: Integer);
begin
  with FQuery do
  begin
    SQL.Clear;
    SQL.Add('Update PROFESSOR_ALUNO set');
    SQL.Add('Excluido = :pExcluido');
    SQL.Add('Where ID_Professor_Aluno = :pID_Professor_Aluno');

    ParamByName('pID_Professor_Aluno').AsInteger := AID_Professor_Aluno;

    ExecSQL;
  end;
end;

procedure TProfessor_AlunoDAO.Listar(AListaProfessor_Aluno: TObjectList<TProfessor_Aluno>; AID_Professor: Integer);
var
  TempProfessor_Aluno: TProfessor_Aluno;
begin
  with FQuery do
  begin
    SQL.Clear;
    SQL.Add('Select PL.NOTA_1_BIMESTRE, PL.NOTA_2_BIMESTRE, PL.NOTA_3_BIMESTRE, PL.NOTA_4_BIMESTRE,');
    SQL.Add('L.Nome');
    SQL.Add('From Professor_Aluno as PL');
    SQL.Add('Left Join Alunos as L on L.ID_Aluno = PL.ID_Aluno');
    SQL.Add('Where (PL.ID_Professor = :pID_Professor) and (PL.Excluido = False)');
    SQL.Add('order by ID_Professor_Aluno Desc');

    ParamByName('pID_Professor').AsInteger := AID_Professor;

    Open;

    while Not Eof do
    begin
      TempProfessor_Aluno := TProfessor_Aluno.Create;

      with TempProfessor_Aluno do
      begin
        Aluno.Nome := FieldByName('Nome').AsString;
        Nota_1_Bimestre := FieldByName('NOTA_1_BIMESTRE').AsCurrency;
        Nota_2_Bimestre := FieldByName('NOTA_2_BIMESTRE').AsCurrency;
        Nota_3_Bimestre := FieldByName('NOTA_3_BIMESTRE').AsCurrency;
        Nota_4_Bimestre := FieldByName('NOTA_4_BIMESTRE').AsCurrency;
      end;

      AListaProfessor_Aluno.Add(TempProfessor_Aluno);

      Next;
    end;
  end;
end;

end.
