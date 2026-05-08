inherited frmCadNivelPoder: TfrmCadNivelPoder
  Caption = 'frmNivelPoder'
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcListagem: TPageControl
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
            FieldName = 'nivel'
            Title.Alignment = taCenter
            Visible = True
          end>
      end
    end
    inherited tsManutencao: TTabSheet
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
        object edtNivelId: TLabeledEdit
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
        object edtNivelPoder: TLabeledEdit
          Tag = 2
          Left = 13
          Top = 110
          Width = 229
          Height = 21
          EditLabel.Width = 69
          EditLabel.Height = 13
          EditLabel.Caption = 'N'#237'vel de Poder'
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
      '       nivel'
      ' FROM nivel_poder')
    Left = 420
    Top = 32
    object fdtncfldQryListagemid: TFDAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object nQryListagemnivel: TStringField
      DisplayLabel = 'N'#237'vel'
      FieldName = 'nivel'
      Origin = 'nivel'
      Required = True
    end
  end
  inherited dtsListagem: TDataSource
    Left = 500
    Top = 40
  end
end
