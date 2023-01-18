unit ToDoApp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, DateUtils, System.StrUtils, System.IOUtils,
  System.Generics.Collections, ItemClass,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.CheckLst, Vcl.Styles, Vcl.ExtCtrls, Data.DB, Data.SqlExpr, Vcl.Menus, Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls, Vcl.WinXCalendars, Vcl.ExtDlgs;

type
  TItemList = TObjectList<TItem>;

  TToDo = class(TForm)
    lIncomplete: TLabel;
    lComplete: TLabel;
    lCreate: TLabel;
    bCreate: TButton;
    bClearAll: TButton;
    eTitle: TEdit;
    cbCompleteList: TCheckListBox;
    cbIncompleteList: TCheckListBox;
    mDesc: TMemo;
    lTitle: TLabel;
    lDescription: TLabel;
    lPriority: TLabel;
    tbPriority: TTrackBar;
    IncompletePopup: TPopupMenu;
    IncompleteOpenEdit: TMenuItem;
    IncompleteComplete: TMenuItem;
    IncompleteDelete: TMenuItem;
    CompletePopup: TPopupMenu;
    CompleteOpenEdit: TMenuItem;
    CompleteUnComplete: TMenuItem;
    CompleteDelete: TMenuItem;
    lPriNum: TLabel;
    MainMenu: TMainMenu;
    File1: TMenuItem;
    Edit1: TMenuItem;
    Help1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    Save2: TMenuItem;
    Exit1: TMenuItem;
    DeleteAll1: TMenuItem;
    Check1: TMenuItem;
    Help2: TMenuItem;
    ools1: TMenuItem;
    Search1: TMenuItem;
    IncompleteItems1: TMenuItem;
    CompleteItems1: TMenuItem;
    All1: TMenuItem;
    CheckIncomplete: TMenuItem;
    CheckComplete: TMenuItem;
    dtDueDate: TCalendarView;
    ClearOldItems1: TMenuItem;
    N30Days1: TMenuItem;
    N60Days1: TMenuItem;
    N1Year1: TMenuItem;
    CreateBackUp1: TMenuItem;
    New1: TMenuItem;
    Close: TMenuItem;
    RemoveSavedListonStartup1: TMenuItem;
    N2: TMenuItem;
    Help3: TMenuItem;
    ArchiveOldItems1: TMenuItem;
    AllCompleted1: TMenuItem;
    N30Days2: TMenuItem;
    N30Days3: TMenuItem;
    Archive1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure ClearAllFormElements;
    procedure ClearInputs;
    procedure SortAndAddToIncompleteList;
    procedure SortAndAddToCompleteList;
    procedure BuildFromFile;
    procedure WriteToFile(FileName: String; FilePath: String);
    procedure GetSavedListDetails;
    procedure SaveListDetails(FilePath, FileName: String);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RemoveOldItems(Num: Integer);
    function SaveFile: Boolean;
    function SaveNewFile(ProposedFileName: string; IsBackup: Boolean): Boolean;
    function QueryUserSave: Boolean;

    procedure bCreateClick(Sender: TObject);
    procedure CompleteAllItemsClick(Sender: TObject);
    procedure IncompleteAllItemsClick(Sender: TObject);
    procedure DeleteAllIncompleteClick(Sender: TObject);
    procedure DeleteAllCompleteClick(Sender: TObject);
    procedure DeleteAllItemsClick(Sender: TObject);
    procedure bClearAllClick(Sender: TObject);
    procedure cbIncompleteListClickCheck(Sender: TObject);
    procedure cbCompleteListClickCheck(Sender: TObject);
    procedure cbIncompleteListDblClick(Sender: TObject);
    procedure cbCompleteListDblClick(Sender: TObject);
    procedure cbIncompleteListDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure cbCompleteListDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure cbIncompleteListMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure IncompleteDeleteMenuItemClick(Sender: TObject);
    procedure CompleteDeleteMenuItemClick(Sender: TObject);
    procedure cbCompleteListMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure tbPriorityChange(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure CreateBackUp1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure N30Days1Click(Sender: TObject);
    procedure N60Days1Click(Sender: TObject);
    procedure N1Year1Click(Sender: TObject);
    procedure Help2Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure OpenClick(Sender: TObject);
    procedure SaveAsClick(Sender: TObject);
    procedure New1Click(Sender: TObject);
    procedure CloseClick(Sender: TObject);
    procedure RemoveSavedListonStartup1Click(Sender: TObject);
    procedure Search1Click(Sender: TObject);
    procedure N30Days2Click(Sender: TObject);
    procedure N30Days3Click(Sender: TObject);
    procedure AllCompleted1Click(Sender: TObject);
    procedure UpdateArchive(OlderThanNum: Integer);
    procedure Archive1Click(Sender: TObject);
  public
  private

  end;

function IsConflictingTitle(ProposedTitle: String; ExistingItem: TItem): Boolean; overload;
function ContainsInvalidChar(str: String): Boolean;
function GetItem(ItemStr: String): TItem;
function GetItemFromExactTitle(ItemTitle: String): TItem;
function ArchiveExists: Boolean;
function  GetLargestExistingArchiveNum: Integer;
procedure CreateArchive;
function ConvertDescriptionToMultipleLines(OneLineStr: string): TStringList;


var
  ToDo: TToDo;
  ListOfItems: TItemList;
  FilePath: string;
  FileName: string;
  ArchivePath: string;
  IsEmptyFile: Boolean;

implementation

{$R *.dfm}

uses
  EditFormUnit, HelpFormUnit, AboutFormUnit, SaveConfirmationUnit, SearchFormUnit, System.Generics.Defaults;


function ArchiveExists: Boolean;
begin
  Result := FileExists(ExtractFilePath(Application.ExeName) + 'config\Archive.txt');
end;


  (*
  Compare proposed title of new item to title's of created items. This is important as items are
  distinguished based on title string. Therefore, it would be app-breaking to have two items with the
  same title.
*)
function IsConflictingTitle(ProposedTitle: string): Boolean; overload;
begin
  for var Item in ListOfItems do
    if (Item.Title = ProposedTitle) then
    begin
      Result := True;
      Exit;
    end;
  Result := False;
end;

(* Overload function for EditForm to avoid self triggering the error message on conflicting title *)
function IsConflictingTitle(ProposedTitle: string; ExistingItem: TItem): Boolean; overload;
begin
  for var Item in ListOfItems do
    if (Item.Title = ProposedTitle) and (Item <> ExistingItem) then
    begin
      Result := True;
      Exit;
    end;
  Result := False;
end;

(* Checking whether a string has characters reserved for delimiting items/description when writing to a file *)
function ContainsInvalidChar(str: String): Boolean;
begin
  for var char in str do
    if (char = '~') or (char = '|') then
    begin
      Result := True;
      Exit;
    end;
  Result := False;
end;

procedure TToDo.ClearAllFormElements;
begin
  ListOfItems.Clear;
  cbIncompleteList.Clear;
  cbCompleteList.Clear;
  ClearInputs;
end;

(*
  Providing there is a title and it does not conflict, create and item and add it to ListOfItems.
  We can use the default constructor, since a new item by default is not completed and has a created
  date of now.
*)
procedure TToDo.bCreateClick(Sender: TObject);
begin
  if eTitle.Text = '' then
    ShowMessage('Item Must Have Title!')
  else if ContainsInvalidChar(eTitle.Text) then
    ShowMessage('This Title Contains Invalid Characters!')
  else if IsConflictingTitle(eTitle.Text) then
    ShowMessage('This Title Is Already Associated With An Item!')
  else
    begin
      var CreatedItem := TItem.Create(eTitle.Text, mDesc.Lines, tbPriority.Position, dtDueDate.Date);
      ListOfItems.Add(CreatedItem);
      SortAndAddToIncompleteList;
      ClearInputs();
      if IsEmptyFile then
        IsEmptyFile := False;
    end;
end;

 (* Retrieve an item from ListOfItems based on its primary key: Title *)
function GetItem(ItemStr: string): TItem;
begin
  var ItemTitle := SplitString(ItemStr, '~')[0];
  ItemTitle := ItemTitle.Substring(0, ItemTitle.Length - 1);
  Result := ListOfItems[0];
  for var Item in ListOfItems do
  begin
    if Item.Title = ItemTitle then
    begin
      Result := Item;
      Exit;
    end;
  end;
end;

function GetItemFromExactTitle(ItemTitle: String): TItem;
begin
  Result := ListOfItems[0];
  for var Item: TItem in ListOfItems do
  begin
    if Item.Title = ItemTitle then
    begin
      Result := Item;
      Exit;
    end;
  end;
end;

procedure TToDo.GetSavedListDetails;
begin
  if FileExists(ExtractFilePath(Application.ExeName) + 'config\defaultList.txt') then
  begin
    var SR := TStreamReader.Create(ExtractFilePath(Application.ExeName) + 'config\defaultList.txt', True);
    try
      if SR.InstanceSize > 0 then
      begin
        var Line := SR.ReadLine;
        FilePath := ExtractFileDir(Line) + '\';
        FileName :=  Line.Substring(Length(FilePath));
      end
      else
      begin
        FilePath := ExtractFilePath(Application.ExeName);
        FileName := '';
      end;
    finally
      SR.Free;
    end;
  end
  else
    begin
      FilePath := ExtractFilePath(Application.ExeName);
      FileName := '';
    end;
end;

procedure TToDo.Help2Click(Sender: TObject);
begin
  THelpForm.Execute;
end;

procedure TToDo.SortAndAddToIncompleteList;
begin
  var
  ListOfIncompleteItems := TList<TItem>.Create;
  try
    for var Item in ListOfItems do
    begin
      if not Item.isCompleted then
        ListOfIncompleteItems.Add(Item);
    end;

    var Comparison: TComparison<TItem> := function(const Left, Right: TItem): Integer
    begin
      Result := Right.CalculateUrgencyValue - Left.CalculateUrgencyValue;
      if Right.CalculateUrgencyValue = Left.CalculateUrgencyValue then
      begin
        Result := Round(Left.DueDate - Right.DueDate);
        if Left.DueDate = Right.DueDate then
        begin
          Result := CompareStr(Left.Title, Right.Title);
        end;
      end;
    end;

    ListOfIncompleteItems.Sort(TComparer<TItem>.Construct(Comparison));
    cbIncompleteList.Clear;

    for var Item in ListOfIncompleteItems do
    begin
      cbIncompleteList.Items.Add(Item.GetDisplayText);
    end;

  finally
     ListOfIncompleteItems.Free;
  end;
end;

procedure TToDo.SortAndAddToCompleteList;
begin
  var ListOfCompleteItems := TList<TItem>.Create;
  try
    for var Item in ListOfItems do
    begin
      if Item.isCompleted then
        ListOfCompleteItems.Add(Item);
    end;

    var Comparison: TComparison<TItem> := function(const Left, Right: TItem): Integer
    begin
      Result := Round(Right.CompletedDate) - Round(Left.CompletedDate);
      if Right.CompletedDate = Left.CompletedDate then
      begin
        Result := Round(Right.DueDate) - Round(Left.DueDate);
        if Round(Right.DueDate) = Round(Left.DueDate) then
          Result := compareStr(Left.Title, Right.Title);
      end;

    end;

    ListOfCompleteItems.Sort(TComparer<TItem>.Construct(Comparison));
    cbCompleteList.Clear;

    for var Item in ListOfCompleteItems do
      cbCompleteList.Items.Add(Item.GetDisplayText);

  finally
     ListOfCompleteItems.Free;
  end;
end;


procedure TToDo.tbPriorityChange(Sender: TObject);
begin
  lPriNum.Caption := IntToStr(tbPriority.Position);
end;

procedure TToDo.ClearInputs();
begin
  eTitle.Text := '';
  mDesc.Text := '';
  tbPriority.Position := 1;
  dtDueDate.Date := Now;
end;

procedure TToDo.CloseClick(Sender: TObject);
begin
  if not IsEmptyFile then
    QueryUserSave;

 ClearAllFormElements;
 FileName := '';
 FilePath := '';
 IsEmptyFile := True;
end;

procedure TToDo.About1Click(Sender: TObject);
begin
  TAboutForm.Execute;
end;

procedure TToDo.AllCompleted1Click(Sender: TObject);
begin
  UpdateArchive(0);
end;

procedure TToDo.Archive1Click(Sender: TObject);
begin
  var ArchiveNum := GetLargestExistingArchiveNum;
  var SW := TStreamWriter.Create(ArchivePath, True, TEncoding.UTF8);
   try
     var Item := GetItem(cbCompleteList.Items[cbCompleteList.ItemIndex]);
     ArchiveNum := ArchiveNum + 1;
     var LineWithArchiveNum := IntToStr(ArchiveNum) +'|' + Item.CreateCSVLine + '|' + FilePath + FileName;
     SW.WriteLine(LineWithArchiveNum);
     ListOfItems.Remove(Item);
     SortAndAddToCompleteList;
   finally
      SW.Free;
   end;
end;

procedure TToDo.bClearAllClick(Sender: TObject);
begin
  ClearInputs();
end;


procedure TToDo.CompleteAllItemsClick(Sender: TObject);
begin
  for var Title in cbIncompleteList.items do
  begin
    var Item := GetItem(Title);
    Item.isCompleted := True;
  end;
  SortAndAddToCompleteList;
  cbIncompleteList.Items.Clear;
end;

procedure TToDo.IncompleteAllItemsClick(Sender: TObject);
begin
  for var Title in cbCompleteList.items do
  begin
    var Item := GetItem(Title);
    Item.isCompleted := False
  end;
  SortAndAddToIncompleteList;
  cbCompleteList.Clear;
end;


procedure TToDo.DeleteAllIncompleteClick(Sender: TObject);
begin
  for var Item in ListOfItems do
  begin
    if not Item.isCompleted then
      ListOfItems.Remove(Item);
  end;
  cbIncompleteList.Items.Clear;
end;

procedure TToDo.DeleteAllCompleteClick(Sender: TObject);
begin
  for var Item in ListOfItems do
  begin
    if Item.isCompleted then
      ListOfItems.Remove(Item);
  end;
  cbCompleteList.Items.Clear;
end;

procedure TToDo.DeleteAllItemsClick(Sender: TObject);
begin
  DeleteAllIncompleteClick(Sender);
  DeleteAllCompleteClick(Sender);
end;


procedure TToDo.Exit1Click(Sender: TObject);
begin
    Application.Terminate;
end;

procedure TToDo.RemoveOldItems(Num: Integer);
begin
  for var Item in ListOfItems do
  begin
    if (Item.IsCompleted) and (Now - Item.CompletedDate > Num) then
    begin
      for var I := 0 to cbCompleteList.Items.Count - 1 do
        ListOfItems.Remove(Item);
    end;
  end;
  SortAndAddToCompleteList;
end;


procedure TToDo.RemoveSavedListonStartup1Click(Sender: TObject);
begin
 SaveListDetails('','');
end;


procedure TToDo.CompleteDeleteMenuItemClick(Sender: TObject);
begin
  var
  ItemToDelete := GetItem(cbCompleteList.Items[cbCompleteList.ItemIndex]);

  for var Item in ListOfItems do
  begin
    if Item.Title = ItemToDelete.Title then
      ListOfItems.Remove(Item);
  end;

  cbCompleteList.Items.Delete(cbCompleteList.ItemIndex);
end;

procedure TToDo.CreateBackUp1Click(Sender: TObject);
begin
  var DateStamp := FormatDateTime('yyyymmdd_hhnnss-zz', Now);
  var BackupName := FileName + '_BACKUP_' + DateStamp + '.txt';
  SaveNewFile(BackupName, True);
end;


procedure TToDo.IncompleteDeleteMenuItemClick(Sender: TObject);
begin
  var ItemToDelete := GetItem(cbIncompleteList.Items[cbIncompleteList.ItemIndex]);
  for var Item in ListOfItems do
  begin
    if Item.Title = ItemToDelete.Title then
      ListOfItems.Remove(Item);
  end;

  cbIncompleteList.Items.Delete(cbIncompleteList.ItemIndex);
end;


procedure TToDo.N1Year1Click(Sender: TObject);
begin
  RemoveOldItems(365);
end;

procedure TToDo.N30Days1Click(Sender: TObject);
begin
  RemoveOldItems(30);
end;

procedure TToDo.N60Days1Click(Sender: TObject);
begin
   RemoveOldItems(60);
end;

procedure TToDo.N30Days2Click(Sender: TObject);
begin
  UpdateArchive(30);
end;

procedure TToDo.N30Days3Click(Sender: TObject);
begin
    UpdateArchive(60);
end;


procedure TToDo.New1Click(Sender: TObject);
begin
  if not IsEmptyFile then
    QueryUserSave;

  ClearAllFormElements;
  IsEmptyFile := True;
  //this will make the item fail the save condition and trigger a 'save as'
  FileName := 'NEW_LIST';
end;

procedure TToDo.OpenClick(Sender: TObject);
begin
  if not IsEmptyFile then
    QueryUserSave;

  var OpenDialog := TOpenDialog.Create(Self);
  OpenDialog.InitialDir := FilePath;
  OpenDialog.Filter := 'Text files only|*.txt';
  OpenDialog.DefaultExt := 'txt';
  if OpenDialog.Execute then
  begin
    FilePath := ExtractFilePath(OpenDialog.FileName);
    FileName := ExtractFileName(OpenDialog.FileName);
    ClearAllFormElements;
    BuildFromFile;
  end;
  OpenDialog.Free;
end;


procedure TToDo.cbIncompleteListClickCheck(Sender: TObject);
begin
  var CheckedItem := GetItem(cbIncompleteList.Items[cbIncompleteList.ItemIndex]);
  CheckedItem.isCompleted := True;
  CheckedItem.CompletedDate := Today.GetDate;
  SortAndAddToCompleteList;
  cbIncompleteList.Items.Delete(cbIncompleteList.ItemIndex);
end;


procedure TToDo.cbCompleteListClickCheck(Sender: TObject);
begin
  var CheckedItem := GetItem(cbCompleteList.Items[cbCompleteList.ItemIndex]);
  CheckedItem.isCompleted := False;
  CheckedItem.CompletedDate := NullDate;
  SortAndAddToIncompleteList;
  cbCompleteList.Items.Delete(cbCompleteList.ItemIndex);
end;


procedure TToDo.cbIncompleteListMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  with cbIncompleteList do
    // ItemIndex := TopIndex + Y div ItemHeight;
    if Shift = [ssRight] then
      ItemIndex := ItemAtPos(Point(X, Y), True);
end;


procedure TToDo.cbCompleteListMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  with cbCompleteList do
    // ItemIndex := TopIndex + Y div ItemHeight;
    if Shift = [ssRight] then
      ItemIndex := ItemAtPos(Point(X, Y), True);
end;


procedure TToDo.cbIncompleteListDblClick(Sender: TObject);
begin
  if cbIncompleteList.ItemIndex = -1 then
  begin
    ShowMessage('You Need To Select An Item First');
    Exit;
  end;

  var ClickedItem := GetItem(cbIncompleteList.Items[cbIncompleteList.ItemIndex]);
  var UpdatedItem := TEditForm.Execute(ClickedItem);
  if not UpdatedItem.Equals(ClickedItem) then
  begin
    ListOfItems.Add(UpdatedItem);
    ListOfItems.Remove(ClickedItem);
  end;
  SortAndAddToIncompleteList;
end;

procedure TToDo.cbCompleteListDblClick(Sender: TObject);
begin
    if cbCompleteList.ItemIndex = -1 then
  begin
    ShowMessage('You Need To Select An Item First');
    Exit;
  end;

  var ClickedItem := GetItem(cbCompleteList.Items[cbCompleteList.ItemIndex]);
  var UpdatedItem := TEditForm.Execute(ClickedItem);
  if not UpdatedItem.Equals(ClickedItem) then
  begin
    ListOfItems.Add(UpdatedItem);
    ListOfItems.Remove(ClickedItem);
  end;
  SortAndAddToCompleteList;
end;

procedure TToDo.cbIncompleteListDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  var ListBox: TCheckListBox := Control as TCheckListBox;
  var Canvas: TCanvas := ListBox.Canvas;

  Canvas.FillRect(Rect);

  var CurrentItem := GetItem(cbIncompleteList.Items[Index]);
  var UrgVal := CurrentItem.CalculateUrgencyValue;

  if UrgVal > 2500 then
  begin
    Canvas.Font.Color := clRed;
    Canvas.Font.Style := [fsBold];
  end
  else if UrgVal > 900 then
    Canvas.Font.Color := clWebDarkOrange
  else if UrgVal >= 550 then
    Canvas.Font.Color := clWhite
  else
    Canvas.Font.Color := clWebLawnGreen;

  Canvas.TextOut(Rect.Left, Rect.Top, ListBox.Items[Index]);
  if odFocused in State then
    Canvas.DrawFocusRect(Rect);

end;


procedure TToDo.cbCompleteListDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  var ListBox := Control as TCheckListBox;
  var Canvas := ListBox.Canvas;

  Canvas.FillRect(Rect);

  Canvas.Font.Color := clWhite;
  Canvas.TextOut(Rect.Left, Rect.Top, ListBox.Items[Index]);

  if odFocused in State then
    Canvas.DrawFocusRect(Rect);
end;


function ConvertDescriptionToMultipleLines(OneLineStr: string): TStringList;
begin
  var StrArrOnLines := SplitString(OneLineStr, '~');
  var ListOfLines := TStringList.Create;
  ListOfLines.AddStrings(StrArrOnLines);
  Result := ListOfLines;
end;


(* Read in any stored information from the file *)
procedure TToDo.BuildFromFile;
begin
  var SR := TStreamReader.Create(FilePath + FileName, True);
  try
    if SR.EndOfStream then
      Exit
    else
      while not SR.EndOfStream do
      begin
          var Fields := SplitString(SR.ReadLine, '|');
          var Description := ConvertDescriptionToMultipleLines(Fields[1]);
           try
            var CompletedDate := Now;
            if Fields[6] = '00/00/0000' then
              CompletedDate := NullDate
            else
              CompletedDate := StrToDate(Fields[6]);

            // Lines are: Title,Desc,Priority,DueDate,CreatedDate,IsCompleted, CompletionDate
            var CreatedItem := TItem.Create(Fields[0], Description, StrToInt(Fields[2]), StrToDate(Fields[3]), StrToDate(Fields[4]), StrToBool(Fields[5]), CompletedDate);
            ListOfItems.Add(CreatedItem);
           finally
             Description.Free;
           end;
      end;
      IsEmptyFile := False;
      SortAndAddToIncompleteList;
      SortAndAddToCompleteList;
  finally
    SR.Free;
  end;
end;

(* Write the contents of ListOfItems to the file *)
procedure TToDo.WriteToFile(FileName: String; FilePath: String);
begin
  var SW := TStreamWriter.Create(FilePath + FileName, False, TEncoding.UTF8);
  try
    for var Item in ListOfItems do
    begin
      SW.WriteLine(Item.CreateCSVLine);
    end;
  finally
    SW.Free;
  end;
end;

procedure CreateArchive;
begin
  var SW := TStreamWriter.Create(ArchivePath, False, TEncoding.UTF8);
  SW.Free;
end;

function  GetLargestExistingArchiveNum: Integer;
begin
  Result := 0;
  var SR := TStreamReader.Create(ArchivePath, True);
  try
    if Length(SR.ReadLine) = 0 then
      Exit
    else
      while not SR.EndOfStream do
      begin
        var Fields := SplitString(SR.ReadLine, '|');
        if StrToInt(Fields[0]) > Result then
          Result := StrToInt(Fields[0]);
        end;
  finally
    SR.Free;
  end;
end;


procedure TToDo.UpdateArchive(OlderThanNum: Integer);
begin
  var ArchiveNum := GetLargestExistingArchiveNum;
  var SW := TStreamWriter.Create(ArchivePath, True, TEncoding.UTF8);
   try
    if ListOfItems.Count = 0 then
      Exit
    else
    begin
       for var I := pred(ListOfItems.Count) downto 0 do
       begin
         var Item := ListOfItems[I];
         if (Item.IsCompleted) and (DaysBetween(Now, Item.CompletedDate) >= OlderThanNum) then
         begin
           ArchiveNum := ArchiveNum + 1;
           var LineWithArchiveNum := IntToStr(ArchiveNum) +'|' + Item.CreateCSVLine + '|' + FilePath + FileName;
           SW.WriteLine(LineWithArchiveNum);
           ListOfItems.Remove(Item);
         end;
       end;
       SortAndAddToCompleteList;
    end;
   finally
      SW.Free;
   end;
end;


procedure TToDo.FormCreate(Sender: TObject);
begin
  GetSavedListDetails;
  ListOfItems := TItemList.Create;
  IsEmptyFile := True;
  if FileExists(FilePath + FileName) then
  begin
    BuildFromFile;
  end;

  ArchivePath := ExtractFilePath(Application.ExeName) + 'config\Archive.txt';
  if not ArchiveExists then
    CreateArchive;
  UpdateArchive(90);
  SortAndAddToIncompleteList;
  SortAndAddToCompleteList;
  dtDueDate.Date := Now;
end;


procedure TToDo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveListDetails(FilePath, FileName);
end;

procedure TToDo.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if QueryUserSave then
    CanClose := True
  else
    CanClose := False;
end;

procedure TToDo.FormDestroy(Sender: TObject);
begin
 ListOfItems.Free;
 inherited;
end;

procedure TToDo.SaveClick(Sender: TObject);
begin
  SaveFile;
end;

procedure TToDo.SaveAsClick(Sender: TObject);
begin
  SaveNewFile(FileName, False);
end;

function TToDo.SaveNewFile(ProposedFileName: string; IsBackup: Boolean): Boolean;
begin
  var SaveDialog := TSaveDialog.Create(Self);
  try
    SaveDialog.InitialDir := FilePath;
    SaveDialog.FileName := ProposedFileName;
    if FileExists(FilePath + ProposedFileName) then
      SaveDialog.FileName := ProposedFileName + '-Copy';

    SaveDialog.Filter := 'Text files only|*.txt';
    SaveDialog.DefaultExt := 'txt';
    if SaveDialog.Execute then
    begin
      if not IsBackup then
      begin
        FileName := ExtractFileName(SaveDialog.FileName);
        FilePath := ExtractFilePath(SaveDialog.FileName);
        WriteToFile(FileName, FilePath);
      end
      else
        WriteToFile(ExtractFileName(SaveDialog.FileName), ExtractFilePath(SaveDialog.FileName));

      Result := True;
    end
    else
      Result := False;
  finally
    SaveDialog.Free;
  end;
end;

procedure TToDo.Search1Click(Sender: TObject);
begin
  TSearchForm.Execute;
end;

function TToDo.SaveFile: Boolean;
begin
  if FileExists(FilePath + FileName) then
  begin
    WriteToFile(FileName, FilePath);
    Result := True;
  end
  else
  begin
    Result := SaveNewFile(FileName, False);
  end;
end;

procedure TToDo.SaveListDetails(FilePath, FileName: String);
begin
  if not IsEmptyFile then
  begin
    var SW := TStreamWriter.Create(ExtractFilePath(Application.ExeName) + 'config\defaultList.txt', False, TEncoding.UTF8);
    SW.WriteLine(FilePath + FileName);
    SW.Free;
  end;
end;


(* If user selects 'don't save', then we still want the form to return true so that
'form close' can be activated. The question has still been answered, even if it's no.
This is only returning false if the user bails out of the save process. *)
function TToDo.QueryUserSave: Boolean;
begin
  if (not IsEmptyFile)  and (TSaveConfirmation.Execute) then
  begin
    Result := SaveFile;
  end
  else
    Result := True;
end;


end.
