unit NumPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Data.Win.ADODB;

type
  TFrmNumPedido = class(TForm)
    LblMsg: TLabel;
    TxtPedido: TEdit;
    BtnOk: TButton;
    SQLConect: TADOConnection;
    MySQL: TADOQuery;
    procedure BtnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmNumPedido: TFrmNumPedido;

implementation

uses
  cBancoDados, Terminal;

var
 Dbs: TBancoDados;


{$R *.dfm}

procedure TFrmNumPedido.BtnOkClick(Sender: TObject);
begin
 try
   if FrmNumPedido.Caption = 'Cancelar Pedido' then
    begin
    if MessageDlg('Deseja Cancelar esse Pedidos?',
         mtConfirmation,[mbYes,mbNo],0) = mrYes then
         begin
           Dbs.Delete(TxtPedido.Text,MySQL);
           MessageDlg('Pedido Cancelado com sucesso!', mtconfirmation,[mbok],0);
         end;
    end;
   if FrmNumPedido.Caption = 'Abrir Pedido' then
    begin
      FrmPedido.Carregar(TxtPedido.Text);
    end;
   FrmNumPedido.Close;
 except
    MessageDlg('Erro ao ao abrir Pedido', mtError, [mbOK], 0);
      Exit;
 end;
end;

end.
