object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'FormMain'
  ClientHeight = 243
  ClientWidth = 626
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
  object LabelPAth: TLabel
    Left = 16
    Top = 70
    Width = 97
    Height = 13
    Caption = 'C:\Temp\Resultado\'
  end
  object ButtonSimpleTask: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Hello'
    TabOrder = 0
    OnClick = ButtonSimpleTaskClick
  end
  object ButtonTask: TButton
    Left = 8
    Top = 39
    Width = 75
    Height = 25
    Caption = 'Task'
    TabOrder = 1
    OnClick = ButtonTaskClick
  end
  object PanelContainer: TPanel
    Left = 149
    Top = 0
    Width = 477
    Height = 243
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 2
    object ScrollBox: TScrollBox
      Left = 0
      Top = 0
      Width = 477
      Height = 121
      HorzScrollBar.Visible = False
      VertScrollBar.Smooth = True
      VertScrollBar.Style = ssFlat
      Align = alClient
      BorderStyle = bsNone
      TabOrder = 0
    end
    object MemoLog: TMemo
      Left = 0
      Top = 121
      Width = 477
      Height = 122
      Align = alBottom
      ScrollBars = ssVertical
      TabOrder = 1
    end
  end
end
