unit bHelper;

interface

uses types, System.sysutils;

type
  THelper = class
    class function existsInArray(value: variant; arrayValues: array of variant): boolean; overload;
    class function existsInArray(value: string; arrayValues: TStringDynArray): boolean; overload;
  end;

implementation

{ THelper }

class function THelper.existsInArray(value: variant; arrayValues: array of variant): boolean;
var
  _value: variant;
begin
  result := false;

  for _value in arrayValues do
    if _value = value then
    begin
      result := true;
      break;
    end;
end;

class function THelper.existsInArray(value: string; arrayValues: TStringDynArray): boolean;
var
  _value: string;
begin
  result := false;

  for _value in arrayValues do
    if lowercase(_value) = lowercase(value) then
    begin
      result := true;
      break;
    end;
end;

end.
