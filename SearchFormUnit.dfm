object SearchForm: TSearchForm
  Left = 0
  Top = 0
  ActiveControl = bSearch
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Search All Items'
  ClientHeight = 719
  ClientWidth = 634
  Color = clBtnFace
  Constraints.MaxHeight = 900
  Constraints.MaxWidth = 650
  Constraints.MinHeight = 700
  Constraints.MinWidth = 650
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  DesignSize = (
    634
    719)
  TextHeight = 15
  object lNowShow: TLabel
    Left = 8
    Top = 48
    Width = 71
    Height = 20
    Caption = 'lNowShow'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object eSearchBar: TEdit
    Left = 8
    Top = 8
    Width = 465
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object bSearch: TButton
    Left = 479
    Top = 8
    Width = 143
    Height = 33
    Caption = 'Search'
    TabOrder = 1
    OnClick = bSearchClick
  end
  object lbResults: TListBox
    Left = 8
    Top = 74
    Width = 614
    Height = 639
    Anchors = [akLeft, akTop, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemHeight = 20
    ParentFont = False
    TabOrder = 2
    OnDblClick = lbResultsDblClick
  end
end
