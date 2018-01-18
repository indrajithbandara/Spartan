unit vEnv;

interface

uses
  System.inifiles,
  System.sysutils;

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
      Version = 'v1.0.0';
      class function Path: string;
      class function config: string;
    end;

  end;

implementation

{ TEnv.DB }

class function TEnv.DB.All: string;
begin
  result := 'Database Configuration:' + slinebreak + 'Driver: ' + TEnv.DB.Driver + slinebreak + 'Database: ' + TEnv.DB.Database + slinebreak + 'Server: ' + TEnv.DB.Server +
    slinebreak + 'Port: ' + TEnv.DB.Port + slinebreak + 'User: ' + TEnv.DB.User;
end;

class function TEnv.DB.Database: string;
begin
  result := Tinifile.create(TEnv.System.Path).readString('database', 'database', '');
end;

class function TEnv.DB.Driver: string;
begin
  result := Tinifile.create(TEnv.System.Path).readString('database', 'driver', 'mysql');
end;

class function TEnv.DB.Password: string;
begin
  result := Tinifile.create(TEnv.System.Path).readString('database', 'password', '');
end;

class function TEnv.DB.Port: string;
begin
  result := Tinifile.create(TEnv.System.Path).readString('database', 'port', '3306');
end;

class function TEnv.DB.Server: string;
begin
  result := Tinifile.create(TEnv.System.Path).readString('database', 'port', 'localhost');
end;

class function TEnv.DB.User: string;
begin
  result := Tinifile.create(TEnv.System.Path).readString('database', 'port', 'root');
end;

{ TEnv.System }

class function TEnv.System.config: string;
begin
  result := TEnv.DB.All;
end;

class function TEnv.System.Path: string;
begin
  result := ExtractFilePath(ParamStr(0));
end;

end.
