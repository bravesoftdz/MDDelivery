object fFormNewCard: TfFormNewCard
  Left = 242
  Top = 52
  BorderStyle = bsNone
  Caption = #29992#25143#33258#21161#21150#21345
  ClientHeight = 624
  ClientWidth = 938
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 938
    Height = 89
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 256
      Top = 56
      Width = 297
      Height = 29
      AutoSize = False
      Caption = '('#21487#24405#20837#25110#25195#25551#20108#32500#30721')'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object labelIdCard: TcxLabel
      Left = 0
      Top = 8
      Caption = #21830#22478#35746#21333#21495#65306
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -32
      Style.Font.Name = 'MS Sans Serif'
      Style.Font.Style = []
      Style.IsFontAssigned = True
    end
    object editWebOrderNo: TcxTextEdit
      Left = 176
      Top = 8
      AutoSize = False
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -32
      Style.Font.Name = 'MS Sans Serif'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 1
      OnKeyPress = editWebOrderNoKeyPress
      Height = 41
      Width = 377
    end
    object btnQuery: TcxButton
      Left = 576
      Top = 8
      Width = 209
      Height = 73
      Caption = #26174#31034#32593#19978#35746#21333#35814#24773
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnQueryClick
    end
    object btnClear: TcxButton
      Left = 792
      Top = 8
      Width = 113
      Height = 73
      Caption = #28165#38500#36755#20837
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = btnClearClick
    end
  end
  object PanelBody: TPanel
    Left = 0
    Top = 241
    Width = 938
    Height = 388
    BevelOuter = bvNone
    TabOrder = 1
    object dxLayout1: TdxLayoutControl
      Left = 0
      Top = 0
      Width = 938
      Height = 388
      Align = alClient
      TabOrder = 0
      TabStop = False
      object BtnOK: TButton
        Left = 580
        Top = 328
        Width = 250
        Height = 41
        Caption = #30830#35748#26080#35823#24182#21150#21345
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
        OnClick = BtnOKClick
      end
      object BtnExit: TButton
        Left = 836
        Top = 328
        Width = 92
        Height = 41
        Caption = #21462#28040
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
        OnClick = BtnExitClick
      end
      object EditValue: TcxTextEdit
        Left = 440
        Top = 230
        ParentFont = False
        Properties.ReadOnly = True
        Style.BorderColor = clWindowFrame
        Style.BorderStyle = ebs3D
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -24
        Style.Font.Name = 'MS Sans Serif'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 7
        Width = 100
      end
      object EditCus: TcxTextEdit
        Left = 78
        Top = 28
        ParentFont = False
        Properties.ReadOnly = True
        Style.BorderColor = clWindowFrame
        Style.BorderStyle = ebs3D
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -24
        Style.Font.Name = 'MS Sans Serif'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 0
        Width = 838
      end
      object EditCName: TcxTextEdit
        Left = 78
        Top = 71
        ParentFont = False
        Properties.ReadOnly = True
        Style.BorderColor = clWindowFrame
        Style.BorderStyle = ebs3D
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -24
        Style.Font.Name = 'MS Sans Serif'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 1
        Width = 339
      end
      object EditStock: TcxTextEdit
        Left = 78
        Top = 144
        ParentFont = False
        Properties.ReadOnly = True
        Style.BorderColor = clWindowFrame
        Style.BorderStyle = ebs3D
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -24
        Style.Font.Name = 'MS Sans Serif'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 2
        Width = 300
      end
      object EditSName: TcxTextEdit
        Left = 440
        Top = 144
        ParentFont = False
        Properties.ReadOnly = True
        Style.BorderColor = clWindowFrame
        Style.BorderStyle = ebs3D
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -24
        Style.Font.Name = 'MS Sans Serif'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 3
        Width = 336
      end
      object EditTruck: TcxButtonEdit
        Left = 78
        Top = 230
        ParentFont = False
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ReadOnly = True
        Style.BorderColor = clWindowFrame
        Style.BorderStyle = ebs3D
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -24
        Style.Font.Name = 'MS Sans Serif'
        Style.Font.Style = []
        Style.ButtonStyle = bts3D
        Style.IsFontAssigned = True
        TabOrder = 6
        Width = 300
      end
      object EditType: TcxComboBox
        Left = 78
        Top = 187
        ParentFont = False
        Properties.DropDownListStyle = lsEditFixedList
        Properties.ItemHeight = 18
        Properties.Items.Strings = (
          'C=C'#12289#26222#36890
          'Z=Z'#12289#26632#21488
          'V=V'#12289'VIP'
          'S=S'#12289#33337#36816)
        Style.BorderColor = clWindowFrame
        Style.BorderStyle = ebs3D
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -24
        Style.Font.Name = 'MS Sans Serif'
        Style.Font.Style = []
        Style.ButtonStyle = bts3D
        Style.PopupBorderStyle = epbsFrame3D
        Style.IsFontAssigned = True
        TabOrder = 4
        Width = 300
      end
      object EditPrice: TcxButtonEdit
        Left = 440
        Top = 187
        ParentFont = False
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Style.BorderColor = clWindowFrame
        Style.BorderStyle = ebs3D
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -24
        Style.Font.Name = 'MS Sans Serif'
        Style.Font.Style = []
        Style.ButtonStyle = bts3D
        Style.IsFontAssigned = True
        TabOrder = 5
        Width = 353
      end
      object EditMemo: TcxTextEdit
        Left = 587
        Top = 230
        ParentFont = False
        Properties.ReadOnly = True
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -24
        Style.Font.Name = 'MS Sans Serif'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 8
        Width = 160
      end
      object EditSJName: TcxTextEdit
        Left = 78
        Top = 273
        ParentFont = False
        Properties.ReadOnly = True
        Style.BorderColor = clWindowFrame
        Style.BorderStyle = ebs3D
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -24
        Style.Font.Name = 'MS Sans Serif'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 9
        Width = 140
      end
      object dxLayoutGroup1: TdxLayoutGroup
        ShowCaption = False
        Hidden = True
        ShowBorder = False
        object dxGroup1: TdxLayoutGroup
          object dxlytmLayout1Item3: TdxLayoutItem
            Caption = #23458#25143#32534#21495':'
            Control = EditCus
            ControlOptions.ShowBorder = False
          end
          object dxlytmLayout1Item4: TdxLayoutItem
            Caption = #23458#25143#21517#31216':'
            Control = EditCName
            ControlOptions.ShowBorder = False
          end
        end
        object dxGroup2: TdxLayoutGroup
          AutoAligns = [aaVertical]
          object dxLayout1Group1: TdxLayoutGroup
            AutoAligns = [aaVertical]
            ShowCaption = False
            Hidden = True
            LayoutDirection = ldHorizontal
            ShowBorder = False
            object dxlytmLayout1Item9: TdxLayoutItem
              Caption = #27700#27877#32534#21495':'
              Control = EditStock
              ControlOptions.ShowBorder = False
            end
            object dxlytmLayout1Item10: TdxLayoutItem
              Caption = #27700#27877#21517#31216':'
              Control = EditSName
              ControlOptions.ShowBorder = False
            end
          end
          object dxGroupLayout1Group5: TdxLayoutGroup
            AutoAligns = [aaVertical]
            ShowCaption = False
            Hidden = True
            ShowBorder = False
            object dxLayout1Group2: TdxLayoutGroup
              ShowCaption = False
              Hidden = True
              LayoutDirection = ldHorizontal
              ShowBorder = False
              object dxlytmLayout1Item13: TdxLayoutItem
                Caption = #25552#36135#36890#36947':'
                Control = EditType
                ControlOptions.ShowBorder = False
              end
              object dxLayout1Item11: TdxLayoutItem
                Caption = #27700#27877#21333#20215':'
                Control = EditPrice
                ControlOptions.ShowBorder = False
              end
            end
            object dxGroupLayout1Group6: TdxLayoutGroup
              ShowCaption = False
              Hidden = True
              ShowBorder = False
              object dxLayout1Group3: TdxLayoutGroup
                ShowCaption = False
                Hidden = True
                LayoutDirection = ldHorizontal
                ShowBorder = False
                object dxlytmLayout1Item12: TdxLayoutItem
                  Caption = #25552#36135#36710#36742':'
                  Control = EditTruck
                  ControlOptions.ShowBorder = False
                end
                object dxLayout1Item8: TdxLayoutItem
                  Caption = #21150#29702#21544#25968':'
                  Control = EditValue
                  ControlOptions.ShowBorder = False
                end
                object dxLayout1Item1: TdxLayoutItem
                  Caption = #22791#27880#65306
                  Control = EditMemo
                  ControlOptions.ShowBorder = False
                end
              end
              object dxLayout1Item32: TdxLayoutItem
                Caption = #21496#26426#22995#21517':'
                Control = EditSJName
                ControlOptions.ShowBorder = False
              end
            end
          end
        end
        object dxLayoutGroup3: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          LayoutDirection = ldHorizontal
          ShowBorder = False
          object dxLayoutItem1: TdxLayoutItem
            AutoAligns = [aaVertical]
            AlignHorz = ahRight
            Control = BtnOK
            ControlOptions.ShowBorder = False
          end
          object dxLayout1Item2: TdxLayoutItem
            AutoAligns = [aaVertical]
            AlignHorz = ahRight
            Control = BtnExit
            ControlOptions.ShowBorder = False
          end
        end
      end
    end
  end
  object pnlMiddle: TPanel
    Left = 0
    Top = 89
    Width = 938
    Height = 152
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlMiddle'
    TabOrder = 2
    object cxLabel1: TcxLabel
      Left = 0
      Top = 0
      Align = alTop
      Caption = #35746#21333#21015#34920
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -19
      Style.Font.Name = 'MS Sans Serif'
      Style.Font.Style = []
      Style.IsFontAssigned = True
    end
    object lvOrders: TListView
      Left = 0
      Top = 28
      Width = 938
      Height = 124
      Align = alClient
      Columns = <>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      RowSelect = True
      ParentFont = False
      TabOrder = 1
      OnClick = lvOrdersClick
    end
  end
  object TimerAutoClose: TTimer
    Enabled = False
    OnTimer = TimerAutoCloseTimer
    Left = 528
    Top = 89
  end
end
