unit uProdutos;

interface
uses
 Vcl.Grids,System.SysUtils;

type TProdutos = class
   private
     FCodigo : Integer;
     FDescricao : String;
     FP_Venda : Real;
     procedure SetCodigo(const Value: Integer);
     procedure SetDescricao(const Value: String);
     procedure SetP_Venda(const Value: Real);

   public
     property codigo :Integer read FCodigo write FCodigo;
     property descricao   :String  read FDescricao   write FDescricao;
     property p_venda  :Real read FP_Venda  write FP_Venda;
     procedure ApagarLinha(Grade: TStringGrid; Linha: Integer);
     procedure Header(Grade: TStringGrid);
     function Total(Grade: TStringGrid):String;
 end;

 implementation

  procedure TProdutos.Header(Grade: TStringGrid);
  begin
   with Grade do
   begin
    Cells[0,0] := 'Código'; ColWidths[0] := 130;
    Cells[1,0] := 'Descrição'; ColWidths[1] := 270;
    Cells[2,0] := 'QTD';  ColWidths[2] := 50;
    Cells[3,0] := 'Valor Unitário';  ColWidths[3] := 130;
    Cells[4,0] := 'Valor Total';  ColWidths[4] :=130;
   end;
  end;

  function TProdutos.Total(Grade: TStringGrid):String;
  var
   qtd,vunit,valor,soma:double;
   i:integer;
  begin
   soma:=0.00;
   with Grade do
     begin
      for i:= 1 to RowCount-1 do
      begin
       qtd   := strtofloat(Cells[2,i]);
       vunit := strtofloat(Cells[3,i]);
       valor := vunit * qtd;
       Cells[4,i]:= floattostr(valor);
       soma  := soma + valor;
      end;
    end;
    result := floattostr(soma);
  end;

  procedure TProdutos.ApagarLinha(Grade: TStringGrid; Linha: integer);
  var
    i:integer;
  begin
    with Grade do
     begin
      for i:= linha to RowCount do
       Rows[i]:= Rows[i+1];
       if RowCount >1 then
        RowCount:=RowCount-1;
    end;
  end;

  procedure TProdutos.SetCodigo(const Value: Integer);
  begin
     FCodigo := Value;
  end;

  procedure TProdutos.SetDescricao(const Value: String);
  begin
     FDescricao := Value;
  end;

  procedure TProdutos.SetP_Venda(const Value: Real);
  begin
     FP_Venda := Value;
  end;

end.
