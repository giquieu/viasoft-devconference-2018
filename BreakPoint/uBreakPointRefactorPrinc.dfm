object BreakPointRefactorPrinc: TBreakPointRefactorPrinc
  Left = 0
  Top = 0
  Caption = 'BreakPointRefactorPrinc'
  ClientHeight = 201
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 40
    Top = 64
    Width = 169
    Height = 57
    Caption = 'Arrastar Break'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 240
    Top = 64
    Width = 169
    Height = 57
    Caption = 'Break Properties'
    TabOrder = 1
    OnClick = Button2Click
  end
  object cds: TClientDataSet
    PersistDataPacket.Data = {
      4C0000009619E0BD0100000018000000030000000000030000004C0002494404
      00010000000000044E4F4D450100490000000100055749445448020002003C00
      05494441444504000100000000000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 272
    Top = 136
    object cdsID: TIntegerField
      FieldName = 'ID'
    end
    object cdsNOME: TStringField
      FieldName = 'NOME'
      Size = 60
    end
    object cdsIDADE: TIntegerField
      FieldName = 'IDADE'
    end
  end
end
