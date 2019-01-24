object RTTIPrinc: TRTTIPrinc
  Left = 0
  Top = 0
  Caption = 'DevConfViasoft'
  ClientHeight = 540
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 447
    Height = 73
    Align = alTop
    TabOrder = 0
  end
  object Memo1: TMemo
    Left = 0
    Top = 73
    Width = 447
    Height = 467
    Align = alClient
    TabOrder = 1
    ExplicitHeight = 128
  end
  object btnCriaObjs: TButton
    Left = 103
    Top = 25
    Width = 75
    Height = 25
    Caption = 'Cria Objetos'
    TabOrder = 2
    OnClick = btnCriaObjsClick
  end
  object btnReadRTTI: TButton
    Left = 208
    Top = 25
    Width = 105
    Height = 25
    Caption = 'Ler RTTI'
    TabOrder = 3
    OnClick = btnReadRTTIClick
  end
end
