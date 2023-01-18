unit SaveConfirmationUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TSaveConfirmation = class(TForm)
    Label1: TLabel;
    bNoSave: TButton;
    bSave: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
    class function Execute: Boolean;
  end;

var
  SaveConfirmationForm: TSaveConfirmation;

implementation

{$R *.dfm}

class function TSaveConfirmation.Execute: Boolean;
begin
  with TSaveConfirmation.Create(nil)do
  begin
    try
      ShowModal;
      if ModalResult = mrOK then
        Result := True
      else
        Result := False;
    finally
      Free;
    end;
  end;
end;

end.
