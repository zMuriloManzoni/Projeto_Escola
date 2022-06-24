unit Model.Aluno;

interface
type
  TAluno = class
    private
      FEmail: String;
      FCPF: String;
      FSerie: String;
      FID_Aluno: Integer;
      FData_Nascimento: TDate;
      FSexo: string;
      FNome: string;

      procedure SetCPF(const Value: String);
      procedure SetData_Nascimento(const Value: TDate);
      procedure SetEmail(const Value: String);
      procedure SetID_Aluno(const Value: Integer);
      procedure SetNome(const Value: string);
      procedure SetSerie(const Value: String);
      procedure SetSexo(const Value: string);

    public
      Constructor Create;
      destructor Destroy; override;

      procedure Clear;

      property ID_Aluno: Integer read FID_Aluno write SetID_Aluno;
      property Nome: string read FNome write SetNome;
      property CPF: String read FCPF write SetCPF;
      property Sexo: string read FSexo write SetSexo;
      property Data_Nascimento: TDate read FData_Nascimento write SetData_Nascimento;
      property Email: String read FEmail write SetEmail;
      property Serie: String read FSerie write SetSerie;

  end;

implementation

{ TAluno }

procedure TAluno.Clear;
begin
  ID_Aluno := 0;
  Nome := '';
  CPF := '';
  Sexo := '';
  Data_Nascimento := 0;
  Email := '';
  Serie := '';
end;

constructor TAluno.Create;
begin
  Clear;
end;

destructor TAluno.Destroy;
begin

  inherited;
end;

procedure TAluno.SetCPF(const Value: String);
begin
  FCPF := Value;
end;

procedure TAluno.SetData_Nascimento(const Value: TDate);
begin
  FData_Nascimento := Value;
end;

procedure TAluno.SetEmail(const Value: String);
begin
  FEmail := Value;
end;

procedure TAluno.SetID_Aluno(const Value: Integer);
begin
  FID_Aluno := Value;
end;

procedure TAluno.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TAluno.SetSerie(const Value: String);
begin
  FSerie := Value;
end;

procedure TAluno.SetSexo(const Value: string);
begin
  FSexo := Value;
end;

end.
