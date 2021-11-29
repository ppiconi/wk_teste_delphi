unit Terminal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
  Data.FMTBcd, Data.DB, Data.Win.ADODB, Vcl.ComCtrls, Vcl.DBCtrls,
  Vcl.Mask, Vcl.ExtCtrls;

type
  TFrmPedido = class(TForm)
    GrdProdutos: TStringGrid;
    LblProdutos: TLabel;
    SQLConect: TADOConnection;
    MySQL: TADOQuery;
    PnlPedido: TPanel;
    TxtPedido: TEdit;
    LblPedido: TLabel;
    PnlCliente: TPanel;
    LblCliente: TLabel;
    PnlDadosCliente: TPanel;
    Label1: TLabel;
    TxtCod_Cliente: TEdit;
    Label2: TLabel;
    TxtCidade: TEdit;
    Label3: TLabel;
    TxtUF: TEdit;
    PnlDadosProdutos: TPanel;
    TxtValor_Unit: TEdit;
    TxtQTD: TEdit;
    LbdCod_Produto: TLabel;
    LblQTD: TLabel;
    LblValor_Unit: TLabel;
    BtnAdcionar: TButton;
    PnlTotal: TPanel;
    LblValor_Total: TLabel;
    TxtValor_Total: TEdit;
    TxtProdutos: TComboBox;
    TxtCliente: TComboBox;
    LblData: TLabel;
    LblHora: TLabel;
    TmrRelogio: TTimer;
    BtnAbrir: TButton;
    BtnCancelar: TButton;
    BtnGravar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BtnAdcionarClick(Sender: TObject);
    procedure TxtProdutosClick(Sender: TObject);
    procedure GrdProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure GrdProdutosSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GrdProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TxtClienteClick(Sender: TObject);
    procedure TmrRelogioTimer(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnAbrirClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Clear();
    procedure Verificar();
    procedure Carregar(tPedido: String);
  end;

var
  FrmPedido: TFrmPedido;
  Pedido, Descricao, V_Unit, V_Total: String;
  Coluna,Linha: Integer;
  ModoEditar: Integer;

implementation

uses
 uProdutos, uClientes, cBancoDados, NumPedido;

var
 Grd: TProdutos;
 Dbs: TBancoDados;
 Cli: TClientes;

{$R *.dfm}


procedure TFrmPedido.BtnAbrirClick(Sender: TObject);
begin
  FrmNumPedido.Caption:='Abrir Pedido';
  FrmNumPedido.ShowModal;
end;

procedure TFrmPedido.BtnAdcionarClick(Sender: TObject);
var
 SqlText : String;
 Row : Integer;
begin
 try
  if ModoEditar = 0 then
   begin
     Row:=GrdProdutos.RowCount + 1;
     GrdProdutos.RowCount := Row;
     GrdProdutos.Cells[0,Row-1] := TxtProdutos.Text;
     GrdProdutos.Cells[1,Row-1] := Descricao;
     GrdProdutos.Cells[2,Row-1] := TxtQTD.Text;
     GrdProdutos.Cells[3,Row-1] := TxtValor_Unit.Text;
     V_Unit:=floattostr(strtofloat(TxtQTD.Text) * strtofloat(TxtValor_Unit.Text));
     GrdProdutos.Cells[4,Row-1] := V_Unit;
     TxtValor_Total.Text := grd.Total(GrdProdutos);
   end
   else
   begin
     ModoEditar:=0;
     LblProdutos.Caption:='PRODUTOS';
     PnlCliente.Enabled :=True;
     PnlDadosCliente.Enabled :=True;
     PnlDadosProdutos.Enabled :=True;
     TxtValor_Total.Text := grd.Total(GrdProdutos);
     GrdProdutos.Options:=GrdProdutos.Options + [goRowSelect];
     GrdProdutos.Options := GrdProdutos.Options - [goEditing];
   end;
  except
    on e: EADOError do
    begin
      MessageDlg('Erro ao encontrar dados', mtError,
                  [mbOK], 0);
      Exit;
    end;
  end;

end;

procedure TFrmPedido.BtnCancelarClick(Sender: TObject);
begin
  FrmNumPedido.Caption:='Cancelar Pedido';
  FrmNumPedido.ShowModal;
end;

procedure TFrmPedido.BtnGravarClick(Sender: TObject);
begin
 if MessageDlg('Deseja gravar o Pedidos?',
         mtConfirmation,[mbYes,mbNo],0) = mrYes then
 begin
   if TxtPedido.Text = Pedido then
    Dbs.Insert(TxtPedido.Text, TxtCod_Cliente.Text,TxtValor_Total.Text,GrdProdutos,MySQL)
   else
    Dbs.Update(TxtPedido.Text,TxtValor_Total.Text,GrdProdutos,MySQL);
  Clear;
 end;
end;

procedure TFrmPedido.FormCreate(Sender: TObject);
begin
  //Inicializando Cabeçado da Tabela Produtos
  Grd.Header(GrdProdutos);
  //Preencher ComboBox Cliente e Produtos
  Dbs.Clientes(TxtCliente, MySQL);
  Dbs.Produtos(TxtProdutos, MySQL);
  //Data Atual
  LblData.Caption:=FormatDateTime('dd/mm/yyyy', Now);
  //Carrega Numero do Pedido Atual
  Clear;
end;

procedure TFrmPedido.GrdProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key= vk_delete then
  begin
    if ModoEditar=0 then
    begin
      if MessageDlg('Deseja relamente excluir esse Produto?',
         mtConfirmation,[mbYes,mbNo],0) = mrYes then
       Grd.ApagarLinha(GrdProdutos,Linha);
       TxtValor_Total.Text := grd.Total(GrdProdutos);
    end;
  end;

end;

procedure TFrmPedido.GrdProdutosKeyPress(Sender: TObject; var Key: Char);
begin
 if key=#13 then
  begin
    if ModoEditar = 0 then
     begin
       LblProdutos.Caption:='MODO DE EDIÇÃO DE PRODUTOS ATIVADO - PARA FINALIZAR CLIQUE NO BOTÃO ADICIONAR!';
       PnlCliente.Enabled :=False;
       PnlDadosCliente.Enabled :=False;
       PnlDadosProdutos.Enabled :=False;
       ModoEditar:=1;
       GrdProdutos.Options:=GrdProdutos.Options - [goRowSelect];
       GrdProdutos.Col:=1;
       GrdProdutos.Options := GrdProdutos.Options + [goEditing];
     end
    else
     begin
      if ((Coluna=1) or (Coluna=2)) then
       begin
       GrdProdutos.Col:=Coluna;
       GrdProdutos.Options := GrdProdutos.Options + [goEditing];
       end
       else
       begin
         GrdProdutos.Options := GrdProdutos.Options - [goEditing];
       end;
     end;
  end;
end;

procedure TFrmPedido.GrdProdutosSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
try
   Coluna:=ACol;
   Linha:=ARow;
except
  Exit;
end;
end;

procedure TFrmPedido.TmrRelogioTimer(Sender: TObject);
begin
  LblHora.Caption:=FormatDateTime('hh:MM:ss', Now);
  Verificar;
end;

procedure TFrmPedido.TxtClienteClick(Sender: TObject);
var
 SqlText : String;
 Unitario: Double;
 Valor: String;
begin
 try
  SqlText:='select * from tbclientes where Nome Like ''' + TxtCliente.Text + '''';
  MySQL.SQL.Text:=SqlText;
  MySQL.Open;
  TxtCod_Cliente.Text:=MySQL.FieldByName('Cod_Cliente').Text;
  TxtCidade.Text:=MySQL.FieldByName('Cidade').Text;
  TxtUF.Text:=MySQL.FieldByName('UF').Value;
  MySQL.Close;
 except
  Exit;
 end;

end;

procedure TFrmPedido.TxtProdutosClick(Sender: TObject);
var
 SqlText : String;
 Unitario: Double;
 Valor: String;
begin
 SqlText:='select * from tbprodutos where Cod_Produto = ''' + TxtProdutos.Text + '''';
 MySQL.SQL.Text:=SqlText;
 MySQL.Open;
 TxtQTD.Text:='1';
 Descricao:=MySQL.FieldByName('Descricao').Text;
 TxtValor_Unit.Text:=MySQL.FieldByName('Preco_Venda').Text;
 Unitario:=MySQL.FieldByName('Preco_Venda').Value;
 MySQL.Close;
end;

//Limpar Dados do Pedido
procedure TFrmPedido.Clear();
begin
  TxtCliente.Text := '';
  TxtCod_Cliente.Text := '';
  TxtCidade.Text := '';
  TxtUF.Text := '';
  TxtProdutos.Text := '';
  TxtQTD.Text := '1';
  TxtValor_Unit.Text := '0,00';
  TxtValor_Total.Text := '0,00';
  GrdProdutos.RowCount := 1;
  Pedido := Dbs.NumPedido(MySQL);
  TxtPedido.Text := Pedido;
end;
//Abilita Inserir Produtos e exibe o botão Gravar se Campo Cliente estiver Preenchido
procedure TFrmPedido.Verificar();
begin
  if TxtCliente.Text <> EmptyStr then
  begin
    BtnGravar.Visible := True;
    BtnAbrir.Visible := False;
    BtnCancelar.Visible := False;
    PnlDadosProdutos.Enabled := True;
  end
  else
  begin
    BtnGravar.Visible := False;
    BtnAbrir.Visible := True;
    BtnCancelar.Visible := True;
    PnlDadosProdutos.Enabled := False;
    Clear;
  end;
end;

//Carregar Pedido
procedure TFrmPedido.Carregar(tPedido: String);
begin
  Dbs.Open(tPedido,TxtCliente,TxtCod_Cliente,TxtCidade,TxtUF,TxtValor_Total,GrdProdutos,MySQL);
  TxtPedido.Text := tPedido;
  PnlCliente.Enabled:=False;
  MessageDlg('Pedido Aberto com sucesso!', mtconfirmation,[mbok],0);
end;

end.
