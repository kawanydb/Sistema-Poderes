unit cFuncao;

interface

uses System.Classes, Vcl.Controls,Vcl.ExtCtrls, Vcl.Dialogs, System.SysUtils, Vcl.Forms,Vcl.Buttons, RLReport, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.Graphics,
  Vcl.ExtDlgs,Winapi.Windows;

type
  TFuncao = class
  private



  public
    class procedure CriarForm(aNomeForm: TFormClass; aConexao: TFDConnection);
    class procedure ArredondarPainel(APanel: TPanel; ARaio: Integer = 20);
    class function SemEnter(const S: string): string;
    class function CSV(const S: string): string;
    class procedure BotaoMouseLeave(Sender: TObject);
    class procedure BotaoMouseEnter(Sender: TObject);
  end;

implementation

class procedure TFuncao.CriarForm(aNomeForm: TFormClass; aConexao: TFDConnection);
var
  Form: TForm;
begin
  try
    Form := aNomeForm.Create(Application);
    Form.ShowModal;
  finally
    if Assigned(Form) then
      Form.Free;
  end;
end;

class procedure TFuncao.ArredondarPainel(APanel: TPanel; ARaio: Integer = 20);
var
  R: HRGN;
begin
  //cria um retângulo arredondado
  R := CreateRoundRectRgn(
    0, 0,
    APanel.Width,
    APanel.Height,
    ARaio, ARaio
  );

  SetWindowRgn(APanel.Handle, R, True);
end;

//remove o enter pra criar o csv
class function TFuncao.SemEnter(const S: string): string;
begin
  Result := StringReplace(S, sLineBreak, ' ', [rfReplaceAll]);
  Result := StringReplace(Result, #13#10, ' ', [rfReplaceAll]);
  Result := StringReplace(Result, #13, ' ', [rfReplaceAll]);
  Result := StringReplace(Result, #10, ' ', [rfReplaceAll]);
end;

//remove enter e troca ; por ,
class function TFuncao.CSV(const S: string): string;
begin
  Result := StringReplace(SemEnter(S), ';', ',', [rfReplaceAll]);
end;

class procedure TFuncao.BotaoMouseLeave(Sender: TObject);
begin
  if Sender is TSpeedButton then
    TSpeedButton(Sender).Font.Color := clBlack;
end;

class procedure TFuncao.BotaoMouseEnter(Sender: TObject);
begin
  if Sender is TSpeedButton then
    TSpeedButton(Sender).Font.Color := clWhite;
end;


end.
