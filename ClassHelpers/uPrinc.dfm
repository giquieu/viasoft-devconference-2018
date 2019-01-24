object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'TheDevConf Viasoft'
  ClientHeight = 201
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object btnExemplo1: TButton
    Left = 32
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Exemplo 1'
    TabOrder = 0
    OnClick = btnExemplo1Click
  end
  object btnExemplo2: TButton
    Left = 32
    Top = 55
    Width = 75
    Height = 25
    Caption = 'Exemplo 2'
    TabOrder = 1
    OnClick = btnExemplo2Click
  end
  object edtEx2: TEdit
    Left = 120
    Top = 58
    Width = 257
    Height = 21
    DoubleBuffered = True
    NumbersOnly = True
    ParentDoubleBuffered = False
    TabOrder = 2
    Text = '3,14159265358979323846264338327950288'
  end
  object btnExemplo3: TButton
    Left = 32
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Exemplo 3'
    TabOrder = 3
    OnClick = btnExemplo3Click
  end
  object cbEx3: TComboBox
    Left = 120
    Top = 90
    Width = 81
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 4
    Text = 'Truncar'
    Items.Strings = (
      'Truncar'
      'Arredondar')
  end
end
