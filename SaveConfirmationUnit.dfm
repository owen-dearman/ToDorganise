object SaveConfirmation: TSaveConfirmation
  Left = 286
  Top = 312
  ActiveControl = bSave
  BorderIcons = []
  ClientHeight = 85
  ClientWidth = 231
  Color = clBtnFace
  Constraints.MaxHeight = 124
  Constraints.MaxWidth = 247
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  TextHeight = 15
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 231
    Height = 20
    Align = alTop
    Alignment = taCenter
    Caption = 'Do you want to save changes?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 200
  end
  object bNoSave: TButton
    Left = 133
    Top = 40
    Width = 92
    Height = 37
    Caption = 'Don'#39't Save'
    ModalResult = 2
    TabOrder = 0
  end
  object bSave: TButton
    Left = 40
    Top = 40
    Width = 87
    Height = 37
    Caption = 'Save'
    Constraints.MaxHeight = 37
    Constraints.MaxWidth = 87
    ModalResult = 1
    TabOrder = 1
  end
end
