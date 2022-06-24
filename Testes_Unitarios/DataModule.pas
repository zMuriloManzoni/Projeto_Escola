unit DataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TdmTestes = class(TDataModule)
    FDConnection1: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmTestes: TdmTestes;
  Conexao: TFDConnection;

implementation

uses
  Vcl.Forms;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmTestes.DataModuleCreate(Sender: TObject);
begin
  Try
    Conexao := TFDConnection.Create(nil);
    Conexao.Params.DriverID := 'FB';
    Conexao.Params.Database := ExtractFilePath(Application.ExeName) + 'DataBaseTeste\PROJETO_ESCOLA_TESTE.FDB';
    Conexao.Params.UserName := 'SYSDBA';
    Conexao.Params.Password := 'masterkey';
    Conexao.Connected := true;
  Except
    raise exception.Create('Erro ao conectar ao banco de dados!');
  End;
end;

end.
