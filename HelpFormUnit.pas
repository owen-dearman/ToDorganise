unit HelpFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.OleCtrls, SHDocVw;

type
  THelpForm = class(TForm)
    WebBrowser1: TWebBrowser;
  private
    { Private declarations }
  public
    class procedure Execute;
  end;

var
  HelpForm: THelpForm;

implementation

{$R *.dfm}

class procedure THelpForm.Execute;
begin
  with THelpForm.Create(nil) do
  begin
    try
      var HTMLPath := ExtractFileDir(Application.ExeName) + '/config/helpinfo.html';
      WebBrowser1.Navigate(HTMLPath);
      ShowModal;
    finally
      Free;
    end;
  end;
end;

end.
