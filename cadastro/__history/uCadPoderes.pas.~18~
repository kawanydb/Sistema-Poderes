unit uCadPoderes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.ComCtrls,uEnum,cCadPoderes,uDTMConexao;

type
  TfrmCadastroPoderes = class(TfrmTelaHeranca)
    lbl15: TLabel;
    edtPoderId: TLabeledEdit;
    edtNomePoder: TLabeledEdit;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl16: TLabel;
    edtDescricao: TMemo;
    dblkCategoria: TDBLookupComboBox;
    dblkNivelPoder: TDBLookupComboBox;
    QryNivelPoder: TFDQuery;
    dtsNivelPoder: TDataSource;
    fdtncfldQryNivelPoderid: TFDAutoIncField;
    nQryNivelPodernivel: TStringField;
    fdtncfldQryListagemid: TFDAutoIncField;
    nQryListagemnome: TStringField;
    nQryListagemdescricao: TStringField;
    intgrfldQryListagemcategoria_id: TIntegerField;
    intgrfldQryListagemnivel_poder_id: TIntegerField;
    nQryListagemcategoria: TStringField;
    nQryListagemnivel: TStringField;
    QryCategoria: TFDQuery;
    fdtncfldQryNivelPoderid1: TFDAutoIncField;
    dtsCategoria: TDataSource;
    nQryCategorianome: TStringField;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    oPoder:TPoder;
  public
  function Apagar:Boolean; override;
  function Gravar(EstadoDoCadastro:TEstadoDoCadastro):Boolean; override;
  end;

var
  frmCadastroPoderes: TfrmCadastroPoderes;

implementation

{$R *.dfm}

{$REGION 'Override'}
function TfrmCadastroPoderes.Apagar: Boolean;
begin
  //verifica se existe no selecionar e se existir apaga
  if oPoder.Selecionar(QryListagem.FieldByName('id').AsInteger) then begin
    Result:=oPoder.Apagar;
  end;
end;

function TfrmCadastroPoderes.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if edtPoderId.Text<>EmptyStr then
     oPoder.codigo:=StrToInt(edtPoderId.Text)
  else
     oPoder.codigo:=0;

  oPoder.nome           :=edtNomePoder.Text;
  oPoder.descricao      :=edtDescricao.Text;
  oPoder.categoriaId    :=dblkCategoria.KeyValue;;
  oPoder.nivelPoderId   :=dblkNivelPoder.KeyValue;

  if (EstadoDoCadastro=ecInserir) then
     Result:=oPoder.Inserir
  else if (EstadoDoCadastro=ecAlterar) then
     Result:=oPoder.Atualizar;
end;
{$ENDREGION}

{$REGION 'BOTÕES'}
procedure TfrmCadastroPoderes.btnAlterarClick(Sender: TObject);
begin
   if oPoder.Selecionar(QryListagem.FieldByName('id').AsInteger) then begin
    edtPoderId.Text          :=IntToStr(oPoder.codigo);
    edtNomePoder.Text        :=oPoder.nome;
    edtDescricao.Text        :=oPoder.descricao;
    dblkCategoria.KeyValue   :=oPoder.categoriaId;
    dblkNivelPoder.KeyValue  :=oPoder.nivelPoderId;
  end
  else begin
    btnCancelar.Click;
    Abort
  end;
  inherited;
end;

procedure TfrmCadastroPoderes.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtNomePoder.SetFocus;
end;
{$ENDREGION}

{$REGION 'EVENTOS DO FORM'}
procedure TfrmCadastroPoderes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  QryListagem.Close;
  if Assigned(oPoder) then
     FreeAndNil(oPoder);
end;

procedure TfrmCadastroPoderes.FormCreate(Sender: TObject);
begin
  inherited;

  oPoder := TPoder.Create(dtmConexao.conexaoDB);
  IndiceAtual := 'nome';

  QryNivelPoder.Connection := dtmConexao.conexaoDB;
  QryNivelPoder.Open;
  QryListagem.Open;
  QryCategoria.Open;
end;
{$ENDREGION}
end.
