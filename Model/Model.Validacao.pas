unit Model.Validacao;

interface
Type
  IValidacao = Interface
    ['{6DC36414-669A-4379-AC86-8A9B232A12E6}']

    function ValidarCaracteres(ATexto: String;Var AKey: Char): Boolean;
    function ValidarValorNota(AValor: Currency): Boolean;
    function ValidarCPF(ATexto: String): Boolean;
    function ValidarEmail(ATexto: String): Boolean;
  end;

  TValidar = Class(TInterfacedObject, IValidacao)

    function ValidarCaracteres(ATexto: String;Var AKey: Char): Boolean;
    function ValidarValorNota(AValor: Currency): Boolean;
    function ValidarCPF(ATexto: String): Boolean;
    function ValidarEmail(ATexto: String): Boolean;
  end;


implementation

uses
  System.SysUtils;

{ TValidar }

//Validar Caracteres permitidos nos campos Nota
function TValidar.ValidarCaracteres(ATexto: String; var AKey: Char): Boolean;
begin
  if (not (AKey in ['0'..'9',',',#8])) or ((pos(',',ATexto) > 0) and (AKey = ',')) then
    AKey := #0;
end;

//Validação de CPF
function TValidar.ValidarCPF(ATexto: String): Boolean;
var
  dig10, dig11: string;
  s, i, r, peso: integer;
begin
  if ((ATexto = '00000000000') or (ATexto = '11111111111') or
      (ATexto = '22222222222') or (ATexto = '33333333333') or
      (ATexto = '44444444444') or (ATexto = '55555555555') or
      (ATexto = '66666666666') or (ATexto = '77777777777') or
      (ATexto = '88888888888') or (ATexto = '99999999999') or
      (length(ATexto) <> 11))
  then
  begin
    Result := false;
    exit;
  end;

  try
    s := 0;
    peso := 10;

    for i := 1 to 9 do
    begin
      s := s + (StrToInt(ATexto[i]) * peso);
      peso := peso - 1;
    end;

    r := 11 - (s mod 11);

    if ((r = 10) or (r = 11))then
      dig10 := '0'
    else
      str(r:1, dig10);

    s := 0;
    peso := 11;

    for i := 1 to 10 do
    begin
      s := s + (StrToInt(ATexto[i]) * peso);
      peso := peso - 1;
    end;

    r := 11 - (s mod 11);

    if ((r = 10) or (r = 11)) then
      dig11 := '0'
    else
      str(r:1, dig11);

    if ((dig10 = ATexto[10]) and (dig11 = ATexto[11])) then
      Result := true
    else
      Result := false;

  except
    Result := false
  end;
end;

//Validação de Email
function TValidar.ValidarEmail(ATexto: String): Boolean;
begin
  ATexto := Trim(UpperCase(ATexto));

  if Pos('@', ATexto) > 1 then
  begin
    Delete(ATexto, 1, pos('@', ATexto));
    Result := (Length(ATexto) > 0) and (Pos('.', ATexto) > 2);
  end
  else
    Result := False;
end;

//Validação do valor máximo da Nota
function TValidar.ValidarValorNota(AValor: Currency): Boolean;
begin
  if AValor <= 10 then
    Result := True
  else
    Result := False;
end;

end.
