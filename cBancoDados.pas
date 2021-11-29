unit cBancoDados;

interface
uses
 Vcl.Grids, System.SysUtils, Vcl.Dialogs, Vcl.StdCtrls , Data.DB, Data.Win.ADODB;

type TBancoDados = class
   private

   public
    procedure Clientes(nCombo: TComboBox; nTabela: TADOQuery);
    procedure Produtos(nCombo: TComboBox; nTabela: TADOQuery);
    function NumPedido(nTabela: TADOQuery):String;
    procedure Insert(Pedido: String; Cod_Cliente: String; Total: String;
    Grade: TStringGrid; nTabela: TADOQuery);
    procedure Update(Pedido: String; Total: String;
    Grade: TStringGrid; nTabela: TADOQuery);
    procedure Delete(Pedido: String; nTabela: TADOQuery);
    procedure Open(Pedido: String; Cliente: TComboBox; Cod_Cliente,Cidade,UF,Valor: TEdit;
    Grade: TStringGrid; nTabela: TADOQuery);
 end;

implementation

procedure TBancoDados.Open(Pedido: String; Cliente: TComboBox; Cod_Cliente,Cidade,UF,Valor: TEdit;
    Grade: TStringGrid; nTabela: TADOQuery);
var
 sqltext: string;
 tCod_Cliente: string;
 i:integer;
begin
 try
   //Carregar  Dados do Pedido
   sqltext := 'select * FROM wk_teste.tbpedidodadosgerais WHERE (Num_Pedido = ''' + Pedido + ''')';
   nTabela.Close;
   nTabela.SQL.Text:=sqltext;
   nTabela.Open;
   if not nTabela.Eof then
   begin
     tCod_Cliente := nTabela.FieldByName('Cod_Cliente').Text;
     Valor.Text := nTabela.FieldByName('Valor_Total').Text;
   end;

   //Carregar Dados do Cliente
   sqltext := 'select * FROM wk_teste.tbclientes WHERE (Cod_Cliente = ''' + tCod_Cliente + ''')';
   nTabela.Close;
   nTabela.SQL.Text:=sqltext;
   nTabela.Open;
   Cliente.Text := nTabela.FieldByName('Nome').Text;
   Cod_Cliente.Text := nTabela.FieldByName('Cod_Cliente').Text;
   Cidade.Text := nTabela.FieldByName('Cidade').Text;
   UF.Text := nTabela.FieldByName('UF').Text;

   //Carregar Tabela de Produtos
   sqltext := 'select * FROM wk_teste.tbpedidoprodutos WHERE (Num_Pedido = ''' + Pedido + ''')';
   nTabela.Close;
   nTabela.SQL.Text:=sqltext;
   nTabela.Open;
   i := 1;
   if not nTabela.Eof then
   begin
     nTabela.First;
     while not nTabela.Eof do
     begin
       with Grade do
        begin
          RowCount := i+1;
          Cells[0,i] := nTabela.FieldByName('Cod_Produto').Text;
          Cells[2,i] := nTabela.FieldByName('QTD').Text;
          Cells[3,i] := nTabela.FieldByName('Valor_Unit').Text;
          Cells[4,i] := nTabela.FieldByName('Valor_Total').Text;
        end;
       nTabela.Next;
       i := i + 1;
     end;
   end;
   //Carregar Descrição dos Produtos
   with Grade do
     begin
      for i:= 1 to RowCount-1 do
      begin
       sqltext := 'select * FROM wk_teste.tbprodutos WHERE (Cod_Produto = ''' + Cells[0,i] + ''')';
       nTabela.Close;
       nTabela.SQL.Text:=sqltext;
       nTabela.Open;
       if not nTabela.Eof then
        Cells[1,i] := nTabela.FieldByName('Descricao').Text;
      end;
    end;

 except
    on e: EADOError do
    begin
      MessageDlg('Erro ao encontrar dados', mtError, [mbOK], 0);
      Exit;
    end;
 end;
end;

procedure TBancoDados.Delete(Pedido: String; nTabela: TADOQuery);
var
 sqltext: string;
begin
 try
   //Deleta Pedido da Tabela Pedido Dados Gerais
   sqltext := 'DELETE FROM wk_teste.tbpedidodadosgerais WHERE (Num_Pedido = ''' + Pedido + ''')';
   ntabela.Close;
   nTabela.SQL.Text:=sqltext;
   nTabela.ExecSQL;
   //Deleta Pedido da Tabela Pedido Produtos
   sqltext := 'DELETE FROM wk_teste.tbpedidoprodutos WHERE (Num_Pedido = ''' + Pedido + ''')';    ntabela.Close;
   ntabela.Close;
   nTabela.SQL.Text:=sqltext;
   nTabela.ExecSQL;
 except
    on e: EADOError do
    begin
      MessageDlg('Erro ao encontrar dados', mtError, [mbOK], 0);
      Exit;
    end;
 end;
end;

procedure TBancoDados.Update(Pedido: String; Total: String;
Grade: TStringGrid; nTabela: TADOQuery);
var
 sqltext: string;
 i,r:integer;
begin
 try
   //Atualiza Tabela Pedido Dados Gerais
   sqltext := 'UPDATE wk_teste.tbpedidodadosgerais SET ';
   sqltext := sqltext + 'Valor_Total = ' + StringReplace(Total, ',', '.', []);
   sqltext := sqltext + ' WHERE (Num_Pedido = ''' + Pedido + ''')';
   ntabela.Close;
   nTabela.SQL.Text:=sqltext;
   nTabela.ExecSQL;
   //Atualiza Tabela Pedido Produtos
   sqltext := 'SELECT * FROM tbpedidoprodutos WHERE Num_Pedido = ''' + Pedido + '''';
   ntabela.Close;
   nTabela.SQL.Text:=sqltext;
   nTabela.Open;
   r := nTabela.RecordCount;
    with Grade do
    begin
      for i:= 1 to RowCount-1 do
        begin
        if i < r then
        begin
          sqltext := 'UPDATE wk_teste.tbpedidoprodutos SET ';
          sqltext := sqltext + ' Cod_Produto = ''' + Cells[0,i] + ''',';
          sqltext := sqltext + ' QTD = ' + StringReplace(Cells[2,i], ',', '.', []) + ',';
          sqltext := sqltext + ' Valor_Unit = ' + StringReplace(Cells[3,i], ',', '.', []) + ',';
          sqltext := sqltext + ' Valor_Total = ' + StringReplace(Cells[4,i], ',', '.', []);
          sqltext := sqltext + ' WHERE (Num_Pedido = ''' + Pedido + ''')';
          ntabela.Close;
          nTabela.SQL.Text:=sqltext;
          nTabela.ExecSQL;
       end
       else
       begin
           sqltext := 'INSERT INTO wk_teste.tbpedidoprodutos(Num_Pedido, Cod_Produto, QTD, Valor_Unit, Valor_Total) VALUES (''';
           sqltext := sqltext  + Pedido + ''',''' + Cells[0,i] + ''',' + Cells[2,i] + ',' + StringReplace(Cells[3,i], ',', '.', []) + ',' + StringReplace(Cells[4,i], ',', '.', []) + ')';
           ntabela.Close;
           nTabela.SQL.Text:=sqltext;
           nTabela.ExecSQL;
       end;
     end;
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

procedure TBancoDados.Insert(Pedido: String; Cod_Cliente: String; Total: String;
Grade: TStringGrid; nTabela: TADOQuery);
var
 sqltext: string;
 Data: string;
 i:integer;
begin
  try
    //Gravar Tabela Pedido Dados Gerais
    Data := FormatDateTime('dd/mm/yyyy', Now);
    sqltext := 'INSERT INTO wk_teste.tbpedidodadosgerais(Num_Pedido, Data_Emissao, Cod_Cliente, Valor_Total) VALUES (''';
    sqltext := sqltext +  Pedido + ''',''' + Data + ''',''' + Cod_Cliente + ''',' + StringReplace(Total, ',', '.', []) + ')';
    ntabela.Close;
    nTabela.SQL.Text:=sqltext;
    nTabela.ExecSQL;
    //Gravar Tabela Pedido Produtos
    with Grade do
     begin
      for i:= 1 to RowCount-1 do
      begin
       sqltext := 'INSERT INTO wk_teste.tbpedidoprodutos(Num_Pedido, Cod_Produto, QTD, Valor_Unit, Valor_Total) VALUES (''';
       sqltext := sqltext  + Pedido + ''',''' + Cells[0,i] + ''',' + Cells[2,i] + ',' + StringReplace(Cells[3,i], ',', '.', []) + ',' + StringReplace(Cells[4,i], ',', '.', []) + ')';
       ntabela.Close;
       nTabela.SQL.Text:=sqltext;
       nTabela.ExecSQL;
      end;
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

function TBancoDados.NumPedido(nTabela: TADOQuery):String;
 begin
   ntabela.Close;
   nTabela.SQL.Text:='select * from wk_teste.tbpedidodadosgerais';
   nTabela.Open;
   if not nTabela.Eof then
   begin
     nTabela.Last;
     result := floattostr(strtofloat(nTabela.FieldByName('Num_Pedido').Text)+1);
   end
   else
    result:='00001';
 end;

 procedure TBancoDados.Clientes(nCombo: TComboBox; nTabela: TADOQuery);
 var
   tCampo: string;
 begin
   ntabela.Close;
   nTabela.SQL.Text:='select * from wk_teste.tbclientes';
   nTabela.Open;
   if not nTabela.Eof then
   begin
     nTabela.First;
     while not nTabela.Eof do
     begin
       tCampo:=nTabela.FieldByName('Nome').Text;
       nCombo.Items.Add(tCampo);
       nTabela.Next;
     end;

   end;
 end;

 procedure TBancoDados.Produtos(nCombo: TComboBox; nTabela: TADOQuery);
 var
   tCampo: string;
 begin
   ntabela.Close;
   nTabela.SQL.Text:='select * from wk_teste.tbprodutos';
   nTabela.Open;
   if not nTabela.Eof then
   begin
     nTabela.First;
     while not nTabela.Eof do
     begin
       tCampo:=nTabela.FieldByName('Cod_Produto').Text;
       nCombo.Items.Add(tCampo);
       nTabela.Next;
     end;

   end;
 end;
end.
