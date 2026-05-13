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
  end;

implementation

class procedure TFuncao.CriarForm(aNomeForm: TFormClass; aConexao: TFDConnection);
var
  form: TForm;
begin
  try
    form := aNomeForm.Create(Application);
    form.ShowModal;
  finally
    if Assigned(form) then
      form.Free;
  end;
end;

class procedure TFuncao.ArredondarPainel(APanel: TPanel; ARaio: Integer = 20);
var
  R: HRGN;
begin
  R := CreateRoundRectRgn(
    0, 0,
    APanel.Width,
    APanel.Height,
    ARaio, ARaio
  );

  SetWindowRgn(APanel.Handle, R, True);
end;

class function TFuncao.SemEnter(const S: string): string;
begin
  Result := StringReplace(S, sLineBreak, ' ', [rfReplaceAll]);
  Result := StringReplace(Result, #13#10, ' ', [rfReplaceAll]);
  Result := StringReplace(Result, #13, ' ', [rfReplaceAll]);
  Result := StringReplace(Result, #10, ' ', [rfReplaceAll]);
end;

class function TFuncao.CSV(const S: string): string;
begin
  Result := StringReplace(SemEnter(S), ';', ',', [rfReplaceAll]);
end;


end.
