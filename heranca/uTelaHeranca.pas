unit uTelaHeranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Vcl.ComCtrls, uDTMConexao, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.DBCtrls, RxCurrEdit, uEnum,cArquivoIni, System.IniFiles;

type
  TfrmTelaHeranca = class(TForm)
    pgcListagem: TPageControl;
    ts1: TTabSheet;
    tsManutencao: TTabSheet;
    pnlListagemTopo: TPanel;
    btnPesquisar: TButton;
    mskPesquisar: TMaskEdit;
    grdListagem: TDBGrid;
    pnlCampos: TPanel;
    pnlRodape: TPanel;
    btnNovo: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    btnGravar: TBitBtn;
    btnApagar: TBitBtn;
    btnFechar: TBitBtn;
    QryListagem: TFDQuery;
    dtsListagem: TDataSource;
    btnNavigator: TDBNavigator;
    lbl1: TLabel;
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdListagemKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure grdListagemDblClick(Sender: TObject);
    procedure mskPesquisarKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdListagemDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
  protected
      EstadoDoCadastro:TEstadoDoCadastro;
  private
  SelectOriginal:String;
  FGridCarregado: Boolean;
    procedure ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar: TBitBtn; Navegador: TDBNavigator;
      Flag: Boolean);
    procedure ControlarIndiceTab(pgcListagem: TPageControl; Indice: Integer);
    function RetornarCampoTraduzido(Campo: String): String;
    procedure LimparEdits;
    procedure DesabilitarEditPK;
    procedure ExibirLabelIndice(Campo: string; aLabel: TLabel);
    function ExisteCampoObrigatorio: Boolean;
    procedure BloqueiaCTRL_DEL_DBGrid(var Key: Word; Shift: TShiftState);
    procedure CarregarGrid;
    procedure SalvarGrid;

  public
    IndiceAtual:string;
    function Apagar:Boolean; virtual;
    function Gravar(EstadoDoCadastro:TEstadoDoCadastro):Boolean; virtual;
  end;

var
  frmTelaHeranca: TfrmTelaHeranca;

implementation

{$R *.dfm}

{$REGION 'MÉTODOS VIRTUAIS'}
function TfrmTelaHeranca.Apagar: Boolean;
begin
    ShowMessage('DELETADO');
    Result := True;
end;

function TfrmTelaHeranca.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  Result := True;
//mensagens para o usuário saber se a ação aconteceu
     if(EstadoDoCadastro=ecInserir) then
        ShowMessage('Inserir')
      else if (EstadoDoCadastro=ecAlterar) then
        ShowMessage('Alterado');
end;
{$ENDREGION}

{$REGION 'BOTÕES'}
procedure TfrmTelaHeranca.btnAlterarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar,
   btnApagar, btnNavigator, false);
   EstadoDoCadastro:=ecAlterar;
end;

procedure TfrmTelaHeranca.btnApagarClick(Sender: TObject);
begin
  if (Apagar) then
  begin
       ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar,
                      btnApagar, btnNavigator, true);
       ControlarIndiceTab(pgcListagem, 0);
       LimparEdits;
       QryListagem.Refresh;
  end
  else
  begin
        MessageDlg('Erro na exclusão', mtError, [mbok],0);
  end;
end;

procedure TfrmTelaHeranca.btnCancelarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar,
   btnApagar, btnNavigator, true);
   ControlarIndiceTab(pgcListagem, 0);
   EstadoDoCadastro:=ecNenhum;
   LimparEdits;
end;

procedure TfrmTelaHeranca.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmTelaHeranca.btnGravarClick(Sender: TObject);
begin
  if (ExisteCampoObrigatorio) then
      Abort;
   Try
     if Gravar(EstadoDoCadastro) then begin
       QryListagem.Close;
       QryListagem.Open;

       ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar,
                      btnApagar, btnNavigator, true);
       ControlarIndiceTab(pgcListagem, 0);
       EstadoDoCadastro:=ecNenhum;
       LimparEdits;
       QryListagem.Refresh;
     end
     else begin
        MessageDlg('Erro na gravação', mtError, [mbok],0);
     end;
   finally
   end;
end;

procedure TfrmTelaHeranca.btnNovoClick(Sender: TObject);
begin
   ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar,
   btnApagar, btnNavigator, false);
   EstadoDoCadastro:=ecInserir;
   LimparEdits;
end;
{$ENDREGION}

{$REGION 'PESQUISAR'}
procedure TfrmTelaHeranca.btnPesquisarClick(Sender: TObject);
var
  I, J: Integer;
  NomeCampo, CondicaoSQL, SQLSemOrder, OrderByClause, Valor, Condicao: string;
  PosOrder, PosFrom, PosAs, PosPonto: Integer;
  ValorInt: Integer;
  Campo: TField;
  Mapa, Partes: TStringList;
  SelectPart, Linha, Token, Alias, CampoReal: string;
begin
  Valor := Trim(mskPesquisar.Text);
  if Valor = '' then
  begin
    QryListagem.Close;
    QryListagem.SQL.Text := SelectOriginal;
    QryListagem.Open;
    Exit;
  end;

  // Separa ORDER BY
  PosOrder := Pos('ORDER BY', UpperCase(SelectOriginal));
  if PosOrder > 0 then
  begin
    SQLSemOrder   := Copy(SelectOriginal, 1, PosOrder - 1);
    OrderByClause := Copy(SelectOriginal, PosOrder, Length(SelectOriginal));
  end
  else
  begin
    SQLSemOrder   := SelectOriginal;
    OrderByClause := '';
  end;

  // Monta mapa: Alias ? CampoReal
  Mapa := TStringList.Create;
  Partes := TStringList.Create;
  try
    PosFrom := Pos('FROM', UpperCase(SelectOriginal));
    SelectPart := Trim(Copy(SelectOriginal,
      Pos('SELECT', UpperCase(SelectOriginal)) + 6,
      PosFrom - Pos('SELECT', UpperCase(SelectOriginal)) - 6));

    Partes.Text := StringReplace(SelectPart, ',', #13#10, [rfReplaceAll]);
    for Linha in Partes do
    begin
      Token := Trim(Linha);
      if Token = '' then Continue;

      PosAs := Pos(' AS ', UpperCase(Token));
      if PosAs > 0 then
      begin
        CampoReal := Trim(Copy(Token, 1, PosAs - 1));
        Alias     := Trim(Copy(Token, PosAs + 4, Length(Token)));
      end
      else
      begin
        CampoReal := Token;
        PosPonto  := Pos('.', Token);
        if PosPonto > 0 then
          Alias := Copy(Token, PosPonto + 1, Length(Token))
        else
          Alias := Token;
      end;

      Mapa.Add(Alias + '=' + CampoReal); // ex: "id=p.id", "categoria=c.nome"
    end;

    // Monta WHERE
    CondicaoSQL := '';
    for I := 0 to QryListagem.FieldCount - 1 do
    begin
      Campo := QryListagem.Fields[I];

      // Busca o CampoReal pelo Alias exato
      NomeCampo := '';
      for J := 0 to Mapa.Count - 1 do
        if UpperCase(Mapa.Names[J]) = UpperCase(Campo.FieldName) then
        begin
          NomeCampo := Mapa.ValueFromIndex[J];
          Break;
        end;

      if NomeCampo = '' then Continue;

      Condicao := '';
      case Campo.DataType of
        ftString, ftWideString:
          Condicao := 'UPPER(' + NomeCampo + ') LIKE ' +
                      QuotedStr('%' + UpperCase(Valor) + '%');
        ftInteger, ftSmallint, ftAutoInc:
          if TryStrToInt(Valor, ValorInt) then
            if UpperCase(Campo.FieldName) = 'ID' then  // só pesquisa no ID
              Condicao := NomeCampo + ' = ' + Valor;
      end;

      if Condicao <> '' then
      begin
        if CondicaoSQL <> '' then
          CondicaoSQL := CondicaoSQL + ' OR ';
        CondicaoSQL := CondicaoSQL + Condicao;
      end;
    end;
  finally
    Partes.Free;
    Mapa.Free;
  end;

  if CondicaoSQL = '' then Exit;

  QryListagem.Close;
  QryListagem.SQL.Text := SQLSemOrder + ' WHERE ' + CondicaoSQL + ' ' + OrderByClause;
  QryListagem.Open;
end;
{$ENDREGION}

{$REGION 'CONTROLE'}
procedure TfrmTelaHeranca.ControlarBotoes(btnNovo, btnAlterar, btnCancelar,
      btnGravar, btnApagar:TBitBtn; Navegador: TDBNavigator;
      Flag:Boolean);
//configurando botões e desabilitando uns  quando outros forem clicados
 begin
    btnNovo.Enabled :=Flag;
    btnApagar.Enabled :=Flag;
    btnAlterar.Enabled :=Flag;
    Navegador.Enabled   :=Flag;
    pgcListagem.Pages[0].TabVisible :=Flag;
    btnCancelar.Enabled :=not(Flag);
    btnGravar.Enabled :=not(Flag);
 end;

 procedure TfrmTelaHeranca.ControlarIndiceTab(pgcListagem: TPageControl; Indice: Integer);
begin
   if(pgcListagem.Pages[Indice].TabVisible) then
   pgcListagem.TabIndex:=Indice;
end;
{$ENDREGION}

{$REGION 'FUNÇÕES DE CONTROLAR EDT'}
//função que retorna uma string
function TfrmTelaHeranca.RetornarCampoTraduzido(Campo:String):String;
var i:Integer;
begin
   for I := 0 to QryListagem.Fields.Count-1 do begin
     if  LowerCase(QryListagem.Fields[i].FieldName)=LowerCase(Campo) then
     begin
       Result:= QryListagem.Fields[i].DisplayLabel;
       Break;
     end;
   end;
end;

procedure TfrmTelaHeranca.LimparEdits;
var i: Integer;
begin
   for i := 0 to ComponentCount -1 do begin
      if (Components[i] is TLabeledEdit) then
            TLabeledEdit(Components[i]).Text:=EmptyStr
      else if (Components[i]is TEdit) then
        TEdit(Components[i]).Text:= ''
      else if (Components[i]is TMaskEdit) then
        TMaskEdit(Components[i]).Text:= ''
      else if (Components[i] is TMemo) then
        TMemo(Components[i]).Text:= ''
      else if (Components[i]is TDBLookupComboBox) then
        TDBLookupComboBox(Components[i]).keyValue:= Null;
  end;
end;

function TfrmTelaHeranca.ExisteCampoObrigatorio: Boolean;
var
  i: Integer;
begin
  Result := False;

  for i := 0 to ComponentCount - 1 do
  begin
    // valida TLabeledEdit
    if (Components[i] is TLabeledEdit) then
    begin
      if (TLabeledEdit(Components[i]).Tag = 2) and
         (TLabeledEdit(Components[i]).Enabled) and
         (Trim(TLabeledEdit(Components[i]).Text) = '')
      then
      begin
        MessageDlg(
          TLabeledEdit(Components[i]).EditLabel.Caption +
          ' é um campo obrigatório',
          mtInformation,
          [mbOK],
          0
        );

        TLabeledEdit(Components[i]).SetFocus;
        Result := True;
        Break;
      end;
    end;

    // valida TCurrencyEdit
    if (Components[i] is TCurrencyEdit) then
    begin
      if (TCurrencyEdit(Components[i]).Tag = 2) and
         (TCurrencyEdit(Components[i]).Enabled) and
         (TCurrencyEdit(Components[i]).Value <= 0)
      then
      begin
        MessageDlg(
          'Todos os campos devem ser preenchidos!',
          mtInformation,
          [mbOK],
          0
        );

        TCurrencyEdit(Components[i]).SetFocus;
        Result := True;
        Break;
      end;
    end;

    // TMaskEdit
    if (Components[i] is TMaskEdit) then
    begin
      if (TMaskEdit(Components[i]).Tag = 2) and
         (TMaskEdit(Components[i]).Enabled) and
         (Trim(TMaskEdit(Components[i]).Text) = '')
      then
      begin
        MessageDlg(
          'Preencha todos os campos.',
          mtWarning,
          [mbOK],
          0
        );

        TMaskEdit(Components[i]).SetFocus;
        Result := True;
        Exit;
      end;
    end;
  end;
end;

procedure TfrmTelaHeranca.DesabilitarEditPK;  //declara que o desabilitar pertence ao form tela herança
var i: Integer;
begin
   for i := 0 to ComponentCount -1 do begin // o indice começa em 0 por isso o -1
      if(Components[i] is TLabeledEdit) then begin  // verifica se o componente atual é do tipo TLabeledEdit
          if(TLabeledEdit(Components[i]).Tag = 1) then begin
            TLabeledEdit(Components[i]).Enabled:=False;  //desativa o campo, impedindo o usuário de editá-lo
            Break;    // para o loop evitando busca desnecessária
          end;
      end;
   end;
end;

procedure TfrmTelaHeranca.mskPesquisarKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    btnPesquisar.Click;
    Key := 0;
  end;
end;

procedure TfrmTelaHeranca.ExibirLabelIndice(Campo:string; aLabel:TLabel);
begin
  aLabel.Caption:=RetornarCampoTraduzido(Campo);
end;
{$ENDREGION}

{$REGION 'GRID'}
procedure TfrmTelaHeranca.grdListagemDblClick(Sender: TObject);
begin
  btnAlterar.Click;
end;

procedure TfrmTelaHeranca.grdListagemDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  //ZEBRAR
  if not (gdSelected in State) then
  begin
  //verifica se o número da linha é ímpar ou par e da uma cor p cada
    if Odd(TDBGrid(Sender).DataSource.DataSet.RecNo) then
      TDBGrid(Sender).Canvas.Brush.Color := $00F4F0FD //$00F2F2F2 // Cinza claro
    else
      TDBGrid(Sender).Canvas.Brush.Color := $00E2D8F5; // Cinza escuro
  end;

  if (gdSelected in State) then
  begin
    TDBGrid(Sender).Canvas.Brush.Color := $00301050;
    TDBGrid(Sender).Canvas.Font.Color  := clWhite;
  end;

  // Aplica a cor no fundo
  TDBGrid(Sender).Canvas.FillRect(Rect);

  //mostra o texto padrão
  TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmTelaHeranca.grdListagemKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    Key := 0; // evita conflito
    Close;
  end;
  BloqueiaCTRL_DEL_DBGrid(Key,Shift);

end;

procedure TfrmTelaHeranca.BloqueiaCTRL_DEL_DBGrid(var Key: Word; Shift: TShiftState);
begin
  //Bloqueia o CTRL + DEL
  if(Shift = [ssCtrl]) and (Key = 46) then
    Key:=0;
end;
{$ENDREGION}

{$REGION 'EVENTOS FORM'}
procedure TfrmTelaHeranca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SalvarGrid;
end;

procedure TfrmTelaHeranca.FormCreate(Sender: TObject);
begin
  QryListagem.Connection:=dtmConexao.conexaoDB;
  dtsListagem.DataSet:=QryListagem;
  grdListagem.DataSource:=dtsListagem;
  grdListagem.Options:=[dgTitles,dgIndicator,dgColumnResize,
                         dgColLines,dgRowLines,dgTabs,
                         dgCancelOnExit,dgTitleClick,dgTitleHotTrack];
end;

procedure TfrmTelaHeranca.FormShow(Sender: TObject);
begin
  if (QryListagem.SQL.Text <> EmptyStr) then
  begin
    QryListagem.IndexFieldNames := IndiceAtual;
    ExibirLabelIndice(IndiceAtual, lbl1);
    SelectOriginal := QryListagem.SQL.Text;
    QryListagem.Open;
  end;

  //garante que garregue a função
  if not FGridCarregado then
  begin
    CarregarGrid;
    FGridCarregado := True;
  end;

  ControlarIndiceTab(pgcListagem, 0);
  DesabilitarEditPK;
  grdListagem.SetFocus;

  ControlarBotoes(
    btnNovo,
    btnAlterar,
    btnCancelar,
    btnGravar,
    btnApagar,
    btnNavigator,
    True
  );
end;
{$ENDREGION}

{$REGION 'Salvar Posição e Largura das Colunas'}
procedure TfrmTelaHeranca.SalvarGrid;
var
  Ini: TIniFile;
  i: Integer;
  Secao: string;
begin
  Secao := Self.Name;

  Ini := TIniFile.Create(
    ExtractFilePath(Application.ExeName) +
    'grid_padrao.ini');

  try
    for i := 0 to grdListagem.Columns.Count - 1 do
    begin
      Ini.WriteString(Secao, 'Campo' + IntToStr(i),
        grdListagem.Columns[i].FieldName);

      Ini.WriteInteger(Secao, 'Width' + IntToStr(i),
        grdListagem.Columns[i].Width);
    end;
  finally
    Ini.Free;
  end;
end;

procedure TfrmTelaHeranca.CarregarGrid;
var
  Ini: TIniFile;
  i, j: Integer;
  Campo: string;
  Secao: string;
begin
  Secao := Self.Name;

  Ini := TIniFile.Create(
    ExtractFilePath(Application.ExeName) +
    'grid_padrao.ini');

  try
    //coluna
    for i := 0 to grdListagem.Columns.Count - 1 do
    begin
      Campo := Ini.ReadString(Secao, 'Campo' + IntToStr(i), '');

      for j := 0 to grdListagem.Columns.Count - 1 do
      begin
        if SameText(grdListagem.Columns[j].FieldName, Campo) then
        begin
          grdListagem.Columns[j].Index := i;
          Break;
        end;
      end;
    end;

    // largura
    for i := 0 to grdListagem.Columns.Count - 1 do
    begin
      grdListagem.Columns[i].Width :=
        Ini.ReadInteger(
          Secao,
          'Width' + IntToStr(i),
          grdListagem.Columns[i].Width
        );
    end;

  finally
    Ini.Free;
  end;
end;

{$ENDREGION}

end.
