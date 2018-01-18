program Spartan;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  System.StrUtils,
  System.inifiles,
  vEnv in 'Var\vEnv.pas';

const
  APP_NAME = 'Spartan';

procedure _version;
begin
  Writeln(APP_NAME, ' - ', TEnv.System.version);
  Writeln('');
end;

var
  options_help: array [0 .. 2] of string = (
    '           Show framework version.',
    '           Read framework configurations stored in conf.ini file.',
    '         Construct models using your configuration set. Args: <model>'
  );
  options: array [0 .. 2] of string = (
    '-v',
    '-c',
    'push'
  );

  push_options: array [0 .. 1] of string = (
    'model',
    'controller'
  );
  i: integer;

begin
  try
    case ParamCount of
      0:
        begin
          Writeln('');
          Writeln(APP_NAME, ' Framework | A Delphi MVC framework to build desktop applications and dinner in HELL.');
          Writeln('==================================================================================================');
          Writeln('Authors: Paulo Barros <paulo.alfredo.barros@gmail.com>, Junior de Paula <juniiordepaula@gmail.com>');
          _version;
          Writeln('==================================================================================================');
          Writeln('');
          Writeln('Usage: dmvc [option] <param|params>');
          Writeln('');
          Writeln('');
          Writeln('Avaliable options:');
          for i := 0 to High(options) do
            Writeln('  ', options[i], options_help[i]);
        end;
      1:
        begin
          _version;
          case ansiindexstr(ParamStr(1), options) of
            0: { -v }
              _version;

            1: { -c }
              begin
                Writeln('');
                Writeln(TEnv.System.config);
              end;
          else
            Writeln(format('Param "%s" not found', [ParamStr(1)]));
          end;
        end;
      2:
        begin
          _version;
          case ansiindexstr(ParamStr(1), options) of
            2: { push }
              case ansiindexstr(ParamStr(2), push_options) of
                0: { model }
                  Writeln('list models');
                1: { controller }
                  Writeln('generate controller');
              else
                Writeln(format('Param "%s" not found', [ParamStr(1)]));
              end;
          else
            Writeln(format('Param "%s" not found', [ParamStr(1)]));
          end;

        end;
    end;

  except
    on e: exception do

    begin
      Writeln('Error starting ', APP_NAME, 'command line:');
      Writeln(e.Message);
    end;
  end;

end.
