unit Model.Professor_Aluno;

interface

uses
  Model.Aluno, Model.Professor;
Type
  TProfessor_Aluno = Class
    private
      FID_Professor_Aluno: Integer;
      FNota_2_Bimestre: Currency;
      FNota_3_Bimestre: Currency;
      FNota_1_Bimestre: Currency;
      FNota_4_Bimestre: Currency;
      FAno: String;
      FAluno: TAluno;
      FProfessor: TProfessor;

      procedure SetAluno(const Value: TAluno);
      procedure SetAno(const Value: String);
      procedure SetID_Professor_Aluno(const Value: Integer);
      procedure SetNota_1_Bimestre(const Value: Currency);
      procedure SetNota_2_Bimestre(const Value: Currency);
      procedure SetNota_3_Bimestre(const Value: Currency);
      procedure SetNota_4_Bimestre(const Value: Currency);
      procedure SetProfessor(const Value: TProfessor);

    public
      Constructor Create;
      destructor Destroy; override;

      procedure Clear;

      property ID_Professor_Aluno: Integer read FID_Professor_Aluno write SetID_Professor_Aluno;
      property Ano: String read FAno write SetAno;
      property Aluno: TAluno read FAluno write SetAluno;
      property Professor: TProfessor read FProfessor write SetProfessor;
      property Nota_1_Bimestre: Currency read FNota_1_Bimestre write SetNota_1_Bimestre;
      property Nota_2_Bimestre: Currency read FNota_2_Bimestre write SetNota_2_Bimestre;
      property Nota_3_Bimestre: Currency read FNota_3_Bimestre write SetNota_3_Bimestre;
      property Nota_4_Bimestre: Currency read FNota_4_Bimestre write SetNota_4_Bimestre;

  End;

implementation

uses
  System.SysUtils;

{ Professor_Aluno }

procedure TProfessor_Aluno.Clear;
begin
  ID_Professor_Aluno := 0;
  Ano := '';
  FAluno.Clear;
  FProfessor.Clear;
  Nota_1_Bimestre := 0;
  Nota_2_Bimestre := 0;
  Nota_3_Bimestre := 0;
  Nota_4_Bimestre := 0;
end;

constructor TProfessor_Aluno.Create;
begin
  FAluno := TAluno.Create;
  FProfessor := TProfessor.Create;
  Clear;
end;

destructor TProfessor_Aluno.Destroy;
begin
  FreeAndNil(FAluno);
  FreeAndNil(FProfessor);
  inherited;
end;

procedure TProfessor_Aluno.SetAluno(const Value: TAluno);
begin
  FAluno := Value;
end;

procedure TProfessor_Aluno.SetAno(const Value: String);
begin
  FAno := Value;
end;

procedure TProfessor_Aluno.SetID_Professor_Aluno(const Value: Integer);
begin
  FID_Professor_Aluno := Value;
end;

procedure TProfessor_Aluno.SetNota_1_Bimestre(const Value: Currency);
begin
  FNota_1_Bimestre := Value;
end;

procedure TProfessor_Aluno.SetNota_2_Bimestre(const Value: Currency);
begin
  FNota_2_Bimestre := Value;
end;

procedure TProfessor_Aluno.SetNota_3_Bimestre(const Value: Currency);
begin
  FNota_3_Bimestre := Value;
end;

procedure TProfessor_Aluno.SetNota_4_Bimestre(const Value: Currency);
begin
  FNota_4_Bimestre := Value;
end;

procedure TProfessor_Aluno.SetProfessor(const Value: TProfessor);
begin
  FProfessor := Value;
end;

end.
