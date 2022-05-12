object fraDBStrings: TfraDBStrings
  Left = 0
  Top = 0
  Width = 200
  Height = 102
  TabOrder = 0
  object gpButtons: TGridPanel
    Left = 176
    Top = 0
    Width = 24
    Height = 102
    Align = alRight
    ColumnCollection = <
      item
        Value = 100.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = btnAdd
        Row = 0
      end
      item
        Column = 0
        Control = btnEdit
        Row = 1
      end
      item
        Column = 0
        Control = btnDelete
        Row = 2
      end>
    RowCollection = <
      item
        Value = 33.333333333333340000
      end
      item
        Value = 33.333333333333340000
      end
      item
        Value = 33.333333333333340000
      end>
    TabOrder = 0
    object btnAdd: TcxButton
      Left = 1
      Top = 1
      Width = 22
      Height = 33
      Align = alClient
      Action = actAdd
      OptionsImage.Glyph.SourceDPI = 96
      OptionsImage.Glyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        610000001974455874536F6674776172650041646F626520496D616765526561
        647971C9653C0000001B744558745469746C65004164643B506C75733B426172
        733B526962626F6E3B9506332F0000004749444154785EE592C90900200C046D
        D0A6ACCAEE4604E32B8AB8011F3E0602590672244062DBCCA532E8F5D7024017
        AC98C11B4205C6D10896F50486B744235CA09FF1FD274A34995FABF9E946D7E8
        0000000049454E44AE426082}
      TabOrder = 0
    end
    object btnEdit: TcxButton
      Left = 1
      Top = 34
      Width = 22
      Height = 34
      Align = alClient
      Action = actEdit
      OptionsImage.Glyph.SourceDPI = 96
      OptionsImage.Glyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        610000001974455874536F6674776172650041646F626520496D616765526561
        647971C9653C00000020744558745469746C6500456469743B426172733B5269
        62626F6E3B5374616E646172643B3013C3DB0000007A49444154785EADCF310E
        8020104451EFB4E7F052869AF37817636B6F6BE18A461940339255921FAA7981
        46553F1501E79C92D6F3160A907340DEFB1188010867016200D238C0FB070819
        0064078669D6B6EBAFA41EC038436A018C9030808FF917EAC7A1E60DC8FF8C64
        DFDC80A20800C1B80410C0A3A767A76D009B2652851552D30000000049454E44
        AE426082}
      TabOrder = 1
    end
    object btnDelete: TcxButton
      Left = 1
      Top = 68
      Width = 22
      Height = 33
      Align = alClient
      Action = actDelete
      OptionsImage.Glyph.SourceDPI = 96
      OptionsImage.Glyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        610000001974455874536F6674776172650041646F626520496D616765526561
        647971C9653C00000029744558745469746C650052656D6F76653B44656C6574
        653B426172733B526962626F6E3B5374616E646172643B635648300000002B49
        444154785EEDD03111000008C340C4E104D3B8091EE8C2711DB2FE9000A4CE00
        06BA924D32F066A281015E5FEF3B94FC8DC40000000049454E44AE426082}
      TabOrder = 2
    end
  end
  object lbStrings: TcxListBox
    Left = 0
    Top = 0
    Width = 176
    Height = 102
    Align = alClient
    ItemHeight = 13
    TabOrder = 1
  end
  object Actions: TActionList
    Left = 8
    Top = 8
    object actAdd: TAction
      OnExecute = actAddExecute
      OnUpdate = actAddUpdate
    end
    object actEdit: TAction
      OnExecute = actEditExecute
      OnUpdate = actEditUpdate
    end
    object actDelete: TAction
      OnExecute = actDeleteExecute
      OnUpdate = actEditUpdate
    end
  end
end
