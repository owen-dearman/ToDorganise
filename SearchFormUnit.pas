unit SearchFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ToDoApp;

type
  TSearchForm = class(TForm)
    eSearchBar: TEdit;
    bSearch: TButton;
    lbResults: TListBox;
    lNowShow: TLabel;
    procedure ConductSearchForTerm(searchTerm: String);
    procedure SortSearchResults;
    procedure bSearchClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lbResultsDblClick(Sender: TObject);
    procedure PopulateArchiveList;
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure Execute;
  end;

var
  SearchForm: TSearchForm;
  NumResults: Integer;
  ArchiveList: TItemList;

implementation

uses
ItemInformationForm, ItemClass, System.StrUtils, System.Generics.Defaults, System.Generics.Collections;

{$R *.dfm}

procedure TSearchForm.PopulateArchiveList;
begin
  var SR := TStreamReader.Create(ArchivePath, True);
  try
     if SR.EndOfStream then
      Exit
    else
      while not SR.EndOfStream do
      begin
        var Fields := SplitString(SR.ReadLine, '|');
        var Description := ConvertDescriptionToMultipleLines(Fields[2]);
        try
          var CompletedDate := Now;
          if Fields[7] = '00/00/0000' then
            CompletedDate := NullDate
          else
            CompletedDate := StrToDate(Fields[7]);

            var CreatedItem := TItem.Create(StrToInt(Fields[0]),Fields[1], Description, StrToInt(Fields[3]), StrToDate(Fields[4]), StrToDate(Fields[5]), StrToBool(Fields[6]), CompletedDate, Fields[8]);
            ArchiveList.Add(CreatedItem);
        finally
          Description.Free;
        end;
      end;
  finally
    SR.Free;
  end;
end;

class procedure TSearchForm.Execute;
begin
  ArchiveList := TItemList.Create;
  with TSearchForm.Create(nil) do
  begin
    try
      PopulateArchiveList;
      ConductSearchForTerm('');
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TSearchForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ArchiveList.Free;
end;

function GetItemFromArchive(Title: string): TItem;
begin
  var ArchNum:= SplitString(Title, '[')[1];
  ArchNum := ArchNum.Substring(0, length(ArchNum)-1);
  Result := ArchiveList[0];
  for var Item in ArchiveList do
  begin
    if Item.ArchiveNumber = StrToInt(ArchNum) then
    begin
      Result := Item;
      Exit;
    end;
  end;
end;

procedure TSearchForm.lbResultsDblClick(Sender: TObject);
begin
   if lbResults.ItemIndex < 0 then
   begin
    ShowMessage('You Need To Select An Item First');
    Exit;
   end;

  var ClickedItem := GetItemFromArchive(lbResults.Items[lbResults.ItemIndex]);
  TItemInfo.Execute(ClickedItem);
end;

procedure TSearchForm.ConductSearchForTerm(SearchTerm: string);
begin
  SearchTerm := UpperCase(SearchTerm);
  lbResults.Items.Clear;
  for var Item in ArchiveList do
  begin
    if searchTerm = '' then
      lbResults.Items.Add(Item.GetDisplayTextWithArchive)
    else
    begin
      if (UpperCase(Item.Title).Contains(searchTerm)) or (UpperCase(Item.Desc.Text).Contains(searchTerm)) then
      begin
        lbResults.Items.Add(Item.GetDisplayTextWithArchive);
      end;
    end;
  end;

  SortSearchResults;
end;


procedure TSearchForm.bSearchClick(Sender: TObject);
begin
  ConductSearchForTerm(eSearchBar.Text);
end;


procedure TSearchForm.SortSearchResults;
begin
  var ResultList := TList<String>.Create;
  try
    for var Title in lbResults.Items do
      ResultList.Add(Title);

    var Comparison: TComparison<string> := function(const Left, Right: String): Integer
    begin
      Result := CompareStr(Left, Right);
    end;

    ResultList.Sort(TComparer<string>.Construct(Comparison));
    lbResults.Items.Clear;

    for var Title in ResultList do
      lbResults.Items.Add(Title);

     NumResults := lbResults.Items.Count;
     lNowShow.Caption := 'Now Showing ' + IntToStr(NumResults) + ' Items.';
  finally
    ResultList.Free;
  end;
end;

end.
