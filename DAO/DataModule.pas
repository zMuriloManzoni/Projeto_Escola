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
  TdmPrincipal = class(TDataModule)
    conConnect: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmPrincipal: TdmPrincipal;
  Conexao: TFDConnection;

implementation

uses
  Vcl.Dialogs, Vcl.Forms;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmPrincipal.DataModuleCreate(Sender: TObject);
begin
  Try
    Conexao := TFDConnection.Create(nil);
    Conexao.Params.DriverID := 'FB';
    Conexao.Params.Database := ExtractFilePath(Application.ExeName) + 'DataBase\PROJETO_ESCOLA.FDB';
    Conexao.Params.UserName := 'SYSDBA';
    Conexao.Params.Password := 'masterkey';
    Conexao.Connected := true;
  Except
    raise exception.Create('Erro ao conectar ao banco de dados!');
  End;
end;

procedure TdmPrincipal.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(Conexao);
end;

end.
