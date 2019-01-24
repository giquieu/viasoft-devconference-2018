object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'DevConfViasoft'
  ClientHeight = 405
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 447
    Height = 129
    Align = alTop
    TabOrder = 0
    object lbl1: TLabel
      Left = 48
      Top = 16
      Width = 35
      Height = 13
      Caption = 'Roedor'
    end
    object ebAltura: TLabeledEdit
      Left = 88
      Top = 62
      Width = 121
      Height = 21
      EditLabel.Width = 29
      EditLabel.Height = 13
      EditLabel.Caption = 'Altura'
      LabelPosition = lpLeft
      LabelSpacing = 8
      TabOrder = 2
      Text = '0,60'
    end
    object ebComprimento: TLabeledEdit
      Left = 88
      Top = 89
      Width = 121
      Height = 21
      EditLabel.Width = 63
      EditLabel.Height = 13
      EditLabel.Caption = 'Comprimento'
      LabelPosition = lpLeft
      LabelSpacing = 8
      TabOrder = 3
      Text = '0,85'
    end
    object cbbRoedor: TComboBox
      Left = 88
      Top = 8
      Width = 121
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'Capivara'
      Items.Strings = (
        'Capivara'
        'Cutia'
        'Paca'
        'Porquinho-da-'#237'ndia'
        'Pre'#225)
    end
    object btnAdd: TButton
      Left = 215
      Top = 8
      Width = 156
      Height = 48
      Caption = 'Add'
      TabOrder = 4
      OnClick = btnAddClick
    end
    object ebPeso: TLabeledEdit
      Left = 88
      Top = 35
      Width = 121
      Height = 21
      EditLabel.Width = 23
      EditLabel.Height = 13
      EditLabel.Caption = 'Peso'
      LabelPosition = lpLeft
      LabelSpacing = 8
      TabOrder = 1
      Text = '5'
    end
    object btnEdit: TButton
      Left = 215
      Top = 58
      Width = 156
      Height = 25
      Caption = 'Edit'
      TabOrder = 5
      OnClick = btnEditClick
    end
  end
  object dbGrid: TDBGrid
    Left = 0
    Top = 129
    Width = 447
    Height = 276
    Align = alClient
    DataSource = ds
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = dbGridCellClick
  end
  object ds: TDataSource
    DataSet = cds
    Left = 224
    Top = 176
  end
  object cds: TClientDataSet
    PersistDataPacket.Data = {
      700000009619E0BD010000001800000005000000000003000000700002494404
      0001000000000006526F65646F72010049000000010005574944544802000200
      1400045065736F080004000000000006416C7475726108000400000000000B43
      6F6D7072696D656E746F08000400000000000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 272
    Top = 176
    object IntegerField1: TIntegerField
      FieldName = 'ID'
    end
    object StringField1: TStringField
      FieldName = 'Roedor'
    end
    object FloatField1: TFloatField
      FieldName = 'Peso'
    end
    object FloatField2: TFloatField
      FieldName = 'Altura'
    end
    object FloatField3: TFloatField
      FieldName = 'Comprimento'
    end
  end
end
