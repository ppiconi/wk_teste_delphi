program Prj_Terminal;

uses
  Vcl.Forms,
  Terminal in 'View\Terminal.pas' {FrmPedido},
  uProdutos in 'Model\uProdutos.pas',
  uClientes in 'Model\uClientes.pas',
  cBancoDados in 'Controller\cBancoDados.pas',
  NumPedido in 'View\NumPedido.pas' {FrmNumPedido};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPedido, FrmPedido);
  Application.CreateForm(TFrmNumPedido, FrmNumPedido);
  Application.Run;
end.
