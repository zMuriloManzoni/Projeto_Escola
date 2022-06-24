unit Controller.ProfessorProdutoTeste;

interface
uses
  DUnitX.TestFramework, Controller.Professor_Aluno, Model.Professor_Aluno;

type

  [TestFixture]
  TControllerProfessorAlunoTest = class(TObject)
  private
    FProfessor_AlunoController: TProfessor_AlunoController;
    FProfessor_Aluno: TProfessor_Aluno;

    Validar: Boolean;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    // Sample Methods
    // Simple single Test
    [Test]
    procedure TestCadastrarProfessorAluno;
    [Test]
    procedure TestAtualizarProfessorAluno;
  end;

implementation

uses
  System.SysUtils, DataModule, Vcl.Forms;

procedure TControllerProfessorAlunoTest.Setup;
begin
  dmTestes := TdmTestes.Create(Nil);

  FProfessor_AlunoController := TProfessor_AlunoController.Create;
  FProfessor_Aluno := TProfessor_Aluno.Create;

  with FProfessor_Aluno do
  begin
    ID_Professor_Aluno := 0;
    Ano := '2014';
    Aluno.ID_Aluno := 1;
    Professor.ID_Professor := 1;
    Nota_1_Bimestre := 7;
    Nota_2_Bimestre := 9;
    Nota_3_Bimestre := 10;
    Nota_4_Bimestre := 8.5;
  end;

  Validar := False;
end;

procedure TControllerProfessorAlunoTest.TearDown;
begin
  FreeAndNil(FProfessor_AlunoController);
  FreeAndNil(FProfessor_Aluno);
end;

procedure TControllerProfessorAlunoTest.TestAtualizarProfessorAluno;
begin
  Validar := FProfessor_AlunoController.Salvar(FProfessor_Aluno);

  Assert.IsTrue(Validar, 'Ocorreu um erro ao tentar atualizar um Aluno do Professor.');
end;

procedure TControllerProfessorAlunoTest.TestCadastrarProfessorAluno;
begin
  Validar := FProfessor_AlunoController.Salvar(FProfessor_Aluno);

  Assert.IsTrue(Validar, 'Ocorreu um erro ao tentar cadastrar um Aluno do Professor.');
end;

initialization
  TDUnitX.RegisterTestFixture(TControllerProfessorAlunoTest);
end.
