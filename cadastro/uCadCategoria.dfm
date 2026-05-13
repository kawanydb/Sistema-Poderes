inherited frmCadCategoria: TfrmCadCategoria
  Caption = 'Cadastro de Categoria'
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcListagem: TPageControl
    ActivePage = tsManutencao
    inherited ts1: TTabSheet
      inherited grdListagem: TDBGrid
        DataSource = dtsListagem
        Columns = <
          item
            Expanded = False
            FieldName = 'id'
            Title.Alignment = taCenter
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Title.Alignment = taCenter
            Visible = True
          end>
      end
    end
    inherited tsManutencao: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 673
      ExplicitHeight = 370
      inherited pnlCampos: TPanel
        object lbl15: TLabel
          Left = 13
          Top = 11
          Width = 130
          Height = 21
          Caption = 'Dados Cadastrais'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
        end
        object edtCategoriaId: TLabeledEdit
          Tag = 1
          Left = 13
          Top = 54
          Width = 229
          Height = 21
          EditLabel.Width = 33
          EditLabel.Height = 13
          EditLabel.Caption = 'C'#243'digo'
          MaxLength = 10
          NumbersOnly = True
          TabOrder = 0
        end
        object edtDescricao: TLabeledEdit
          Tag = 2
          Left = 13
          Top = 110
          Width = 229
          Height = 21
          EditLabel.Width = 92
          EditLabel.Height = 13
          EditLabel.Caption = 'Nome da Categoria'
          MaxLength = 30
          TabOrder = 1
        end
      end
    end
  end
  inherited pnlRodape: TPanel
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited QryListagem: TFDQuery
    SQL.Strings = (
      'SELECT id,'
      '       nome'
      ' FROM categorias')
    Left = 412
    Top = 32
    object fdtncfldQryListagemid: TFDAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object nQryListagemnome: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 50
    end
  end
  inherited dtsListagem: TDataSource
    Top = 24
  end
end
