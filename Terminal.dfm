object FrmPedido: TFrmPedido
  Left = 0
  Top = 0
  Caption = 'Pedido de Vendas'
  ClientHeight = 583
  ClientWidth = 755
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object LblProdutos: TLabel
    Left = 8
    Top = 247
    Width = 59
    Height = 15
    Caption = 'PRODUTOS'
  end
  object LblData: TLabel
    Left = 568
    Top = 42
    Width = 162
    Height = 40
    Caption = '00/00/0000'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LblHora: TLabel
    Left = 568
    Top = 118
    Width = 144
    Height = 24
    Alignment = taCenter
    Caption = '00:00:00'
    Font.Charset = OEM_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Terminal'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object GrdProdutos: TStringGrid
    Left = 8
    Top = 264
    Width = 739
    Height = 185
    Color = clBtnFace
    Ctl3D = False
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    GradientEndColor = clMoneyGreen
    GradientStartColor = clBtnHighlight
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect, goFixedRowDefAlign]
    ParentCtl3D = False
    ScrollBars = ssVertical
    TabOrder = 0
    OnKeyDown = GrdProdutosKeyDown
    OnKeyPress = GrdProdutosKeyPress
    OnSelectCell = GrdProdutosSelectCell
  end
  object PnlPedido: TPanel
    Left = 8
    Top = 8
    Width = 104
    Height = 73
    Enabled = False
    TabOrder = 1
    object LblPedido: TLabel
      Left = 8
      Top = 11
      Width = 84
      Height = 15
      Caption = 'N'#250'mero Pedido'
    end
    object TxtPedido: TEdit
      Left = 8
      Top = 32
      Width = 84
      Height = 23
      Alignment = taRightJustify
      TabOrder = 0
      Text = '0001'
    end
  end
  object PnlCliente: TPanel
    Left = 118
    Top = 8
    Width = 411
    Height = 73
    TabOrder = 2
    object LblCliente: TLabel
      Left = 10
      Top = 11
      Width = 37
      Height = 15
      Caption = 'Cliente'
    end
    object TxtCliente: TComboBox
      Left = 10
      Top = 32
      Width = 385
      Height = 23
      TabOrder = 0
      OnClick = TxtClienteClick
    end
  end
  object PnlDadosCliente: TPanel
    Left = 8
    Top = 87
    Width = 521
    Height = 74
    Enabled = False
    TabOrder = 3
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 79
      Height = 15
      Caption = 'C'#243'digo Cliente'
    end
    object Label2: TLabel
      Left = 98
      Top = 16
      Width = 37
      Height = 15
      Caption = 'Cidade'
    end
    object Label3: TLabel
      Left = 472
      Top = 16
      Width = 14
      Height = 15
      Caption = 'UF'
    end
    object TxtCod_Cliente: TEdit
      Left = 8
      Top = 37
      Width = 84
      Height = 23
      Alignment = taRightJustify
      TabOrder = 0
    end
    object TxtCidade: TEdit
      Left = 98
      Top = 37
      Width = 368
      Height = 23
      TabOrder = 1
    end
    object TxtUF: TEdit
      Left = 472
      Top = 37
      Width = 33
      Height = 23
      Alignment = taRightJustify
      TabOrder = 2
    end
  end
  object PnlDadosProdutos: TPanel
    Left = 8
    Top = 167
    Width = 521
    Height = 74
    TabOrder = 4
    object LbdCod_Produto: TLabel
      Left = 12
      Top = 16
      Width = 102
      Height = 15
      Caption = 'C'#243'digo do Produto'
    end
    object LblQTD: TLabel
      Left = 212
      Top = 16
      Width = 22
      Height = 15
      Caption = 'QTD'
    end
    object LblValor_Unit: TLabel
      Left = 276
      Top = 16
      Width = 71
      Height = 15
      Caption = 'Valor Unit'#225'rio'
    end
    object TxtValor_Unit: TEdit
      Left = 276
      Top = 37
      Width = 121
      Height = 23
      Alignment = taRightJustify
      TabOrder = 0
      Text = '0,00'
    end
    object TxtQTD: TEdit
      Left = 212
      Top = 37
      Width = 58
      Height = 23
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 1
      Text = '1'
    end
    object TxtProdutos: TComboBox
      Left = 12
      Top = 37
      Width = 194
      Height = 23
      AutoCloseUp = True
      TabOrder = 2
      OnClick = TxtProdutosClick
    end
  end
  object BtnAdcionar: TButton
    Left = 429
    Top = 203
    Width = 84
    Height = 25
    Caption = 'Adcionar'
    TabOrder = 5
    OnClick = BtnAdcionarClick
  end
  object PnlTotal: TPanel
    Left = 480
    Top = 470
    Width = 267
    Height = 66
    Enabled = False
    TabOrder = 6
    object LblValor_Total: TLabel
      Left = 8
      Top = 16
      Width = 122
      Height = 32
      Caption = 'Valor Total'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object TxtValor_Total: TEdit
      Left = 136
      Top = 13
      Width = 125
      Height = 40
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = '0,00'
    end
  end
  object BtnAbrir: TButton
    Left = 5
    Top = 550
    Width = 107
    Height = 25
    Caption = 'Abrir Pedido'
    TabOrder = 7
    OnClick = BtnAbrirClick
  end
  object BtnCancelar: TButton
    Left = 118
    Top = 550
    Width = 97
    Height = 25
    Caption = 'Cancelar Pedido'
    TabOrder = 8
    OnClick = BtnCancelarClick
  end
  object BtnGravar: TButton
    Left = 648
    Top = 550
    Width = 99
    Height = 25
    Caption = 'Gravar Pedido'
    TabOrder = 9
    Visible = False
    OnClick = BtnGravarClick
  end
  object SQLConect: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=MSDASQL.1;Password=P@13out1981;Persist Security Info=Tr' +
      'ue;User ID=root;Data Source=MYSQL ODBCE;Initial Catalog=wk_teste'
    DefaultDatabase = 'wk_teste'
    LoginPrompt = False
    Left = 272
    Top = 473
  end
  object MySQL: TADOQuery
    Connection = SQLConect
    Parameters = <>
    Left = 328
    Top = 473
  end
  object TmrRelogio: TTimer
    OnTimer = TmrRelogioTimer
    Left = 600
    Top = 192
  end
end
