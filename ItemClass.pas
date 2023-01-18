unit ItemClass;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, DateUtils, System.StrUtils,
  System.Generics.Collections;

type
  TItem = class
  public
    Title: string;
    Desc: TStrings;
    Priority: Integer;
    IsCompleted: boolean;
    CreatedDate, DueDate: TDate;
    CompletedDate: TDate;
    ArchiveNumber: Integer;
    ItemOrigin: String;
    constructor Create(InputTitle: string; InputDesc: TStrings; InputPri: Integer; InputDate: TDate);overload;
    constructor Create(InputTitle: string; InputDesc: TStrings; InputPri: Integer; InputDate: TDate; ExistingDateOfCreation: TDate; CompletionStatus: Boolean; DateOfCompletion: Variant);overload;
    constructor Create(ArchiveNum: Integer; InputTitle: string; InputDesc: TStrings; InputPri: Integer; InputDate: TDate; ExistingDateOfCreation: TDate; CompletionStatus: Boolean; DateOfCompletion: Variant; ItemLocation: String);overload;
    destructor Destroy; override;
    function GetDisplayText: string;
    function GetDisplayTextWithArchive: string;
    function CalculateUrgencyValue: Integer; overload;
    function CalculateUrgencyValue(DueDate: TDate; Priority: Integer): Integer; overload;
    function CreateCSVLine: string;
  end;

  const NullDate = -693594;

implementation

constructor TItem.Create(InputTitle: string; InputDesc: TStrings; InputPri: Integer; InputDate: TDate);
begin
  Title := InputTitle;
  Desc := TStringList.Create;
  Desc.AddStrings(InputDesc);
  DueDate := InputDate;
  CreatedDate := Today.GetDate;
  CompletedDate := NullDate;
  IsCompleted := False;
  Priority := InputPri;
end;

constructor TItem.Create(InputTitle: string; InputDesc: TStrings; InputPri: Integer; InputDate: TDate; ExistingDateOfCreation: TDate; CompletionStatus: Boolean; DateOFCompletion: Variant);
begin
  Title := InputTitle;
  Desc := TStringList.Create;
  Desc.AddStrings(InputDesc);
  DueDate := InputDate;
  CreatedDate := ExistingDateOfCreation;
  CompletedDate := DateOfCompletion;
  IsCompleted := CompletionStatus;
  Priority := InputPri;
end;

constructor TItem.Create(ArchiveNum: Integer; InputTitle: string; InputDesc: TStrings; InputPri: Integer; InputDate: TDate; ExistingDateOfCreation: TDate; CompletionStatus: Boolean; DateOfCompletion: Variant; ItemLocation: String);
begin
  ArchiveNumber := ArchiveNum;
  Title := InputTitle;
  Desc := TStringList.Create;
  Desc.AddStrings(InputDesc);
  DueDate := InputDate;
  CreatedDate := ExistingDateOfCreation;
  CompletedDate := DateOfCompletion;
  IsCompleted := CompletionStatus;
  Priority := InputPri;
  ItemOrigin := ItemLocation;
end;

function TItem.GetDisplayText: string;
begin
  Result := Title + ' ~ ' + DateToStr(DueDate)
end;

function TItem.GetDisplayTextWithArchive: string;
begin
  Result := Title + ' [' + IntToStr(ArchiveNumber) + ']';
end;

function TItem.CalculateUrgencyValue(): Integer;
var
  DaysUntilDue: Integer;
  RemainingDayBias: Integer;
begin

  if IsCompleted then
  begin
    Result := 0;
    Exit;
  end;

  if DueDate < Today.GetDate then
  begin
    if IsCompleted then
      Result := 0
    else
      Result := 3000;
  end
  else
  begin
    DaysUntilDue := DaysBetween(Now, DueDate) + 1;
    RemainingDayBias := 500 - DaysUntilDue;
    if DaysUntilDue > 5 then
      Result := Round(RemainingDayBias + (RemainingDayBias / Priority))
    else if DaysUntilDue > 1 then
      Result := Round(RemainingDayBias + ((RemainingDayBias / Priority) * (6 - DaysUntilDue)))
    else
      Result := 3000;
  end;

end;

function TItem.CalculateUrgencyValue(DueDate: TDate; Priority: Integer): Integer;
var
  DaysUntilDue: Integer;
  RemainingDayBias: Integer;
begin

  if IsCompleted then
  begin
    Result := 0;
    Exit;
  end;

  if DueDate < Today.GetDate then
  begin
    if IsCompleted then
      Result := 0
    else
      Result := 3500;
  end
  else
  begin
    DaysUntilDue := DaysBetween(Now, DueDate) + 1;
    RemainingDayBias := 500 - DaysUntilDue;
    if DaysUntilDue > 5 then
      Result := Round(RemainingDayBias + (RemainingDayBias / Priority))
    else if DaysUntilDue > 1 then
      Result := Round(RemainingDayBias + ((RemainingDayBias / Priority) * (6 - DaysUntilDue)))
    else
      Result := 3000;
  end;
end;

function ConvertDescriptionToOneLine(Lines: TStrings): string;
var
StringList: TStringList;
begin
  StringList := TStringList.Create;
  try
    StrIngList.Delimiter := '~';
    StringList.StrictDelimiter := True;
    StringList.AddStrings(Lines);
    Result := StrIngList.DelimitedText;
  finally
      StringList.Free;
  end;
end;

function TItem.CreateCSVLine: string;
var
  DataArray: array of string;
  StrList: TStringList;
begin

  DataArray := [Title, convertDescriptionToOneLine(Desc), IntToStr(Priority), DateToStr(DueDate), DateToStr(CreatedDate), BoolToStr(IsCompleted), DateToStr(CompletedDate)];
  StrList := TStringList.Create;
  try
    StrList.Delimiter := '|';
    StrList.StrictDelimiter := True;
    StrList.AddStrings(DataArray);
    Result := StrList.DelimitedText;
  finally
      StrList.Free;
  end;
end;

destructor TItem.Destroy;
begin
   Desc.Free;
  inherited;
end;

end.
