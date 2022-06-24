unit SistemaMensagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TipoMensagem = (tmConfirmacao, tmAlerta);

  TFrmSistemaMensagem = class(TForm)
    pnlAlerta: TPanel;
    lblMsgAlerta: TLabel;
    btnBtnOk: TBitBtn;
    pnlConfirmacao: TPanel;
    lblMensagem: TLabel;
    btnSalvar: TBitBtn;
    btnCancelar: TBitBtn;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnBtnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    Resultado: Boolean;

  public
    function Abrir(AMensagem: String; ATipoMensagem: TipoMensagem): Boolean;
  end;

var
  FrmSistemaMensagem: TFrmSistemaMensagem;

implementation

{$R *.dfm}

{ TFrmSistemaMensagem }

function TFrmSistemaMensagem.Abrir(AMensagem: String;
  ATipoMensagem: TipoMensagem): Boolean;
begin
  Try
    with FrmSistemaMensagem do
    begin
      FrmSistemaMensagem := TFrmSistemaMensagem.Create(Application);

      case ATipoMensagem of
        tmConfirmacao:begin
                        pnlConfirmacao.Visible := True;
                        lblMensagem.Caption := AMensagem;
                      end;
        tmAlerta:begin
                   pnlAlerta.Visible := True;
                   lblMsgAlerta.Caption := AMensagem;
                 end;
      end;

      ShowModal;

      Result := Resultado;
    end;
  Finally
    FreeAndNil(FrmSistemaMensagem);
  End;
end;

procedure TFrmSistemaMensagem.btnBtnOkClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmSistemaMensagem.btnCancelarClick(Sender: TObject);
begin
  Resultado := False;
  Close;
end;

procedure TFrmSistemaMensagem.btnSalvarClick(Sender: TObject);
begin
  Resultado := True;
  Close;
end;

procedure TFrmSistemaMensagem.FormCreate(Sender: TObject);
begin
  Resultado := False;
end;

procedure TFrmSistemaMensagem.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

end.
