object FrmMenuPrincipal: TFrmMenuPrincipal
  Left = 0
  Top = 0
  Align = alCustom
  BorderStyle = bsDialog
  Caption = 'Menu Principal'
  ClientHeight = 233
  ClientWidth = 301
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 301
    Height = 233
    Align = alClient
    TabOrder = 0
    object btnProfessores: TButton
      Left = 72
      Top = 128
      Width = 145
      Height = 25
      Caption = 'Cadastro de professores'
      TabOrder = 1
      OnClick = btnProfessoresClick
    end
    object btnAlunos: TButton
      Left = 72
      Top = 64
      Width = 145
      Height = 25
      Caption = 'Cadastro de Alunos'
      TabOrder = 0
      OnClick = btnAlunosClick
    end
  end
end
