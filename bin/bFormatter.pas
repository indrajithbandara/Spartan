unit bFormatter;

interface

uses system.sysutils;

type
  TFormatter = class
    class function tableFromModel(tableName: string): string;
  end;

implementation

{ TFormatter }

class function TFormatter.tableFromModel(tableName: string): string;
  function f(v: string): string;
  var
    I: integer;
  begin

    result := uppercase(v[1]);
    for I := 2 to length(v) do
    begin
      if v[I] = '_' then
      begin
        result := result + f(copy(v, I + 1, length(v)));
        exit;
      end
      else
        result := result + lowercase(v[I]);
    end;
  end;

begin
  result := '';
  if tableName = '' then
    raise Exception.Create('Table name must be filled.');
  result := 'T' + f(copy(tableName, 1, length(tableName)));
end;

end.
