program Desafio;

uses
  Vcl.Forms,
  uTelaHeranca in 'heranca\uTelaHeranca.pas' {frmTelaHeranca},
  uDTMConexao in 'datamodule\uDTMConexao.pas' {dtmConexao: TDataModule},
  uEnum in 'heranca\uEnum.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmTelaHeranca, frmTelaHeranca);
  Application.CreateForm(TdtmConexao, dtmConexao);
  Application.Run;
end.
