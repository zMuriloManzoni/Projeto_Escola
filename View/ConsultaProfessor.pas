unit ConsultaProfessor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Controller.Professor;

type
  TFrmConsultaProfessores = class(TForm)
    edtPesquisa: TEdit;
    grdProfessor: TDBGrid;
    btnAtualizar: TBitBtn;
    lblRegistro: TLabel;
    btnAlterar: TBitBtn;
    btnIncluir: TBitBtn;
    btnExcluir: TBitBtn;
    btnFechar: TBitBtn;
    pnlFundo: TPanel;
    DataSourceProfessor: TDataSource;
    FDQueryProfessor: TFDQuery;
    lblNomeProfessor: TLabel;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAtualizarClick(Sender: TObject);
    procedure grdProfessorDblClick(Sender: TObject);
    procedure edtPesquisaChange(Sender: TObject);
  private
    FProfessorController: TProfessorController;

    procedure CarregaGrid;
  public
    procedure Abrir;
  end;

var
  FrmConsultaProfessores: TFrmConsultaProfessores;

implementation

uses
  CadastroProfessor, DataModule;

{$R *.dfm}

procedure TFrmConsultaProfessores.Abrir;
begin
  with FrmConsultaProfessores do
  begin
    Try
      FrmConsultaProfessores := TFrmConsultaProfessores.Create(Application);

      CarregaGrid;

      ShowModal;
    Finally
      FreeAndNil(FrmConsultaProfessores);
    End;
  end;
end;

procedure TFrmConsultaProfessores.btnAlterarClick(Sender: TObject);
begin
  if grdProfessor.Fields[0].Value = Null then
    raise exception.Create('Nenhum registro selecionado.')
  else
  begin
    FrmCadastroProfessor.Abrir(grdProfessor.Fields[0].Value);
    CarregaGrid;
  end;
end;

procedure TFrmConsultaProfessores.btnAtualizarClick(Sender: TObject);
begin
  CarregaGrid;
end;

procedure TFrmConsultaProfessores.btnExcluirClick(Sender: TObject);
begin
  if grdProfessor.Fields[0].Value = Null then
    raise exception.Create('Nenhum registro selecionado.')
  else
  begin
    if MessageDlg('Confirmar exclusão do professor?', mtConfirmation, [mbYes, mbNo],0) = mrYes then
    begin
      FProfessorController.Excluir(grdProfessor.Fields[0].Value);
      CarregaGrid;
    end;
  end;
end;

procedure TFrmConsultaProfessores.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmConsultaProfessores.btnIncluirClick(Sender: TObject);
begin
  FrmCadastroProfessor.Abrir(0);

  CarregaGrid;
end;

procedure TFrmConsultaProfessores.CarregaGrid;
begin
  FDQueryProfessor.Close;
  
  with FDQueryProfessor do
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

    Open(SQL.Text);
    
    lblRegistro.Caption := IntToStr(FDQueryProfessor.RecordCount);
  end;
end;

procedure TFrmConsultaProfessores.edtPesquisaChange(Sender: TObject);
begin
  CarregaGrid;
end;

procedure TFrmConsultaProfessores.FormCreate(Sender: TObject);
begin
  FProfessorController := TProfessorController.Create;

  FDQueryProfessor.Connection := Conexao;
  FDQueryProfessor.Active := True;
end;

procedure TFrmConsultaProfessores.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FProfessorController);
end;

procedure TFrmConsultaProfessores.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFrmConsultaProfessores.grdProfessorDblClick(Sender: TObject);
begin
  btnAlterarClick(Self);
end;

end.
