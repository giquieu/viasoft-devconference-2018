object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'Anonymous Methods'
  ClientHeight = 360
  ClientWidth = 644
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    644
    360)
  PixelsPerInch = 96
  TextHeight = 13
  object Loop: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Loop'
    TabOrder = 0
    OnClick = LoopClick
  end
  object MemoLoop: TMemo
    Left = 8
    Top = 39
    Width = 297
    Height = 313
    Anchors = [akLeft, akTop, akBottom]
    ScrollBars = ssVertical
    TabOrder = 1
    ExplicitHeight = 308
  end
  object MemoAnonymous: TMemo
    Left = 330
    Top = 39
    Width = 297
    Height = 313
    Anchors = [akLeft, akTop, akBottom]
    ScrollBars = ssVertical
    TabOrder = 2
    ExplicitHeight = 308
  end
  object ButtonAnonymous: TButton
    Left = 330
    Top = 8
    Width = 119
    Height = 25
    Caption = 'Loop Anonymous'
    TabOrder = 3
    OnClick = ButtonAnonymousClick
  end
  object ClientDataSet: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 472
    Top = 72
  end
end
