unit bFormatter;

interface

uses system.sysutils, strutils;

type
  TFormatter = class
  private
    class function f(v: string): string;
  public
    class function modelFromTable(tableName: string): string;
    class function controllerFromTable(tableName: string): string;
    class function daoFromTable(tableName: string): string;
    class function replace(value, value_to_find: string; value_to_replace: string = ''): string;
  end;

implementation

{ TFormatter }

class function TFormatter.replace(value, value_to_find: string; value_to_replace: string = ''): string;
begin
  Result := StringReplace(value, value_to_find, value_to_replace, [rfReplaceAll, rfIgnoreCase]);
end;

class function TFormatter.controllerFromTable(tableName: string): string;
begin
  Result := '';
  if tableName = '' then
    raise Exception.Create('Table name must be filled.');
  Result := 'T' + f(copy(tableName, 1, length(tableName))) + 'Controller';
end;

class function TFormatter.daoFromTable(tableName: string): string;
begin
  Result := '';
  if tableName = '' then
    raise Exception.Create('Table name must be filled.');
  Result := 'T' + f(copy(tableName, 1, length(tableName))) + 'DAO';
end;

class function TFormatter.f(v: string): string;
var
  I: integer;
begin
  Result := uppercase(v[1]);
  for I := 2 to length(v) do
  begin
    if v[I] = '_' then
    begin
      Result := Result + f(copy(v, I + 1, length(v)));
      exit;
    end
    else
      Result := Result + lowercase(v[I]);
  end;
end;

class function TFormatter.modelFromTable(tableName: string): string;
begin
  Result := '';
  if tableName = '' then
    raise Exception.Create('Table name must be filled.');
  Result := 'T' + f(copy(tableName, 1, length(tableName)));
end;

end.
