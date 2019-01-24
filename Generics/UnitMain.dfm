object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'Generics'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PanelHeader: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object ButtonGeneric: TButton
      Left = 24
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Generic'
      TabOrder = 0
      OnClick = ButtonGenericClick
    end
    object ButtonLista: TButton
      Left = 136
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Lista'
      TabOrder = 1
      OnClick = ButtonListaClick
    end
    object ButtonListaGeneric: TButton
      Left = 232
      Top = 9
      Width = 153
      Height = 25
      Caption = 'Lista Generic'
      TabOrder = 2
      OnClick = ButtonListaGenericClick
    end
  end
  object MemoLog: TMemo
    Left = 0
    Top = 41
    Width = 635
    Height = 258
    Align = alClient
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
