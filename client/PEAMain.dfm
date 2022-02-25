object frmPEAMain: TfrmPEAMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Pokevents Admin'
  ClientHeight = 701
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    800
    701)
  PixelsPerInch = 96
  TextHeight = 13
  object cxgEvents: TcxGrid
    Left = 8
    Top = 8
    Width = 250
    Height = 685
    Anchors = [akLeft, akTop, akBottom]
    TabOrder = 0
    object cxgEventsDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      Navigator.Buttons.First.Visible = False
      Navigator.Buttons.PriorPage.Visible = False
      Navigator.Buttons.Prior.Visible = False
      Navigator.Buttons.Next.Visible = False
      Navigator.Buttons.NextPage.Visible = False
      Navigator.Buttons.Last.Visible = False
      Navigator.Buttons.Insert.Visible = False
      Navigator.Buttons.Append.Visible = True
      Navigator.Buttons.Edit.Visible = False
      Navigator.Buttons.Post.Visible = False
      Navigator.Buttons.Cancel.Visible = False
      Navigator.Buttons.Refresh.Visible = False
      Navigator.Buttons.SaveBookmark.Visible = False
      Navigator.Buttons.GotoBookmark.Visible = False
      Navigator.Buttons.Filter.Visible = False
      Navigator.Visible = True
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = dtsEvents
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Appending = True
      OptionsData.CancelOnExit = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxgEventsDBTableView1Title: TcxGridDBColumn
        DataBinding.FieldName = 'Title'
        Width = 177
      end
      object cxgEventsDBTableView1Region: TcxGridDBColumn
        DataBinding.FieldName = 'Region'
        PropertiesClassName = 'TcxLookupComboBoxProperties'
        Properties.KeyFieldNames = 'Index'
        Properties.ListColumns = <
          item
            FieldName = 'Name'
          end>
        Properties.ListSource = dtsRegion
        Width = 71
      end
    end
    object cxgEventsLevel1: TcxGridLevel
      GridView = cxgEventsDBTableView1
    end
  end
  object dxLayoutControl1: TdxLayoutControl
    Left = 264
    Top = 8
    Width = 528
    Height = 654
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object edtTitle: TcxDBTextEdit
      Left = 245
      Top = 10
      DataBinding.DataField = 'Title'
      DataBinding.DataSource = dtsEvents
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 1
      Width = 273
    end
    object edtSpecies: TcxDBTextEdit
      Left = 192
      Top = 213
      DataBinding.DataField = 'Species'
      DataBinding.DataSource = dtsEvents
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 8
      Width = 206
    end
    object cmbBall: TcxDBComboBox
      Left = 68
      Top = 213
      DataBinding.DataField = 'Ball'
      DataBinding.DataSource = dtsEvents
      Properties.Items.Strings = (
        'Premier')
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      TabOrder = 7
      Width = 77
    end
    object spnLevel: TcxDBSpinEdit
      Left = 68
      Top = 240
      DataBinding.DataField = 'Level'
      DataBinding.DataSource = dtsEvents
      Properties.MaxValue = 100.000000000000000000
      Properties.MinValue = 1.000000000000000000
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.ButtonStyle = bts3D
      TabOrder = 10
      Width = 77
    end
    object chkShiny: TcxDBCheckBox
      Left = 151
      Top = 240
      Caption = 'Shiny'
      DataBinding.DataField = 'Shiny'
      DataBinding.DataSource = dtsEvents
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 11
    end
    object chkGigantamax: TcxDBCheckBox
      Left = 201
      Top = 240
      Caption = 'Gigantamax'
      DataBinding.DataField = 'Gigantamax'
      DataBinding.DataSource = dtsEvents
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 12
    end
    object edtTID: TcxDBTextEdit
      Left = 437
      Top = 267
      DataBinding.DataField = 'TID'
      DataBinding.DataSource = dtsEvents
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 14
      Width = 81
    end
    object edtAbility: TcxDBTextEdit
      Left = 68
      Top = 294
      DataBinding.DataField = 'Ability'
      DataBinding.DataSource = dtsEvents
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 15
      Width = 208
    end
    object edtHoldItem: TcxDBTextEdit
      Left = 68
      Top = 321
      DataBinding.DataField = 'HoldItem'
      DataBinding.DataSource = dtsEvents
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 17
      Width = 450
    end
    object edtNature: TcxDBTextEdit
      Left = 320
      Top = 294
      DataBinding.DataField = 'Nature'
      DataBinding.DataSource = dtsEvents
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 16
      Width = 198
    end
    object edtOT: TcxDBTextEdit
      Left = 68
      Top = 267
      DataBinding.DataField = 'OT'
      DataBinding.DataSource = dtsEvents
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 13
      Width = 347
    end
    object memDescription: TcxDBMemo
      Left = 68
      Top = 37
      DataBinding.DataField = 'Description'
      DataBinding.DataSource = dtsEvents
      Properties.ScrollBars = ssVertical
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 2
      Height = 89
      Width = 450
    end
    object cmbKind: TcxDBComboBox
      Left = 68
      Top = 132
      DataBinding.DataField = 'Kind'
      DataBinding.DataSource = dtsEvents
      Properties.Items.Strings = (
        'Wi-Fi'
        'Serial Code')
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      TabOrder = 3
      Width = 121
    end
    object deStartDate: TcxDBDateEdit
      Left = 68
      Top = 159
      DataBinding.DataField = 'StartDate'
      DataBinding.DataSource = dtsEvents
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      TabOrder = 4
      Width = 121
    end
    object deEndDate: TcxDBDateEdit
      Left = 68
      Top = 186
      DataBinding.DataField = 'EndDate'
      DataBinding.DataSource = dtsEvents
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      TabOrder = 5
      Width = 121
    end
    object chkSun: TcxDBCheckBox
      Left = 22
      Top = 532
      Caption = 'Sun'
      DataBinding.DataField = 'Sun'
      DataBinding.DataSource = dtsEvents
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 21
    end
    object chkMoon: TcxDBCheckBox
      Left = 22
      Top = 555
      Caption = 'Moon'
      DataBinding.DataField = 'Moon'
      DataBinding.DataSource = dtsEvents
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 22
    end
    object chkUltraSun: TcxDBCheckBox
      Left = 22
      Top = 578
      Caption = 'Ultra Sun'
      DataBinding.DataField = 'UltraSun'
      DataBinding.DataSource = dtsEvents
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 23
    end
    object chkUltraMoon: TcxDBCheckBox
      Left = 22
      Top = 601
      Caption = 'Ultra Moon'
      DataBinding.DataField = 'UltraMoon'
      DataBinding.DataSource = dtsEvents
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 24
    end
    object chkGO: TcxDBCheckBox
      Left = 144
      Top = 532
      Caption = 'GO'
      DataBinding.DataField = 'GO'
      DataBinding.DataSource = dtsEvents
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 25
    end
    object chkSword: TcxDBCheckBox
      Left = 144
      Top = 555
      Caption = 'Sword'
      DataBinding.DataField = 'Sword'
      DataBinding.DataSource = dtsEvents
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 26
    end
    object chkShield: TcxDBCheckBox
      Left = 144
      Top = 578
      Caption = 'Shield'
      DataBinding.DataField = 'Shield'
      DataBinding.DataSource = dtsEvents
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 27
    end
    object chkLetsGoEevee: TcxDBCheckBox
      Left = 144
      Top = 601
      Caption = 'Let'#39's Go, Eevee!'
      DataBinding.DataField = 'LetsGoEevee'
      DataBinding.DataSource = dtsEvents
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 28
    end
    object chkLetsGoPikachu: TcxDBCheckBox
      Left = 267
      Top = 532
      Caption = 'Let'#39's Go, Pikachu!'
      DataBinding.DataField = 'LetsGoPikachu'
      DataBinding.DataSource = dtsEvents
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 29
    end
    object chkBrilliantDiamond: TcxDBCheckBox
      Left = 267
      Top = 555
      Caption = 'Brilliant Diamond'
      DataBinding.DataField = 'BrilliantDiamond'
      DataBinding.DataSource = dtsEvents
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 30
    end
    object chkShiningPearl: TcxDBCheckBox
      Left = 267
      Top = 578
      Caption = 'Shining Pearl'
      DataBinding.DataField = 'ShiningPearl'
      DataBinding.DataSource = dtsEvents
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 31
    end
    object chkLegendsArceus: TcxDBCheckBox
      Left = 267
      Top = 601
      Caption = 'Legends: Arceus'
      DataBinding.DataField = 'LegendsArceus'
      DataBinding.DataSource = dtsEvents
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 32
    end
    object cmbRegion: TcxDBLookupComboBox
      Left = 68
      Top = 10
      DataBinding.DataField = 'Region'
      DataBinding.DataSource = dtsEvents
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'Index'
      Properties.ListColumns = <
        item
          FieldName = 'Name'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dtsRegion
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      TabOrder = 0
      Width = 121
    end
    object cmbGender: TcxDBLookupComboBox
      Left = 444
      Top = 213
      DataBinding.DataField = 'Gender'
      DataBinding.DataSource = dtsEvents
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'Index'
      Properties.ListColumns = <
        item
          FieldName = 'Name'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dtsGender
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      TabOrder = 9
      Width = 74
    end
    object chkHome: TcxDBCheckBox
      Left = 389
      Top = 532
      Caption = 'Home'
      DataBinding.DataField = 'Home'
      DataBinding.DataSource = dtsEvents
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 33
    end
    inline dbsLocations: TfraDBStrings
      Left = 245
      Top = 132
      Width = 273
      Height = 75
      TabOrder = 6
      inherited gpButtons: TGridPanel
        Left = 249
        Height = 75
        ControlCollection = <
          item
            Column = 0
            Control = dbsLocations.btnAdd
            Row = 0
          end
          item
            Column = 0
            Control = dbsLocations.btnEdit
            Row = 1
          end
          item
            Column = 0
            Control = dbsLocations.btnDelete
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
            Value = 33.333333333333310000
          end>
        inherited btnEdit: TcxButton
          Height = 25
        end
        inherited btnDelete: TcxButton
          Top = 50
        end
      end
      inherited lbStrings: TcxListBox
        Width = 249
        Height = 75
      end
    end
    inline dbsMoves: TfraDBStrings
      Left = 68
      Top = 348
      Width = 450
      Height = 80
      TabOrder = 18
      inherited gpButtons: TGridPanel
        Left = 426
        Height = 80
        ControlCollection = <
          item
            Column = 0
            Control = dbsMoves.btnAdd
            Row = 0
          end
          item
            Column = 0
            Control = dbsMoves.btnEdit
            Row = 1
          end
          item
            Column = 0
            Control = dbsMoves.btnDelete
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
            Value = 33.333333333333310000
          end>
        inherited btnAdd: TcxButton
          Height = 26
        end
        inherited btnEdit: TcxButton
          Top = 27
          Height = 26
        end
        inherited btnDelete: TcxButton
          Top = 53
          Height = 26
        end
      end
      inherited lbStrings: TcxListBox
        Width = 426
        Height = 80
      end
    end
    inline dbsMarks: TfraDBStrings
      Left = 68
      Top = 434
      Width = 201
      Height = 74
      TabOrder = 19
      inherited gpButtons: TGridPanel
        Left = 177
        Height = 74
        ControlCollection = <
          item
            Column = 0
            Control = dbsMarks.btnAdd
            Row = 0
          end
          item
            Column = 0
            Control = dbsMarks.btnEdit
            Row = 1
          end
          item
            Column = 0
            Control = dbsMarks.btnDelete
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
            Value = 33.333333333333310000
          end>
      end
      inherited lbStrings: TcxListBox
        Width = 177
        Height = 74
      end
    end
    inline dbsRibbons: TfraDBStrings
      Left = 318
      Top = 434
      Width = 200
      Height = 74
      TabOrder = 20
      inherited gpButtons: TGridPanel
        Height = 74
        ControlCollection = <
          item
            Column = 0
            Control = dbsRibbons.btnAdd
            Row = 0
          end
          item
            Column = 0
            Control = dbsRibbons.btnEdit
            Row = 1
          end
          item
            Column = 0
            Control = dbsRibbons.btnDelete
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
            Value = 33.333333333333310000
          end>
      end
      inherited lbStrings: TcxListBox
        Height = 74
      end
    end
    object dxLayoutControl1Group_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avTop
      Hidden = True
      ItemIndex = 10
      ShowBorder = False
      Index = -1
    end
    object liTitle: TdxLayoutItem
      Parent = dxLayoutGroup6
      AlignHorz = ahClient
      CaptionOptions.Text = 'Title'
      Control = edtTitle
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liRegion: TdxLayoutItem
      Parent = dxLayoutGroup6
      CaptionOptions.Text = 'Region'
      Control = cmbRegion
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liSpecies: TdxLayoutItem
      Parent = dxLayoutGroup1
      AlignHorz = ahClient
      CaptionOptions.Text = 'Species'
      Control = edtSpecies
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 153
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liBall: TdxLayoutItem
      Parent = dxLayoutGroup1
      CaptionOptions.Text = 'Ball'
      Control = cmbBall
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 77
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liLevel: TdxLayoutItem
      Parent = dxLayoutGroup2
      CaptionOptions.Text = 'Level'
      Control = spnLevel
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 77
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liShiny: TdxLayoutItem
      Parent = dxLayoutGroup2
      CaptionOptions.Text = 'cxDBCheckBox1'
      CaptionOptions.Visible = False
      Control = chkShiny
      ControlOptions.OriginalHeight = 17
      ControlOptions.OriginalWidth = 44
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liGigantamax: TdxLayoutItem
      Parent = dxLayoutGroup2
      CaptionOptions.Text = 'cxDBCheckBox2'
      CaptionOptions.Visible = False
      Control = chkGigantamax
      ControlOptions.OriginalHeight = 17
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object liMarks: TdxLayoutItem
      Parent = dxLayoutGroup5
      AlignHorz = ahClient
      CaptionOptions.AlignVert = tavTop
      CaptionOptions.Text = 'Marks'
      Control = dbsMarks
      ControlOptions.AutoColor = True
      ControlOptions.OriginalHeight = 74
      ControlOptions.OriginalWidth = 200
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liTID: TdxLayoutItem
      Parent = dxLayoutGroup3
      CaptionOptions.Text = 'ID'
      Control = edtTID
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 81
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liAbility: TdxLayoutItem
      Parent = dxLayoutGroup4
      AlignHorz = ahClient
      CaptionOptions.Text = 'Ability'
      Control = edtAbility
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liHoldItem: TdxLayoutItem
      Parent = dxLayoutControl1Group_Root
      CaptionOptions.Text = 'Hold Item'
      Control = edtHoldItem
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 7
    end
    object liNature: TdxLayoutItem
      Parent = dxLayoutGroup4
      AlignHorz = ahClient
      CaptionOptions.Text = 'Nature'
      Control = edtNature
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liOT: TdxLayoutItem
      Parent = dxLayoutGroup3
      AlignHorz = ahClient
      CaptionOptions.Text = 'OT'
      Control = edtOT
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liMoves: TdxLayoutItem
      Parent = dxLayoutControl1Group_Root
      CaptionOptions.AlignVert = tavTop
      CaptionOptions.Text = 'Moves'
      Control = dbsMoves
      ControlOptions.AutoColor = True
      ControlOptions.OriginalHeight = 80
      ControlOptions.OriginalWidth = 200
      ControlOptions.ShowBorder = False
      Index = 8
    end
    object liRibbons: TdxLayoutItem
      Parent = dxLayoutGroup5
      AlignHorz = ahClient
      CaptionOptions.AlignVert = tavTop
      CaptionOptions.Text = 'Ribbons'
      Control = dbsRibbons
      ControlOptions.AutoColor = True
      ControlOptions.OriginalHeight = 74
      ControlOptions.OriginalWidth = 200
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liDescription: TdxLayoutItem
      Parent = dxLayoutControl1Group_Root
      CaptionOptions.Text = 'Description'
      Control = memDescription
      ControlOptions.OriginalHeight = 89
      ControlOptions.OriginalWidth = 185
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liKind: TdxLayoutItem
      Parent = dxLayoutGroup8
      CaptionOptions.Text = 'Type'
      Control = cmbKind
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liLocations: TdxLayoutItem
      Parent = dxLayoutGroup7
      AlignHorz = ahClient
      CaptionOptions.AlignVert = tavTop
      CaptionOptions.Text = 'Locations'
      Control = dbsLocations
      ControlOptions.AutoColor = True
      ControlOptions.OriginalHeight = 75
      ControlOptions.OriginalWidth = 200
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liGender: TdxLayoutItem
      Parent = dxLayoutGroup1
      CaptionOptions.Text = 'Gender'
      Control = cmbGender
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 74
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object liStartDate: TdxLayoutItem
      Parent = dxLayoutGroup8
      CaptionOptions.Text = 'Start Date'
      Control = deStartDate
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liEndDate: TdxLayoutItem
      Parent = dxLayoutGroup8
      CaptionOptions.Text = 'End Date'
      Control = deEndDate
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutGroup1: TdxLayoutGroup
      Parent = dxLayoutControl1Group_Root
      CaptionOptions.Text = 'New Group'
      ItemIndex = 2
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 3
    end
    object dxLayoutGroup2: TdxLayoutGroup
      Parent = dxLayoutControl1Group_Root
      CaptionOptions.Text = 'New Group'
      ItemIndex = 1
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 4
    end
    object dxLayoutGroup3: TdxLayoutGroup
      Parent = dxLayoutControl1Group_Root
      CaptionOptions.Text = 'New Group'
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 5
    end
    object dxLayoutGroup4: TdxLayoutGroup
      Parent = dxLayoutControl1Group_Root
      CaptionOptions.Text = 'New Group'
      ItemIndex = 1
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 6
    end
    object dxLayoutGroup5: TdxLayoutGroup
      Parent = dxLayoutControl1Group_Root
      CaptionOptions.Text = 'New Group'
      ItemIndex = 1
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 9
    end
    object dxLayoutGroup6: TdxLayoutGroup
      Parent = dxLayoutControl1Group_Root
      CaptionOptions.Text = 'New Group'
      ItemIndex = 1
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroup7: TdxLayoutGroup
      Parent = dxLayoutControl1Group_Root
      CaptionOptions.Text = 'New Group'
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 2
    end
    object dxLayoutGroup8: TdxLayoutGroup
      Parent = dxLayoutGroup7
      CaptionOptions.Text = 'New Group'
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroup9: TdxLayoutGroup
      Parent = dxLayoutControl1Group_Root
      AlignHorz = ahClient
      CaptionOptions.Text = 'Games Available'
      ItemIndex = 3
      LayoutDirection = ldHorizontal
      WrapItemsMode = wmNone
      Index = 10
    end
    object dxLayoutGroup10: TdxLayoutGroup
      Parent = dxLayoutGroup9
      AlignHorz = ahClient
      CaptionOptions.Text = 'New Group'
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroup11: TdxLayoutGroup
      Parent = dxLayoutGroup9
      AlignHorz = ahClient
      CaptionOptions.Text = 'New Group'
      ItemIndex = 3
      ShowBorder = False
      Index = 1
    end
    object dxLayoutGroup12: TdxLayoutGroup
      Parent = dxLayoutGroup9
      AlignHorz = ahClient
      CaptionOptions.Text = 'New Group'
      ItemIndex = 3
      ShowBorder = False
      Index = 2
    end
    object liSun: TdxLayoutItem
      Parent = dxLayoutGroup10
      AlignHorz = ahClient
      CaptionOptions.Text = 'cxDBCheckBox1'
      CaptionOptions.Visible = False
      Control = chkSun
      ControlOptions.OriginalHeight = 17
      ControlOptions.OriginalWidth = 120
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liMoon: TdxLayoutItem
      Parent = dxLayoutGroup10
      AlignHorz = ahClient
      CaptionOptions.Text = 'cxDBCheckBox2'
      CaptionOptions.Visible = False
      Control = chkMoon
      ControlOptions.OriginalHeight = 17
      ControlOptions.OriginalWidth = 120
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liUltraSun: TdxLayoutItem
      Parent = dxLayoutGroup10
      AlignHorz = ahClient
      CaptionOptions.Text = 'cxDBCheckBox3'
      CaptionOptions.Visible = False
      Control = chkUltraSun
      ControlOptions.OriginalHeight = 17
      ControlOptions.OriginalWidth = 120
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object liUltraMoon: TdxLayoutItem
      Parent = dxLayoutGroup10
      AlignHorz = ahClient
      CaptionOptions.Text = 'cxDBCheckBox4'
      CaptionOptions.Visible = False
      Control = chkUltraMoon
      ControlOptions.OriginalHeight = 17
      ControlOptions.OriginalWidth = 120
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object liGO: TdxLayoutItem
      Parent = dxLayoutGroup11
      AlignHorz = ahClient
      CaptionOptions.Text = 'cxDBCheckBox5'
      CaptionOptions.Visible = False
      Control = chkGO
      ControlOptions.OriginalHeight = 17
      ControlOptions.OriginalWidth = 120
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liSword: TdxLayoutItem
      Parent = dxLayoutGroup11
      AlignHorz = ahClient
      CaptionOptions.Text = 'cxDBCheckBox6'
      CaptionOptions.Visible = False
      Control = chkSword
      ControlOptions.OriginalHeight = 17
      ControlOptions.OriginalWidth = 120
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liShield: TdxLayoutItem
      Parent = dxLayoutGroup11
      AlignHorz = ahClient
      CaptionOptions.Text = 'cxDBCheckBox7'
      CaptionOptions.Visible = False
      Control = chkShield
      ControlOptions.OriginalHeight = 17
      ControlOptions.OriginalWidth = 120
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object liLetsGoEevee: TdxLayoutItem
      Parent = dxLayoutGroup11
      AlignHorz = ahClient
      CaptionOptions.Text = 'cxDBCheckBox8'
      CaptionOptions.Visible = False
      Control = chkLetsGoEevee
      ControlOptions.OriginalHeight = 17
      ControlOptions.OriginalWidth = 120
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object liLetsGoPikachu: TdxLayoutItem
      Parent = dxLayoutGroup12
      AlignHorz = ahClient
      CaptionOptions.Text = 'cxDBCheckBox9'
      CaptionOptions.Visible = False
      Control = chkLetsGoPikachu
      ControlOptions.OriginalHeight = 17
      ControlOptions.OriginalWidth = 120
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object liBrilliantDiamond: TdxLayoutItem
      Parent = dxLayoutGroup12
      AlignHorz = ahClient
      CaptionOptions.Text = 'cxDBCheckBox10'
      CaptionOptions.Visible = False
      Control = chkBrilliantDiamond
      ControlOptions.OriginalHeight = 17
      ControlOptions.OriginalWidth = 120
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object liShiningPearl: TdxLayoutItem
      Parent = dxLayoutGroup12
      AlignHorz = ahClient
      CaptionOptions.Text = 'cxDBCheckBox11'
      CaptionOptions.Visible = False
      Control = chkShiningPearl
      ControlOptions.OriginalHeight = 17
      ControlOptions.OriginalWidth = 120
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object liLegendsArceus: TdxLayoutItem
      Parent = dxLayoutGroup12
      AlignHorz = ahClient
      CaptionOptions.Text = 'cxDBCheckBox12'
      CaptionOptions.Visible = False
      Control = chkLegendsArceus
      ControlOptions.OriginalHeight = 17
      ControlOptions.OriginalWidth = 120
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object liHome: TdxLayoutGroup
      Parent = dxLayoutGroup9
      AlignHorz = ahClient
      CaptionOptions.Text = 'New Group'
      ShowBorder = False
      Index = 3
    end
    object dxLayoutItem1: TdxLayoutItem
      Parent = liHome
      CaptionOptions.Text = 'cxDBCheckBox1'
      CaptionOptions.Visible = False
      Control = chkHome
      ControlOptions.OriginalHeight = 17
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
  end
  object btnPost: TcxButton
    Left = 707
    Top = 668
    Width = 75
    Height = 25
    Action = actPost
    Anchors = [akRight, akBottom]
    TabOrder = 2
  end
  object mdsEvents: TdxMemData
    Indexes = <>
    SortOptions = []
    BeforePost = mdsEventsBeforePost
    BeforeDelete = mdsEventsBeforeDelete
    AfterScroll = mdsEventsAfterScroll
    OnNewRecord = mdsEventsNewRecord
    Left = 40
    Top = 32
    object mdsEventsAWSID: TWideStringField
      FieldName = 'AWSID'
      Size = 36
    end
    object mdsEventsTitle: TWideStringField
      FieldName = 'Title'
      Size = 100
    end
    object mdsEventsSpecies: TWideStringField
      FieldName = 'Species'
      Size = 30
    end
    object mdsEventsDescription: TMemoField
      FieldName = 'Description'
      BlobType = ftMemo
    end
    object mdsEventsKind: TWideStringField
      FieldName = 'Kind'
      Size = 30
    end
    object mdsEventsRegion: TSmallintField
      FieldName = 'Region'
    end
    object mdsEventsGender: TSmallintField
      FieldName = 'Gender'
    end
    object mdsEventsBall: TWideStringField
      FieldName = 'Ball'
    end
    object mdsEventsOT: TWideStringField
      FieldName = 'OT'
      Size = 30
    end
    object mdsEventsTID: TWideStringField
      FieldName = 'TID'
      Size = 6
    end
    object mdsEventsAbility: TWideStringField
      FieldName = 'Ability'
      Size = 30
    end
    object mdsEventsNature: TWideStringField
      FieldName = 'Nature'
      Size = 30
    end
    object mdsEventsCode: TWideStringField
      FieldName = 'Code'
      Size = 30
    end
    object mdsEventsLevel: TIntegerField
      FieldName = 'Level'
    end
    object mdsEventsShiny: TBooleanField
      FieldName = 'Shiny'
    end
    object mdsEventsGigantamax: TBooleanField
      FieldName = 'Gigantamax'
    end
    object mdsEventsStartDate: TDateTimeField
      FieldName = 'StartDate'
    end
    object mdsEventsEndDate: TDateTimeField
      FieldName = 'EndDate'
    end
    object mdsEventsSun: TBooleanField
      FieldName = 'Sun'
    end
    object mdsEventsMoon: TBooleanField
      FieldName = 'Moon'
    end
    object mdsEventsUltraSun: TBooleanField
      FieldName = 'UltraSun'
    end
    object mdsEventsUltraMoon: TBooleanField
      FieldName = 'UltraMoon'
    end
    object mdsEventsGO: TBooleanField
      FieldName = 'GO'
    end
    object mdsEventsSword: TBooleanField
      FieldName = 'Sword'
    end
    object mdsEventsShield: TBooleanField
      FieldName = 'Shield'
    end
    object mdsEventsLetsGoEevee: TBooleanField
      FieldName = 'LetsGoEevee'
    end
    object mdsEventsLetsGoPikachu: TBooleanField
      FieldName = 'LetsGoPikachu'
    end
    object mdsEventsBrilliantDiamond: TBooleanField
      FieldName = 'BrilliantDiamond'
    end
    object mdsEventsShiningPearl: TBooleanField
      FieldName = 'ShiningPearl'
    end
    object mdsEventsLegendsArceus: TBooleanField
      FieldName = 'LegendsArceus'
    end
    object mdsEventsHoldItem: TWideStringField
      FieldName = 'HoldItem'
      Size = 30
    end
    object mdsEventsHome: TBooleanField
      FieldName = 'Home'
    end
    object mdsEventsLocations: TMemoField
      FieldName = 'Locations'
      BlobType = ftMemo
    end
    object mdsEventsMoves: TMemoField
      FieldName = 'Moves'
      BlobType = ftMemo
    end
    object mdsEventsMarks: TMemoField
      FieldName = 'Marks'
      BlobType = ftMemo
    end
    object mdsEventsRibbons: TMemoField
      FieldName = 'Ribbons'
      BlobType = ftMemo
    end
  end
  object dtsEvents: TDataSource
    DataSet = mdsEvents
    Left = 72
    Top = 32
  end
  object dtsRegion: TDataSource
    Left = 280
    Top = 32
  end
  object dtsGender: TDataSource
    Left = 672
    Top = 248
  end
  object Actions: TActionList
    Left = 552
    Top = 656
    object actPost: TAction
      Caption = 'Post'
      OnExecute = actPostExecute
      OnUpdate = actPostUpdate
    end
  end
end
