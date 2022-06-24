unit MenuPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrmMenuPrincipal = class(TForm)
    Panel1: TPanel;
    btnAlunos: TButton;
    btnProfessores: TButton;
    procedure btnAlunosClick(Sender: TObject);
    procedure btnProfessoresClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMenuPrincipal: TFrmMenuPrincipal;

implementation

uses
  ConsultaAluno, ConsultaProfessor;

{$R *.dfm}

procedure TFrmMenuPrincipal.btnAlunosClick(Sender: TObject);
var
  TempID: Integer;
begin
  TempID := 0;
  FrmConsultaAlunos.Abrir(TempID);
end;

procedure TFrmMenuPrincipal.btnProfessoresClick(Sender: TObject);
begin
  FrmConsultaProfessores.Abrir;
end;

procedure TFrmMenuPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Application.Terminate;
end;

end.
