unit CadastroAluno;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  Vcl.ExtCtrls, Controller.Aluno, Model.Aluno, DataModule, Model.Validacao;

type
  TFrmCadastroAluno = class(TForm)
    Panel1: TPanel;
    edtNomeAluno: TEdit;
    cmbSexoAluno: TComboBox;
    medtDataNascimentoAluno: TMaskEdit;
    edtEmailAluno: TEdit;
    medtCPFAluno: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    btnSalvar: TBitBtn;
    btnCancelar: TBitBtn;
    cmbSerie: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FAlunoController: TAlunoController;
    FAluno: TAluno;

    procedure CarregarEdit;

  public
    procedure Abrir(AID_Aluno: Integer);
  end;

var
  FrmCadastroAluno: TFrmCadastroAluno;

implementation

{$R *.dfm}

procedure TFrmCadastroAluno.Abrir(AID_Aluno: Integer);
begin
  with FrmCadastroAluno do
  begin
    Try
      FrmCadastroAluno := TFrmCadastroAluno.Create(Nil);

      if AID_Aluno > 0 then
      begin
        FAluno.ID_Aluno := AID_Aluno;

        FAlunoController.Consultar(FAluno);

        CarregarEdit;
      end;

      ShowModal;

    Finally
      FreeAndNil(FrmCadastroAluno);
    End;
  end;

end;

procedure TFrmCadastroAluno.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCadastroAluno.btnSalvarClick(Sender: TObject);
begin
  with FAluno do
  begin
    Nome := edtNomeAluno.Text;
    CPF := medtCPFAluno.Text;
    Sexo := cmbSexoAluno.Text;
    Data_Nascimento := StrToDateDef(medtDataNascimentoAluno.Text, 0);
    Email := edtEmailAluno.Text;
    Serie := cmbSerie.Text;
  end;

  FAlunoController.Salvar(FAluno);
  Close;
end;

procedure TFrmCadastroAluno.CarregarEdit;
begin
  with FAluno do
  begin
    edtNomeAluno.Text := Nome;
    medtCPFAluno.Text := CPF;
    cmbSexoAluno.ItemIndex := cmbSexoAluno.Items.IndexOf(Sexo);
    medtDataNascimentoAluno.Text := DateToStr(Data_Nascimento);
    edtEmailAluno.Text := Email;
    cmbSerie.ItemIndex := cmbSerie.Items.IndexOf(Serie);
  end;
end;

procedure TFrmCadastroAluno.FormCreate(Sender: TObject);
begin
  FAlunoController := TAlunoController.Create;
  FAluno := TAluno.Create;
end;

procedure TFrmCadastroAluno.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FAlunoController);
  FreeAndNil(FAluno);
end;

procedure TFrmCadastroAluno.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    btnSalvarClick(Self)
  else if Key = VK_ESCAPE then
    btnCancelarClick(Self);
end;

end.
