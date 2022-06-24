program ProjetoEscola;

uses
  Vcl.Forms,
  CadastroAluno in 'View\CadastroAluno.pas' {FrmCadastroAluno},
  Model.Aluno in 'Model\Model.Aluno.pas',
  Controller.Aluno in 'Controller\Controller.Aluno.pas',
  Model.Professor in 'Model\Model.Professor.pas',
  ConsultaAluno in 'View\ConsultaAluno.pas' {FrmConsultaAlunos},
  ConsultaProfessor in 'View\ConsultaProfessor.pas' {FrmConsultaProfessores},
  Model.Professor_Aluno in 'Model\Model.Professor_Aluno.pas',
  DataModule in 'DAO\DataModule.pas' {dmPrincipal: TDataModule},
  DAO.Aluno in 'DAO\DAO.Aluno.pas',
  CadastroProfessor in 'View\CadastroProfessor.pas' {FrmCadastroProfessor},
  Model.Calcular in 'Model\Model.Calcular.pas',
  Model.Validacao in 'Model\Model.Validacao.pas',
  DAO.Professor in 'DAO\DAO.Professor.pas',
  Controller.Professor in 'Controller\Controller.Professor.pas',
  MenuPrincipal in 'View\MenuPrincipal.pas' {FrmMenuPrincipal},
  Controller.Professor_Aluno in 'Controller\Controller.Professor_Aluno.pas',
  DAO.Professor_Aluno in 'DAO\DAO.Professor_Aluno.pas',
  NotasAlunoDoProfessor in 'View\NotasAlunoDoProfessor.pas' {FrmNotasAlunoDoProfessor};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmPrincipal, dmPrincipal);
  Application.CreateForm(TFrmMenuPrincipal, FrmMenuPrincipal);
  Application.Run;
end.
