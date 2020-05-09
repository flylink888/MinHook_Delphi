object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 410
  ClientWidth = 634
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 195
    Top = 249
    Width = 75
    Height = 25
    Caption = 'Hook1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 387
    Top = 249
    Width = 75
    Height = 25
    Caption = 'Hook2'
    TabOrder = 1
    OnClick = Button2Click
  end
end
