unit vEnv;

interface

uses
  System.inifiles,
  System.sysutils, vConst;

type

  TEnv = class
  public Type
    DB = class
      class function All: string;
      class function Driver: string;
      class function Database: string;
      class function Server: string;
      class function Port: string;
      class function User: string;
      class function Password: string;
    end;

    System = class
    const
      Version = 'v1.0.1';
      class function exePath: string;
      class function ConfFile: TIniFile;
      class function getConfig: String;
      class function currentPath: string;
    end;

  end;

implementation

{ TEnv.DB }

class function TEnv.DB.All: string;
begin
  result := 'driver=' + TEnv.DB.Driver + slinebreak + 'database=' + TEnv.DB.Database + slinebreak + 'server=' + TEnv.DB.Server + slinebreak + 'port=' + TEnv.DB.Port + slinebreak +
    'user=' + TEnv.DB.User;
end;

class function TEnv.DB.Database: string;
begin
  result := TEnv.System.ConfFile.readString('database', 'database', '');
end;

class function TEnv.DB.Driver: string;
begin
  result := TEnv.System.ConfFile.readString('database', 'driver', 'mysql');
end;

class function TEnv.DB.Password: string;
begin
  result := TEnv.System.ConfFile.readString('database', 'password', '');
end;

class function TEnv.DB.Port: string;
begin
  result := TEnv.System.ConfFile.readString('database', 'port', '3306');
end;

class function TEnv.DB.Server: string;
begin
  result := TEnv.System.ConfFile.readString('database', 'server', 'localhost');
end;

class function TEnv.DB.User: string;
begin
  result := TEnv.System.ConfFile.readString('database', 'user', 'root');
end;

{ TEnv.System }

class function TEnv.System.ConfFile: TIniFile;
begin
  if not fileexists(TConst.getConfFile) then
    raise Exception.Create('Configuration file not found!' + slinebreak + ' Run "spartan stare ." to recriate file.');

  result := TIniFile.Create(TConst.getConfFile);
end;

class function TEnv.System.getConfig: string;
begin
  result := 'Database Configuration:' + slinebreak + TEnv.DB.All;
end;

class function TEnv.System.currentPath: string;
begin
  result := GetCurrentDir + '\';
end;

class function TEnv.System.exePath: string;
begin
  result := ExtractFilePath(ParamStr(0));
end;

end.
