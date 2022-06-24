unit NotasAlunoDoProfessor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Model.Professor_Aluno,
  Model.Professor, Controller.Professor_Aluno, System.Generics.Collections,
  Model.Validacao, Model.Calcular;

type
  TFrmNotasAlunoDoProfessor = class(TForm)
    grdNotas: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FProfessor_AlunoController: TProfessor_AlunoController;

    FListaProfessor_Aluno: TObjectList<TProfessor_Aluno>;

    ID_Professor: Integer;


    ICalcularMedia, ICalcularMaior, ICalcularMenor: ICalculo;

    procedure CarregarGrid;
  public
    procedure Abrir(AProfessor: TProfessor);
  end;

var
  FrmNotasAlunoDoProfessor: TFrmNotasAlunoDoProfessor;

implementation

{$R *.dfm}

{ TFrmNotasAlunoDoProfessor }

procedure TFrmNotasAlunoDoProfessor.Abrir(AProfessor: TProfessor);
begin
  with FrmNotasAlunoDoProfessor do
  begin
    Try
      FrmNotasAlunoDoProfessor := TFrmNotasAlunoDoProfessor.Create(Nil);

      ID_Professor := AProfessor.ID_Professor;

      Caption := Caption + ' ' + AProfessor.Nome;

      CarregarGrid;

      ShowModal;

    Finally
      FreeAndNil(FrmNotasAlunoDoProfessor);
    End;
  end;
end;

procedure TFrmNotasAlunoDoProfessor.CarregarGrid;
var
  I: Integer;
begin
  FProfessor_AlunoController.Listar(FListaProfessor_Aluno, ID_Professor);

  with grdNotas DO
  begin
    grdNotas.Cells[0, 0] := 'ALUNO';
    grdNotas.Cells[1, 0] := 'MELHOR NOTA';
    grdNotas.Cells[2, 0] := 'PIOR NOTA';
    grdNotas.Cells[3, 0] := 'MÉDIA';

    ColWidths[0] := 300;
    ColWidths[1] := 100;
    ColWidths[2] := 100;
    ColWidths[3] := 100;

    RowCount := FListaProfessor_Aluno.Count + 1;

    for I := 0 to Pred(FListaProfessor_Aluno.Count) do
    begin
      Cells[0, (I + 1)] := FListaProfessor_Aluno[I].Aluno.Nome;

      Cells[1, (I + 1)] := FormatFloat('0.00', ICalcularMaior.Calcular(FListaProfessor_Aluno[I].Nota_1_Bimestre,
      FListaProfessor_Aluno[I].Nota_2_Bimestre, FListaProfessor_Aluno[I].Nota_3_Bimestre, FListaProfessor_Aluno[I].Nota_4_Bimestre));

      Cells[2, (I + 1)] := FormatFloat('0.00', ICalcularMenor.Calcular(FListaProfessor_Aluno[I].Nota_1_Bimestre,
      FListaProfessor_Aluno[I].Nota_2_Bimestre, FListaProfessor_Aluno[I].Nota_3_Bimestre, FListaProfessor_Aluno[I].Nota_4_Bimestre));

      Cells[3, (I + 1)] := FormatFloat('0.00', ICalcularMedia.Calcular(FListaProfessor_Aluno[I].Nota_1_Bimestre,
      FListaProfessor_Aluno[I].Nota_2_Bimestre, FListaProfessor_Aluno[I].Nota_3_Bimestre, FListaProfessor_Aluno[I].Nota_4_Bimestre));
    end;
  end;
end;

procedure TFrmNotasAlunoDoProfessor.FormCreate(Sender: TObject);
begin
  FProfessor_AlunoController := TProfessor_AlunoController.Create;
  FListaProfessor_Aluno := TObjectList<TProfessor_Aluno>.Create;

  ICalcularMaior := TCalculoMaior.Create;
  ICalcularMenor := TCalculoMenor.Create;
  ICalcularMedia := TCalcularMedia.Create;
end;

procedure TFrmNotasAlunoDoProfessor.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FProfessor_AlunoController);
  FreeAndNil(FListaProfessor_Aluno);
end;

procedure TFrmNotasAlunoDoProfessor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE  then
    Close;
end;

end.
