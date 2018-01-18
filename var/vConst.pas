unit vConst;

interface

type
  TConst = class
  public const

    APP_NAME = 'Spartan';

    CONF_FILE = 'conf.ini';

    SOLDIERS: array [0 .. 3] of string = ('-v', '-c', 'stare', 'push');

    SOLDIERS_HELP: array [0 .. 3] of string = ('Show framework version.', 'Read framework configurations stored in conf.ini file.', 'Start a new Spartan application. [ name ]',
      'Construct models using your configuration set. [ model | controller ] ');

    PUSH_OPTIONS: array [0 .. 1] of string = ('model', 'controller');

    class function getConfFile: string;

  end;

implementation

{ TConst }
uses vEnv;

class function TConst.getConfFile: string;
begin
  result := Tenv.System.currentPath + CONF_FILE;
end;

end.
