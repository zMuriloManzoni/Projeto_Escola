unit CadastroProfessor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.WinXCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.ExtCtrls,
  Model.Professor, Controller.Professor, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Controller.Aluno, System.Generics.Collections,
  Model.Aluno, Model.Professor_Aluno, Controller.Professor_Aluno,
  Model.Validacao, Vcl.DBCtrls, math;

type
  TFrmCadastroProfessor = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    lblNomeProfessor: TLabel;
    lblGeneroProfessor: TLabel;
    lblNascimentoProfessor: TLabel;
    lblCPFProfessor: TLabel;
    lblEmailProfessor: TLabel;
    lblDisciplinaProfessor: TLabel;
    edtNomeProfessor: TEdit;
    cmbSexoProfessor: TComboBox;
    medtCPFProfessor: TMaskEdit;
    medtDataNascimentoProfessor: TMaskEdit;
    edtEmailProfessor: TEdit;
    edtDisciplinaProfessor: TEdit;
    grdProfessorAluno: TDBGrid;
    edtNotaPrimeiroBimestre: TEdit;
    edtNotaSegundoBimestre: TEdit;
    edtNotaTerceiroBimestre: TEdit;
    edtNotaQuartoBimestre: TEdit;
    lblNota1Bimestre: TLabel;
    lblNota2Bimestre: TLabel;
    lblNota3Bimestre: TLabel;
    lblNota4Bimestre: TLabel;
    btnAdicionar: TBitBtn;
    btnRemover: TBitBtn;
    btnAlterar: TBitBtn;
    btnSalvar: TBitBtn;
    btnCancelar: TBitBtn;
    dsProfessorAluno: TDataSource;
    FDQueryProfessorAluno: TFDQuery;
    lblAno: TLabel;
    edtAno: TEdit;
    cmbAluno: TComboBox;
    btnConsultaAluno: TBitBtn;
    btnCalcular: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtNotaPrimeiroBimestreKeyPress(Sender: TObject; var Key: Char);
    procedure edtNotaSegundoBimestreKeyPress(Sender: TObject; var Key: Char);
    procedure edtNotaTerceiroBimestreKeyPress(Sender: TObject; var Key: Char);
    procedure edtNotaQuartoBimestreKeyPress(Sender: TObject; var Key: Char);
    procedure edtNotaPrimeiroBimestreExit(Sender: TObject);
    procedure edtNotaSegundoBimestreExit(Sender: TObject);
    procedure edtNotaTerceiroBimestreExit(Sender: TObject);
    procedure edtNotaQuartoBimestreExit(Sender: TObject);
    procedure cmbAlunoChange(Sender: TObject);
    procedure cmbAlunoSelect(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure grdProfessorAlunoDblClick(Sender: TObject);
    procedure btnConsultaAlunoClick(Sender: TObject);
    procedure btnCalcularClick(Sender: TObject);
    procedure cmbAlunoExit(Sender: TObject);
    procedure edtAnoKeyPress(Sender: TObject; var Key: Char);
  private
    FAlunoController: TAlunoController;
    FProfessorController: TProfessorController;
    FProfessor_AlunoController: TProfessor_AlunoController;

    FListaAluno: TObjectList<TAluno>;

    FProfessor: TProfessor;
    FProfessorAluno: TProfessor_Aluno;

    IValidar: IValidacao;

    procedure CarregarEdit;
    procedure CarregarProfessorAluno;
    procedure BuscarAlunos;
    procedure LimpaEditAlunoProfessor;

  public
    procedure Abrir(AID_Professor: Integer);
  end;

var
  FrmCadastroProfessor: TFrmCadastroProfessor;

implementation

uses
  DataModule, ConsultaProfessor, ConsultaAluno,
  NotasAlunoDoProfessor;

{$R *.dfm}

procedure TFrmCadastroProfessor.Abrir(AID_Professor: Integer);
begin
  with FrmCadastroProfessor do
  begin
    Try
      FrmCadastroProfessor := TFrmCadastroProfessor.Create(Application);

      if AID_Professor > 0 then
      begin
        FProfessor.ID_Professor := AID_Professor;

        FProfessorController.Consultar(FProfessor);

        CarregarEdit;
      end;

      ShowModal;
    Finally
      FreeAndNil(FrmCadastroProfessor);
    End;
  end;
end;

procedure TFrmCadastroProfessor.btnAdicionarClick(Sender: TObject);
begin
  with FProfessorAluno do
  begin
    Professor.ID_Professor := FProfessor.ID_Professor;
    Nota_1_Bimestre := StrToFloatDef(edtNotaPrimeiroBimestre.Text, -1);
    Nota_2_Bimestre := StrToFloatDef(edtNotaSegundoBimestre.Text, -1);
    Nota_3_Bimestre := StrToFloatDef(edtNotaTerceiroBimestre.Text, -1);
    Nota_4_Bimestre := StrToFloatDef(edtNotaQuartoBimestre.Text, -1);
    Ano := edtAno.Text;
  end;

  FProfessor_AlunoController.Salvar(FProfessorAluno);

  CarregarProfessorAluno;
  LimpaEditAlunoProfessor;
  FProfessorAluno.Clear;
end;

procedure TFrmCadastroProfessor.btnAlterarClick(Sender: TObject);
begin
  with FProfessorAluno do
  begin
    Professor.ID_Professor := FProfessor.ID_Professor;
    Nota_1_Bimestre := StrToFloatDef(edtNotaPrimeiroBimestre.Text, -1);
    Nota_2_Bimestre := StrToFloatDef(edtNotaSegundoBimestre.Text, -1);
    Nota_3_Bimestre := StrToFloatDef(edtNotaTerceiroBimestre.Text, -1);
    Nota_4_Bimestre := StrToFloatDef(edtNotaQuartoBimestre.Text, -1);
    Ano := edtAno.Text;
  end;

  FProfessor_AlunoController.Salvar(FProfessorAluno);
  CarregarProfessorAluno;
  LimpaEditAlunoProfessor;
  FProfessorAluno.Clear;

  btnAdicionar.Enabled := True;
  btnRemover.Enabled := True;
  btnAlterar.Enabled := False;
end;

procedure TFrmCadastroProfessor.btnCalcularClick(Sender: TObject);
begin
  FrmNotasAlunoDoProfessor.Abrir(FProfessor);
end;

procedure TFrmCadastroProfessor.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCadastroProfessor.btnConsultaAlunoClick(Sender: TObject);
var
  TempID_Aluno: Integer;
begin
  FrmConsultaAlunos.Abrir(TempID_Aluno);

  if TempID_Aluno > 0 then
  begin
    FProfessorAluno.Aluno.ID_Aluno := TempID_Aluno;
    FAlunoController.Consultar(FProfessorAluno.Aluno);
    cmbAluno.Clear;
    cmbAluno.Items.Add(FProfessorAluno.Aluno.Nome);
    cmbAluno.ItemIndex := 0;
  end;
end;

procedure TFrmCadastroProfessor.btnRemoverClick(Sender: TObject);
begin
  if grdProfessorAluno.Fields[0].Value = Null then
    raise exception.Create('Nenhum registro selecionado.')
  else
  begin
    if MessageDlg('Confirmar exclusão das notas do aluno?', mtConfirmation, [mbYes, mbNo],0) = mrYes then
    begin
      FProfessor_AlunoController.Excluir(grdProfessorAluno.Fields[6].Value);
      CarregarProfessorAluno;
    end;
  end;
end;

procedure TFrmCadastroProfessor.btnSalvarClick(Sender: TObject);
begin
  with FProfessor do
  begin
    Nome := edtNomeProfessor.Text;
    CPF := medtCPFProfessor.Text;
    Sexo := cmbSexoProfessor.Text;
    Data_Nascimento := StrToDateDef(medtDataNascimentoProfessor.Text, 0);
    Email := edtEmailProfessor.Text;
    Disciplina := edtDisciplinaProfessor.Text;
  end;

  FProfessorController.Salvar(FProfessor);
end;

procedure TFrmCadastroProfessor.BuscarAlunos;
var
  I: Integer;
  TempNomeAluno: String;
begin
  FListaAluno.Clear;

  for I := Pred(cmbAluno.Items.Count) DownTo 0 do
  begin
    cmbAluno.Items.Delete(I);
  end;

  FAlunoController.Listar(FListaAluno, cmbAluno.Text);

  for I := 0 to Pred(FListaAluno.Count) do
  begin
    cmbAluno.Items.Add(FListaAluno[I].Nome);
  end;
end;

procedure TFrmCadastroProfessor.CarregarProfessorAluno;
begin
  with FDQueryProfessorAluno do
  begin
    Close;
    Params.ClearValues();
    Params[0].AsInteger := FProfessor.ID_Professor;

    Open();
  end;
end;

procedure TFrmCadastroProfessor.CarregarEdit;
begin
  with FProfessor do
  begin
    edtNomeProfessor.Text := Nome;
    medtCPFProfessor.Text := CPF;
    cmbSexoProfessor.ItemIndex := cmbSexoProfessor.Items.IndexOf(Sexo);
    medtDataNascimentoProfessor.Text := DateToStr(Data_Nascimento);
    edtEmailProfessor.Text := Email;
    edtDisciplinaProfessor.Text := Disciplina;
    CarregarProfessorAluno;
  end;
end;

procedure TFrmCadastroProfessor.cmbAlunoChange(Sender: TObject);
begin
  if Length(cmbAluno.Text) > 2 then
     BuscarAlunos;
end;

procedure TFrmCadastroProfessor.cmbAlunoExit(Sender: TObject);
begin
  if cmbAluno.Text <> '' then
  begin
    cmbAluno.ItemIndex := cmbAluno.Items.IndexOf(cmbAluno.Text);
      if cmbAluno.ItemIndex >= 0 then
        FProfessorAluno.Aluno.ID_Aluno := FListaAluno[cmbAluno.ItemIndex].ID_Aluno;
  end;
end;

procedure TFrmCadastroProfessor.cmbAlunoSelect(Sender: TObject);
begin
  FProfessorAluno.Aluno.ID_Aluno := FListaAluno[cmbAluno.ItemIndex].ID_Aluno;
end;

procedure TFrmCadastroProfessor.edtAnoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    btnAdicionarClick(Self);
end;

procedure TFrmCadastroProfessor.edtNotaPrimeiroBimestreExit(Sender: TObject);
begin
  if Not IValidar.ValidarValorNota(StrToFloatDef(edtNotaPrimeiroBimestre.Text, 0)) then
    raise exception.Create('O valor maximo da nota do 1º bimestre não pode ser superior a 10.');
end;

procedure TFrmCadastroProfessor.edtNotaPrimeiroBimestreKeyPress(Sender: TObject;
  var Key: Char);
begin
  IValidar.ValidarCaracteres(edtNotaPrimeiroBimestre.Text, Key);
end;

procedure TFrmCadastroProfessor.edtNotaQuartoBimestreExit(Sender: TObject);
begin
  if Not IValidar.ValidarValorNota(StrToFloatDef(edtNotaQuartoBimestre.Text, 0)) then
    raise exception.Create('O valor maximo da nota do 4º bimestre não pode ser superior a 10.');
end;

procedure TFrmCadastroProfessor.edtNotaQuartoBimestreKeyPress(Sender: TObject;
  var Key: Char);
begin
  IValidar.ValidarCaracteres(edtNotaQuartoBimestre.Text, Key);
end;

procedure TFrmCadastroProfessor.edtNotaSegundoBimestreExit(Sender: TObject);
begin
  if Not IValidar.ValidarValorNota(StrToFloatDef(edtNotaSegundoBimestre.Text, 0)) then
    raise exception.Create('O valor maximo da nota do 2º bimestre não pode ser superior a 10.');
end;

procedure TFrmCadastroProfessor.edtNotaSegundoBimestreKeyPress(Sender: TObject;
  var Key: Char);
begin
  IValidar.ValidarCaracteres(edtNotaSegundoBimestre.Text, Key);
end;

procedure TFrmCadastroProfessor.edtNotaTerceiroBimestreExit(Sender: TObject);
begin
  if Not IValidar.ValidarValorNota(StrToFloatDef(edtNotaTerceiroBimestre.Text, 0)) then
    raise exception.Create('O valor maximo da nota do 3º bimestre não pode ser superior a 10.');
end;

procedure TFrmCadastroProfessor.edtNotaTerceiroBimestreKeyPress(Sender: TObject;
  var Key: Char);
begin
  IValidar.ValidarCaracteres(edtNotaTerceiroBimestre.Text, Key);
end;

procedure TFrmCadastroProfessor.FormCreate(Sender: TObject);
begin
  FAlunoController := TAlunoController.Create;
  FProfessorController := TProfessorController.Create;
  FProfessor_AlunoController := TProfessor_AlunoController.Create;

  FListaAluno := TObjectList<TAluno>.create;

  FProfessor := TProfessor.Create;
  FProfessorAluno := TProfessor_Aluno.Create;

  IValidar := TValidar.Create;

  FDQueryProfessorAluno.Connection := Conexao;
  FDQueryProfessorAluno.Active := True;
end;

procedure TFrmCadastroProfessor.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FAlunoController);
  FreeAndNil(FProfessorController);
  FreeAndNil(FProfessor_AlunoController);

  FreeAndNil(FListaAluno);

  FreeAndNil(FProfessor);
  FreeAndNil(FProfessorAluno);
end;

procedure TFrmCadastroProfessor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    btnSalvarClick(Self)
  else if (Key = VK_ESCAPE) and (btnAlterar.Enabled) then
  begin
    LimpaEditAlunoProfessor;
    btnAdicionar.Enabled := True;
    btnRemover.Enabled := True;
    btnAlterar.Enabled := False;
  end
  else if Key = VK_ESCAPE then
    btnCancelarClick(Self);
end;

procedure TFrmCadastroProfessor.grdProfessorAlunoDblClick(Sender: TObject);
begin
  if grdProfessorAluno.Fields[0].Value = Null then
    raise exception.Create('Nenhum registro selecionado.')
  else
  begin
    edtNotaPrimeiroBimestre.Text := CurrToStr(RoundTo(grdProfessorAluno.Fields[1].AsCurrency, -2));
    edtNotaSegundoBimestre.Text := CurrToStr(RoundTo(grdProfessorAluno.Fields[2].AsCurrency, -2));
    edtNotaTerceiroBimestre.Text := CurrToStr(RoundTo(grdProfessorAluno.Fields[3].AsCurrency, -2));
    edtNotaQuartoBimestre.Text := CurrToStr(RoundTo(grdProfessorAluno.Fields[4].AsCurrency, -2));
    edtAno.Text := grdProfessorAluno.Fields[5].Value;
    FProfessorAluno.ID_Professor_Aluno := grdProfessorAluno.Fields[6].Value;

    //Trata ComboBox
    FProfessorAluno.Aluno.ID_Aluno := grdProfessorAluno.Fields[7].Value;
    FAlunoController.Consultar(FProfessorAluno.Aluno);
    cmbAluno.Clear;
    cmbAluno.Items.Add(FProfessorAluno.Aluno.Nome);
    cmbAluno.ItemIndex := 0;
  end;

  btnAdicionar.Enabled := False;
  btnRemover.Enabled := False;
  btnAlterar.Enabled := True;
end;

procedure TFrmCadastroProfessor.LimpaEditAlunoProfessor;
begin
  cmbAluno.Clear;
  edtNotaPrimeiroBimestre.Clear;
  edtNotaSegundoBimestre.Clear;
  edtNotaTerceiroBimestre.Clear;
  edtNotaQuartoBimestre.Clear;
  edtAno.Clear;
end;

end.
