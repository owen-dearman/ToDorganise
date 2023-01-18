unit EditFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, ItemClass,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.CheckLst, Vcl.ExtCtrls;

type
  TEditForm = class(TForm)
    bSave: TButton;
    eTitle: TEdit;
    mDesc: TMemo;
    dtCreationDate, dtDueDate: TDateTimePicker;
    pIsCompleted: TPanel;
    pUrgencyMetric: TPanel;
    lTitle: TLabel;
    lDes: TLabel;
    lPriority: TLabel;
    lCreationDate: TLabel;
    lDueDate: TLabel;
    lUrgency: TLabel;
    lIsCompleted: TLabel;
    pDaysUntilDue: TPanel;
    lDaysUntilDue: TLabel;
    bCancel: TButton;
    tbPriority: TTrackBar;
    lError: TLabel;
    lPriNum: TLabel;
    dtCompletedDate: TDateTimePicker;
    procedure dtDueDateChange(Sender: TObject);
    procedure tbPriorityChange(Sender: TObject);
    procedure eTitleChange(Sender: TObject);
  private
    { Private declarations }
    ChangedDueDate: TDate;
    ChangedPriority: Integer;
    FItem: TItem;
    procedure Populate;
  public
    { Public declarations }
    class function Execute(const ItemClass: TItem): TItem;
  end;

var
  EditItemPopup: TEditForm;

implementation

{$R *.dfm}

uses
  ToDoApp, DateUtils, System.StrUtils;

{ TEditForm }

procedure TEditForm.dtDueDateChange(Sender: TObject);
begin
  if dtDueDate.date = Today.GetDate then
    pDaysUntilDue.Caption := '0'
  else if dtDueDate.date < Today.GetDate then
  begin
    pDaysUntilDue.Caption := '-' + IntToStr(DaysBetween(dtDueDate.date, Today.GetDate))
  end
  else
    pDaysUntilDue.Caption := IntToStr(DaysBetween(dtDueDate.date, Today.GetDate));

  ChangedDueDate := dtDueDate.date;
  pUrgencyMetric.Caption := IntToStr(FItem.CalculateUrgencyValue(ChangedDueDate, ChangedPriority));
end;

procedure TEditForm.eTitleChange(Sender: TObject);
begin
  if eTitle.Text = '' then
  begin
    bSave.Enabled := False;
    lError.Caption := 'Item Must Have A Title!';
  end
  else if ContainsInvalidChar(eTitle.Text) then
  begin
    bSave.Enabled := False;
    lError.Caption := 'This Title Contains Invalid Characters!';
  end
  else if IsConflictingTitle(eTitle.Text, FItem) then
  begin
    bSave.Enabled := False;
    lError.Caption := 'This Title Is Already Associated With An Item!';
  end
  else
  begin
    bSave.Enabled := True;
    lError.Caption := '';
  end;

end;

class function TEditForm.Execute(const ItemClass: TItem): TItem;
begin
  with TEditForm.Create(nil) do
  begin
    try
      FItem := ItemClass;
      Caption := 'Task: ' + FItem.Title;
      Populate;
      Showmodal;
      if ModalResult = mrOk then
      begin
        var UpdatedItem := TItem.Create(eTitle.Text, mDesc.Lines, tbPriority.position, dtDueDate.date, dtCreationDate.date, FItem.IsCompleted, FItem.CompletedDate);
        if FItem.IsCompleted then
          UpdatedItem.CompletedDate := dtCompletedDate.Date;
        Result := UpdatedItem;
      end
      else
        Result := FItem;
    finally
      Free;
    end;
  end;
end;

procedure TEditForm.Populate;
begin
  eTitle.Text := FItem.Title;
  mDesc.Lines.AddStrings(FItem.Desc);
  tbPriority.position := FItem.Priority;
  dtCreationDate.date := FItem.CreatedDate;
  dtDueDate.date := FItem.DueDate;
  pUrgencyMetric.Caption := IntToStr(FItem.CalculateUrgencyValue);
  ChangedDueDate := FItem.DueDate;
  ChangedPriority := FItem.Priority;

  if dtDueDate.date = Today.GetDate then
    pDaysUntilDue.Caption := '0'
  else if dtDueDate.date < Today.GetDate then
  begin
    pDaysUntilDue.Caption := '-' + IntToStr(DaysBetween(dtDueDate.date, Today.GetDate))
  end
  else
    pDaysUntilDue.Caption := IntToStr(DaysBetween(dtDueDate.date, Today.GetDate));

  ChangedDueDate := dtDueDate.date;
  lPriNum.Caption := IntToStr(FItem.Priority);
  pUrgencyMetric.Caption := IntToStr(FItem.CalculateUrgencyValue(ChangedDueDate, ChangedPriority));

  if FItem.IsCompleted then
  begin
    dtCompletedDate.Visible := True;
    dtCompletedDate.Date := FITem.CompletedDate;
    pIsCompleted.Visible := False;
  end
  else
  begin
    dtCompletedDate.Visible := False;
    pIsCompleted.Visible := True;
    pIsCompleted.Caption := 'NO';
  end;
end;

procedure TEditForm.tbPriorityChange(Sender: TObject);
begin
  ChangedPriority := tbPriority.position;
  pUrgencyMetric.Caption := IntToStr(FItem.CalculateUrgencyValue(ChangedDueDate, ChangedPriority));
  lPriNum.Caption := IntToStr(tbPriority.position);
end;

end.
