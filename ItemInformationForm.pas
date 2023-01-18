unit ItemInformationForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, ItemClass, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TItemInfo = class(TForm)
    pPathAdd: TPanel;
    pCreatedDate: TPanel;
    pDueDate: TPanel;
    pCompletedDate: TPanel;
    pPriority: TPanel;
    pDaysUntilDue: TPanel;
    pUrgency: TPanel;
    pCompletionStatus: TPanel;
    lPriority: TLabel;
    lDaysUntilDue: TLabel;
    lUrgency: TLabel;
    lCompleted: TLabel;
    lCreatedDate: TLabel;
    lDueDate: TLabel;
    lCompletedDate: TLabel;
    eTitle: TEdit;
    mDesc: TMemo;
    pArchiveNum: TPanel;
    lArchiveNum: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    FItem: TItem;
    class procedure Execute(var Item: TItem);
    procedure Populate;
  end;

var
  ItemInfo: TItemInfo;

implementation

uses ToDoApp, System.DateUtils;

{$R *.dfm}

class procedure TItemInfo.Execute(var Item: TItem);
begin
  with TItemInfo.Create(nil) do
  begin
    try
      FItem := Item;
      Caption := 'Info: ' + FItem.Title;
      Populate;
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TItemInfo.Populate;
begin
  pPathAdd.Caption := FItem.ItemOrigin;
  pArchiveNum.Caption := IntToStr(Fitem.ArchiveNumber);
  eTitle.Text := FItem.Title;
  pCreatedDate.Caption := DateToStr(FItem.CreatedDate);
  pDueDate.Caption := DateToStr(FItem.DueDate);
  pPriority.Caption := IntToStr(FItem.Priority);
  pUrgency.Caption := IntToStr(FItem.CalculateUrgencyValue);


  if FItem.DueDate < Now then
     pDaysUntilDue.Caption := '-' + IntToStr(DaysBetween(Now, FItem.DueDate))
  else
    pDaysUntilDue.Caption := IntToStr(DaysBetween(Now, FItem.DueDate));

  if FItem.IsCompleted then
  begin
    pCompletedDate.Caption := DateToStr(FItem.CompletedDate);
    pCompletionStatus.Caption := 'Complete';
  end
  else
  begin
    pCompletedDate.Caption := 'N/A';
    pCompletionStatus.Caption := 'Incomplete';
  end;

  mDesc.Text := FItem.Desc.Text;
end;

end.
