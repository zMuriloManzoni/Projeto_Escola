unit ConsultaAluno;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Controller.Aluno;

type
  TFrmConsultaAlunos = class(TForm)
    grdAlunos: TDBGrid;
    pnlFundo: TPanel;
    edtPesquisa: TEdit;
    btnAtualizar: TBitBtn;
    lblRegistro: TLabel;
    btnIncluir: TBitBtn;
    btnAlterar: TBitBtn;
    btnExcluir: TBitBtn;
    btnFechar: TBitBtn;
    DataSourceAluno: TDataSource;
    FDQueryAluno: TFDQuery;
    lblNomeAluno: TLabel;
    FDQueryAlunoID_ALUNO: TIntegerField;
    FDQueryAlunoNOME: TStringField;
    FDQueryAlunoCPF: TStringField;
    FDQueryAlunoSERIE: TStringField;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure grdAlunosDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure edtPesquisaChange(Sender: TObject);
  private
    FAlunoController: TAlunoController;
    ID_Aluno: Integer;

    function MascararCPF(aTexto: String): String;
    procedure CarregaGrid;
  public
    procedure Abrir(Var AID_aluno: Integer);
  end;

var
  FrmConsultaAlunos: TFrmConsultaAlunos;

implementation

uses
  DataModule, CadastroAluno, CadastroProfessor, Model.Validacao;

{$R *.dfm}

procedure TFrmConsultaAlunos.Abrir(Var AID_aluno: Integer);
begin
  with FrmConsultaAlunos do
  begin
    Try
      FrmConsultaAlunos := TFrmConsultaAlunos.Create(Application);

      CarregaGrid;

      ShowModal;

      AID_aluno := ID_Aluno;

    Finally
      FreeAndNil(FrmConsultaAlunos);
    End;
  end;
end;

procedure TFrmConsultaAlunos.btnAlterarClick(Sender: TObject);
begin
  if grdAlunos.Fields[0].Value = Null then
    raise exception.Create('Nenhum registro selecionado.')
  else
  begin
    FrmCadastroAluno.Abrir(grdAlunos.Fields[0].Value);
    FDQueryAluno.Refresh;
  end;
end;

procedure TFrmConsultaAlunos.btnAtualizarClick(Sender: TObject);
begin
  FDQueryAluno.Refresh;
end;

procedure TFrmConsultaAlunos.btnExcluirClick(Sender: TObject);
begin
  if grdAlunos.Fields[0].Value = Null then
    raise exception.Create('Nenhum registro selecionado.')
  else
  begin
    if MessageDlg('Confirmar exclusão do aluno?', mtConfirmation, [mbYes, mbNo],0) = mrYes then
    begin
      FAlunoController.Excluir(grdAlunos.Fields[0].value);
      FDQueryAluno.Refresh;
    end;
  end;
end;

procedure TFrmConsultaAlunos.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmConsultaAlunos.btnIncluirClick(Sender: TObject);
begin
  FrmCadastroAluno.Abrir(0);

  FDQueryAluno.Refresh;
end;

procedure TFrmConsultaAlunos.CarregaGrid;
begin
  with FDQueryAluno do
  begin
    if Length(edtPesquisa.Text) > 2 then
    begin
      Filter := 'Nome Like ' + QuotedStr('%' + edtPesquisa.Text + '%');
      Filtered := True
    end
    else
    begin
      Filter := '';
      Filtered := False;
    end;

    lblRegistro.Caption := RecordCount.ToString;
  end;
end;

procedure TFrmConsultaAlunos.edtPesquisaChange(Sender: TObject);
begin
  CarregaGrid;
end;

procedure TFrmConsultaAlunos.FormCreate(Sender: TObject);
begin
  FAlunoController := TAlunoController.Create;

  FDQueryAluno.Connection := Conexao;
  FDQueryAluno.Active := True;
end;

procedure TFrmConsultaAlunos.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FAlunoController);
end;

procedure TFrmConsultaAlunos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F3 then
    btnAlterarClick(Self)
  else if Key = VK_F4 then
    btnIncluirClick(Self)
  else if Key = VK_F5 then
    btnExcluirClick(Self)
  else if Key = VK_ESCAPE then
    Close;
end;

procedure TFrmConsultaAlunos.grdAlunosDblClick(Sender: TObject);
begin
  if grdAlunos.Fields[0].Value = Null then
    raise exception.Create('Nenhum registro selecionado.')
  else if Assigned(FrmCadastroProfessor) then
  begin
    ID_Aluno := grdAlunos.Fields[0].Value;
    Close;
  end
  else
    btnAlterarClick(Self);
end;

function TFrmConsultaAlunos.MascararCPF(aTexto: String): String;
begin
  if Length(aTexto) >= 4 then
    Insert('.',aTexto,4);

  if Length(aTexto) >= 8 then
    Insert('.',aTexto,8);

  if Length(aTexto) >= 12 then
    Insert('-',aTexto,12);

    aTexto := Copy(aTexto,1,14);

  Result := aTexto;
end;

end.
