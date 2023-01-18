object ItemInfo: TItemInfo
  Left = 592
  Top = 249
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'ItemInfo'
  ClientHeight = 522
  ClientWidth = 888
  Color = clBtnFace
  Constraints.MaxHeight = 561
  Constraints.MaxWidth = 904
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = 16
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  TextHeight = 15
  object lPriority: TLabel
    Left = 615
    Top = 145
    Width = 47
    Height = 20
    Caption = 'Priority'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lDaysUntilDue: TLabel
    Left = 564
    Top = 192
    Width = 98
    Height = 20
    Caption = 'Days Until Due'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lUrgency: TLabel
    Left = 608
    Top = 239
    Width = 54
    Height = 20
    Caption = 'Urgency'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lCompleted: TLabel
    Left = 543
    Top = 313
    Width = 122
    Height = 20
    Caption = 'Completion Status'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lCreatedDate: TLabel
    Left = 574
    Top = 388
    Width = 88
    Height = 20
    Caption = 'Created Date'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lDueDate: TLabel
    Left = 599
    Top = 435
    Width = 63
    Height = 20
    Caption = 'Due Date'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lCompletedDate: TLabel
    Left = 552
    Top = 482
    Width = 110
    Height = 20
    Caption = 'Completed Date'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lArchiveNum: TLabel
    Left = 555
    Top = 98
    Width = 107
    Height = 20
    Caption = 'Archive Number'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object pPathAdd: TPanel
    Left = 0
    Top = 0
    Width = 889
    Height = 41
    Caption = 'pPathAdd'
    TabOrder = 0
  end
  object pCreatedDate: TPanel
    Left = 681
    Top = 379
    Width = 208
    Height = 41
    Caption = 'pCreatedDate'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object pDueDate: TPanel
    Left = 679
    Top = 426
    Width = 209
    Height = 41
    Caption = 'pDueDate'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object pCompletedDate: TPanel
    Left = 681
    Top = 473
    Width = 208
    Height = 41
    Caption = 'pCompletedDate'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object pPriority: TPanel
    Left = 679
    Top = 136
    Width = 208
    Height = 41
    Caption = 'pPriority'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object pDaysUntilDue: TPanel
    Left = 680
    Top = 183
    Width = 208
    Height = 41
    Caption = 'pDaysUntilDue'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object pUrgency: TPanel
    Left = 679
    Top = 230
    Width = 208
    Height = 41
    Caption = 'pUrgency'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object pCompletionStatus: TPanel
    Left = 681
    Top = 304
    Width = 208
    Height = 41
    Caption = 'pCompletionStatus'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object eTitle: TEdit
    Left = 0
    Top = 47
    Width = 888
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    Text = 'eTitle'
  end
  object mDesc: TMemo
    Left = 0
    Top = 88
    Width = 537
    Height = 401
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 16
    Font.Name = 'Segoe UI'
    Font.Style = []
    Lines.Strings = (
      'mDesc')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 9
  end
  object pArchiveNum: TPanel
    Left = 679
    Top = 89
    Width = 208
    Height = 41
    Caption = 'pArchiveNum'
    TabOrder = 10
  end
end
