object FrmNumPedido: TFrmNumPedido
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Pedido'
  ClientHeight = 109
  ClientWidth = 189
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
  object LblMsg: TLabel
    Left = 16
    Top = 8
    Width = 141
    Height = 13
    Caption = 'Informe o N'#250'mero do Pedido.'
  end
  object TxtPedido: TEdit
    Left = 16
    Top = 27
    Width = 155
    Height = 41
    Alignment = taRightJustify
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    Text = '0'
  end
  object BtnOk: TButton
    Left = 96
    Top = 74
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 1
    OnClick = BtnOkClick
  end
  object SQLConect: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=MSDASQL.1;Password=P@13out1981;Persist Security Info=Tr' +
      'ue;User ID=root;Data Source=MYSQL ODBCE;Initial Catalog=wk_teste'
    DefaultDatabase = 'wk_teste'
    LoginPrompt = False
    Left = 17
    Top = 73
  end
  object MySQL: TADOQuery
    Connection = SQLConect
    Parameters = <>
    Left = 57
    Top = 73
  end
end
