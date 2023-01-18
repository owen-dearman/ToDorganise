object ToDo: TToDo
  Left = 69
  Top = 81
  ActiveControl = bCreate
  Anchors = [akLeft, akTop, akRight, akBottom]
  Caption = 'ToDoR - The Organisation Tool'
  ClientHeight = 686
  ClientWidth = 999
  Color = clGradientInactiveCaption
  Constraints.MinHeight = 640
  Constraints.MinWidth = 840
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu
  Position = poDesigned
  ScreenSnap = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    999
    686)
  TextHeight = 15
  object lIncomplete: TLabel
    Left = 8
    Top = 253
    Width = 157
    Height = 25
    Caption = 'Incomplete Items'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -20
    Font.Name = 'Ink Free'
    Font.Style = []
    ParentFont = False
  end
  object lComplete: TLabel
    Left = 8
    Top = 487
    Width = 139
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Complete Items'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -20
    Font.Name = 'Ink Free'
    Font.Style = []
    ParentFont = False
  end
  object lCreate: TLabel
    Left = 8
    Top = 5
    Width = 138
    Height = 25
    Caption = 'Create An Item'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -20
    Font.Name = 'Ink Free'
    Font.Style = []
    ParentFont = False
  end
  object lTitle: TLabel
    Left = 22
    Top = 47
    Width = 23
    Height = 14
    Caption = '&Title'
    FocusControl = eTitle
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'Corbel'
    Font.Style = []
    ParentFont = False
  end
  object lDescription: TLabel
    Left = 4
    Top = 67
    Width = 56
    Height = 14
    Caption = '&Description'
    FocusControl = mDesc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'Corbel'
    Font.Style = []
    ParentFont = False
  end
  object lPriority: TLabel
    Left = 8
    Top = 219
    Width = 37
    Height = 14
    Caption = '&Priority'
    FocusControl = tbPriority
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'Corbel'
    Font.Style = []
    ParentFont = False
  end
  object lPriNum: TLabel
    Left = 719
    Top = 215
    Width = 21
    Height = 20
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = '1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Corbel'
    Font.Style = []
    ParentFont = False
    ExplicitLeft = 727
  end
  object bCreate: TButton
    Left = 852
    Top = 241
    Width = 147
    Height = 38
    Anchors = [akTop, akRight]
    Caption = 'Create'
    Default = True
    TabOrder = 0
    OnClick = bCreateClick
  end
  object bClearAll: TButton
    Left = 754
    Top = 241
    Width = 92
    Height = 38
    Anchors = [akTop, akRight]
    Caption = 'Clear All'
    TabOrder = 1
    OnClick = bClearAllClick
  end
  object eTitle: TEdit
    Left = 66
    Top = 34
    Width = 655
    Height = 23
    Hint = 
      'Title is required, cannot be duplicated, and must not contain | ' +
      'or ~ '
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Corbel'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
  end
  object cbIncompleteList: TCheckListBox
    Left = 8
    Top = 285
    Width = 979
    Height = 196
    Hint = 'These are your items to do'
    TabStop = False
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoComplete = False
    BiDiMode = bdLeftToRight
    BorderStyle = bsNone
    Ctl3D = False
    DoubleBuffered = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'Corbel'
    Font.Style = []
    ItemHeight = 30
    ParentBiDiMode = False
    ParentCtl3D = False
    ParentDoubleBuffered = False
    ParentFont = False
    ParentShowHint = False
    PopupMenu = IncompletePopup
    ShowHint = True
    Style = lbOwnerDrawFixed
    TabOrder = 3
    OnClickCheck = cbIncompleteListClickCheck
    OnDblClick = cbIncompleteListDblClick
    OnDrawItem = cbIncompleteListDrawItem
    OnMouseDown = cbIncompleteListMouseDown
  end
  object cbCompleteList: TCheckListBox
    Left = 8
    Top = 518
    Width = 979
    Height = 159
    Hint = 'These are the items you'#39've done!'
    TabStop = False
    Anchors = [akLeft, akRight, akBottom]
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Corbel'
    Font.Style = [fsStrikeOut]
    ItemHeight = 20
    ParentFont = False
    ParentShowHint = False
    PopupMenu = CompletePopup
    ShowHint = True
    Style = lbOwnerDrawFixed
    TabOrder = 4
    OnClickCheck = cbCompleteListClickCheck
    OnDblClick = cbCompleteListDblClick
    OnDrawItem = cbCompleteListDrawItem
    OnMouseDown = cbCompleteListMouseDown
  end
  object mDesc: TMemo
    Left = 66
    Top = 63
    Width = 674
    Height = 123
    Hint = 'Add some detail to your item here'
    Anchors = [akLeft, akTop, akRight]
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Corbel'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ScrollBars = ssVertical
    ShowHint = True
    TabOrder = 5
  end
  object tbPriority: TTrackBar
    Left = 51
    Top = 207
    Width = 654
    Height = 40
    Hint = 'P1 (left) is higher priority'
    Anchors = [akLeft, akTop, akRight]
    Min = 1
    ParentShowHint = False
    Position = 1
    ShowHint = True
    TabOrder = 6
    TickMarks = tmBoth
    OnChange = tbPriorityChange
  end
  object dtDueDate: TCalendarView
    Left = 754
    Top = 8
    Width = 245
    Height = 227
    Hint = 'Add a due date ...'
    Anchors = [akTop, akRight]
    Date = 44869.000000000000000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 15
    Font.Name = 'Segoe UI'
    Font.Style = []
    HeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
    HeaderInfo.DaysOfWeekFont.Color = clWindowText
    HeaderInfo.DaysOfWeekFont.Height = -13
    HeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
    HeaderInfo.DaysOfWeekFont.Style = []
    HeaderInfo.Font.Charset = DEFAULT_CHARSET
    HeaderInfo.Font.Color = clWindowText
    HeaderInfo.Font.Height = -20
    HeaderInfo.Font.Name = 'Segoe UI'
    HeaderInfo.Font.Style = []
    ParentFont = False
    ParentShowHint = False
    SelectionColor = clYellow
    ShowHint = False
    TabOrder = 7
    TodayColor = clGray
  end
  object IncompletePopup: TPopupMenu
    Left = 84
    Top = 429
    object IncompleteOpenEdit: TMenuItem
      Caption = 'Open And Edit'
      ShortCut = 16463
      OnClick = cbIncompleteListDblClick
    end
    object IncompleteComplete: TMenuItem
      Caption = 'Complete'
      ShortCut = 16397
      OnClick = cbIncompleteListClickCheck
    end
    object IncompleteDelete: TMenuItem
      Caption = 'Delete'
      ShortCut = 16430
      OnClick = IncompleteDeleteMenuItemClick
    end
  end
  object CompletePopup: TPopupMenu
    Left = 74
    Top = 547
    object CompleteOpenEdit: TMenuItem
      Caption = 'Open And Edit'
      ShortCut = 16463
      OnClick = cbCompleteListDblClick
    end
    object CompleteUnComplete: TMenuItem
      Caption = 'UnComplete'
      ShortCut = 16397
      OnClick = cbCompleteListClickCheck
    end
    object CompleteDelete: TMenuItem
      Caption = 'Delete'
      ShortCut = 16452
      OnClick = CompleteDeleteMenuItemClick
    end
    object Archive1: TMenuItem
      Caption = 'Archive'
      ShortCut = 16449
      OnClick = Archive1Click
    end
  end
  object MainMenu: TMainMenu
    OwnerDraw = True
    Left = 725
    Top = 65483
    object File1: TMenuItem
      Caption = 'File'
      object Close: TMenuItem
        Caption = 'Close'
        OnClick = CloseClick
      end
      object New1: TMenuItem
        Caption = 'New'
        OnClick = New1Click
      end
      object Open1: TMenuItem
        Caption = 'Open'
        OnClick = OpenClick
      end
      object Save1: TMenuItem
        Caption = 'Save'
        OnClick = SaveClick
      end
      object Save2: TMenuItem
        Caption = 'Save As'
        OnClick = SaveAsClick
      end
      object Exit1: TMenuItem
        Caption = 'Force Exit'
        OnClick = Exit1Click
      end
    end
    object Edit1: TMenuItem
      Caption = 'Edit'
      object DeleteAll1: TMenuItem
        Caption = 'Delete...'
        object IncompleteItems1: TMenuItem
          Caption = 'Incomplete Items'
          OnClick = DeleteAllIncompleteClick
        end
        object CompleteItems1: TMenuItem
          Caption = 'Complete Items'
          OnClick = DeleteAllCompleteClick
        end
        object All1: TMenuItem
          Caption = 'All Items'
          OnClick = DeleteAllItemsClick
        end
      end
      object Check1: TMenuItem
        Caption = 'Check All...'
        object CheckIncomplete: TMenuItem
          Caption = 'Incomplete Items'
          OnClick = CompleteAllItemsClick
        end
        object CheckComplete: TMenuItem
          Caption = 'Complete Items'
          OnClick = IncompleteAllItemsClick
        end
      end
      object ClearOldItems1: TMenuItem
        Caption = 'Clear Old Items'
        object N30Days1: TMenuItem
          Caption = '>30 Days'
          OnClick = N30Days1Click
        end
        object N60Days1: TMenuItem
          Caption = '>60 Days'
          OnClick = N60Days1Click
        end
        object N1Year1: TMenuItem
          Caption = '> 1 Year'
          OnClick = N1Year1Click
        end
      end
      object ArchiveOldItems1: TMenuItem
        Caption = 'Archive Old Items'
        object AllCompleted1: TMenuItem
          Caption = 'All Completed'
          OnClick = AllCompleted1Click
        end
        object N30Days2: TMenuItem
          Caption = '> 30 Days'
          OnClick = N30Days2Click
        end
        object N30Days3: TMenuItem
          Caption = '> 60 Days'
          OnClick = N30Days3Click
        end
      end
    end
    object ools1: TMenuItem
      Caption = 'Tools'
      object Search1: TMenuItem
        Caption = 'Search Archive'
        OnClick = Search1Click
      end
      object CreateBackUp1: TMenuItem
        Caption = 'Create Back-Up'
        OnClick = CreateBackUp1Click
      end
      object RemoveSavedListonStartup1: TMenuItem
        Caption = 'Remove Saved List on Startup'
        OnClick = RemoveSavedListonStartup1Click
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object Help2: TMenuItem
        Caption = 'Help'
        OnClick = Help2Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Help3: TMenuItem
        Caption = 'About'
        OnClick = About1Click
      end
    end
  end
end
