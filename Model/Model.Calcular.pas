unit Model.Calcular;

interface
Type
  ICalculo = Interface
    ['{3BDB93B3-F1EF-4841-80E2-8F6BE8D4BAA6}']

    function  Calcular(Nota1, Nota2, Nota3, Nota4: Currency): Currency;
  End;

  TCalcularMedia = Class(TInterfacedObject, ICalculo)

    function Calcular(Nota1, Nota2, Nota3, Nota4: Currency): Currency;
  End;

  TCalculoMaior = Class(TInterfacedObject, ICalculo)

    function Calcular(Nota1, Nota2, Nota3, Nota4: Currency): Currency;
  End;

  TCalculoMenor = Class(TInterfacedObject, ICalculo)

    function Calcular(Nota1, Nota2, Nota3, Nota4: Currency): Currency;
  End;

implementation

{ TCalcularMedia }

function TCalcularMedia.Calcular(Nota1, Nota2, Nota3,
  Nota4: Currency): Currency;
begin
  Result := ((Nota1 + Nota2 + Nota3 + Nota4) / 4);
end;

{ TCalculoMaior }

function TCalculoMaior.Calcular(Nota1, Nota2, Nota3, Nota4: Currency): Currency;
var
  I: Integer;
  NotaAtual, MaiorNota: Currency;
begin
  MaiorNota := 0;
  for I := 0 to 3 do
  begin
    case I of
      0: NotaAtual := Nota1;
      1: NotaAtual := Nota2;
      2: NotaAtual := Nota3;
      3: NotaAtual := Nota4;
    end;

    if NotaAtual > MaiorNota then
      MaiorNota := NotaAtual;
  end;

  Result := MaiorNota;
end;

{ TCalculoMenor }

function TCalculoMenor.Calcular(Nota1, Nota2, Nota3, Nota4: Currency): Currency;
var
  I: Integer;
  NotaAtual, MenorNota: Currency;
begin
  MenorNota := -1;
  for I := 0 to 3 do
  begin
    case I of
      0: NotaAtual := Nota1;
      1: NotaAtual := Nota2;
      2: NotaAtual := Nota3;
      3: NotaAtual := Nota4;
    end;

    if (NotaAtual < MenorNota) or (MenorNota = -1) then
      MenorNota := NotaAtual;
  end;

  Result := MenorNota;
end;

end.
