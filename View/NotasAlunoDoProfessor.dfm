object FrmNotasAlunoDoProfessor: TFrmNotasAlunoDoProfessor
  Left = 0
  Top = 0
  Align = alCustom
  BorderStyle = bsDialog
  Caption = 'Notas dos alunos do professor(a) '
  ClientHeight = 477
  ClientWidth = 607
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object grdNotas: TStringGrid
    Left = 0
    Top = 0
    Width = 607
    Height = 477
    Align = alClient
    ColCount = 4
    DefaultRowHeight = 25
    DrawingStyle = gdsGradient
    FixedColor = clAqua
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    TabOrder = 0
  end
end
