unit Model.Professor;

interface
Type
  TProfessor = Class
    private
      FEmail: String;
      FCPF: String;
      FData_Nascimento: TDate;
      FSexo: String;
      FNome: String;
      FDisciplina: String;
      FID_Professor: Integer;

      procedure SetCPF(const Value: String);
      procedure SetData_Nascimento(const Value: TDate);
      procedure SetDisciplina(const Value: String);
      procedure SetEmail(const Value: String);
      procedure SetNome(const Value: String);
      procedure SetSexo(const Value: String);
      procedure SetID_Professor(const Value: Integer);

    public
      Constructor Create;
      destructor Destroy; override;

      procedure Clear;

      property ID_Professor: Integer read FID_Professor write SetID_Professor;
      property Nome: String read FNome write SetNome;
      property CPF: String read FCPF write SetCPF;
      property Sexo: String read FSexo write SetSexo;
      property Data_Nascimento: TDate read FData_Nascimento write SetData_Nascimento;
      property Email: String read FEmail write SetEmail;
      property Disciplina: String read FDisciplina write SetDisciplina;

  End;

implementation

{ TProfessor }

procedure TProfessor.Clear;
begin
  ID_Professor := 0;
  Nome := '';
  CPF := '';
  Sexo := '';
  Data_Nascimento := 0;
  Email := '';
  Disciplina := '';
end;

constructor TProfessor.Create;
begin
  Clear;
end;

destructor TProfessor.Destroy;
begin

  inherited;
end;

procedure TProfessor.SetCPF(const Value: String);
begin
  FCPF := Value;
end;

procedure TProfessor.SetData_Nascimento(const Value: TDate);
begin
  FData_Nascimento := Value;
end;

procedure TProfessor.SetDisciplina(const Value: String);
begin
  FDisciplina := Value;
end;

procedure TProfessor.SetEmail(const Value: String);
begin
  FEmail := Value;
end;

procedure TProfessor.SetID_Professor(const Value: Integer);
begin
  FID_Professor := Value;
end;

procedure TProfessor.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TProfessor.SetSexo(const Value: String);
begin
  FSexo := Value;
end;

end.
