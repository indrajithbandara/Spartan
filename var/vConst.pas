unit vConst;

interface

type
  TConst = class
  public const

    APP_NAME = 'Spartan';

    CONF_FILE = 'conf.ini';

    CONTROLLER = 'Controller\';
    MODEL = 'Model\';
    DAO = 'DAO\';
    VIEW = 'View\';

    SOLDIERS: array [0 .. 3] of string = ('-v', '-c', 'stare', 'push');

    SOLDIERS_HELP: array [0 .. 3] of string = ('Show framework version.', 'Read framework configurations stored in conf.ini file.', 'Start a new Spartan application. [ name ]',
      'Construct models using your configuration set. [ model | controller | dao ] ');

    PUSH_OPTIONS: array [0 .. 2] of string = ('model', 'controller', 'dao');

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
