program DMVC;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  System.StrUtils,
  vEnv in 'Var\vEnv.pas';

const
  APP_NAME = 'DMVC';

var
  options_help: array [0 .. 0] of string = (
    'Show framework version.'
  );
  options: array [0 .. 0] of string = (
    '-v'
  );
  i: integer;

begin
  try
    case ParamCount of
      0:
        begin
          Writeln(APP_NAME, ' Framework | A Delphi MVC framework to build desktop applications.');
          Writeln('Authors: Paulo Barros <paulo.alfredo.barros@gmail.com>, Junior de Paula <juniiordepaula@gmail.com>');
          Writeln('Version: ' + TEnv.System.version);
          Writeln('');
          Writeln('Usage: dmvc [option] <param|params>');
          Writeln('');
          Writeln('');
          Writeln('Avaliable options:');
          for i := 0 to High(options) do
            Writeln('  ', options[i], '           ', options_help[i]);
        end;
      1:
        begin
          case ansiindexstr(ParamStr(1), options) of
            0:
              Writeln(APP_NAME, ' - ', TEnv.System.version);
            1:
              write('Help');
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
