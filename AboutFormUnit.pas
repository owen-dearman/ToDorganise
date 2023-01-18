unit AboutFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TAboutForm = class(TForm)
    lVersion: TLabel;
    lAuthor: TLabel;
    lAppDir: TLabel;
    lStorageDir: TLabel;
    Name: TLabel;
    Author: TLabel;
    Version: TLabel;
    AppDir: TLabel;
    StorageDir: TLabel;
    lListName: TLabel;
    lNumberItems: TLabel;
    lName: TLabel;
    ListName: TLabel;
    NumberItems: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure Execute;
  end;

var
  AboutForm: TAboutForm;

implementation

{$R *.dfm}

uses
ToDoApp;

class procedure TAboutForm.Execute;
begin
  with TAboutForm.Create(nil) do
  begin
    try
      AppDir.Caption := ExtractFilePath(Application.ExeName) + ExtractFileName(Application.ExeName) ;
      ListName.Caption := FileName;
      StorageDir.Caption := FilePath;
      NumberItems.Caption := IntToStr(ListOfItems.Count);
      ShowModal;
    finally
      Free;
    end;
  end;
end;

end.
