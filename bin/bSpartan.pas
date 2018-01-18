unit bSpartan;

interface

uses vEnv, vConst, bFile, system.SysUtils, system.StrUtils;

type
  TSpartan = class
  private
    class procedure version(newLine: boolean = true);

  public

    class procedure raiseArmy;
    class procedure raiseWeapons(dir: string);
    class procedure spartError(msg: string);
  end;

implementation

{ TSpartan }

class procedure TSpartan.raiseWeapons(dir: string);
begin
  tfile.Create(dir);
  tfile.Create(dir + '\' + TCONST.CONF_FILE);
  tfile.writeInFile(dir + '\' + TCONST.CONF_FILE, '[database]' + slinebreak + tenv.DB.All);
  tfile.Create(dir + '\Controller\');
  tfile.Create(dir + '\Model\');
  tfile.Create(dir + '\DAO\');
  tfile.Create(dir + '\View\');
end;

class procedure TSpartan.spartError(msg: string);
begin
  raise Exception.Create(msg);
end;

class procedure TSpartan.version(newLine: boolean = true);
begin
  Writeln(TCONST.APP_NAME, ': ', tenv.system.version);
  if newLine then
    Writeln('');
end;

class procedure TSpartan.raiseArmy;
var
  i: integer;
begin
  case ParamCount of
    0:
      begin
        Writeln('');
        Writeln(TCONST.APP_NAME, ' Framework | A Delphi MVC framework to build desktop applications and dinner in HELL.');
        Writeln('==================================================================================================');
        Writeln('Authors: Paulo Barros <paulo.alfredo.barros@gmail.com>, Junior de Paula <juniiordepaula@gmail.com>');
        TSpartan.version(false);
        Writeln('==================================================================================================');
        Writeln('');
        Writeln('Usage: ', lowercase(TCONST.APP_NAME), ' [option] <param|params>');
        Writeln('');
        Writeln('');
        Writeln('Avaliable soldiers:');
        for i := 0 to High(TCONST.SOLDIERS) do
          Writeln('  ', TCONST.SOLDIERS[i], StringOfChar(' ', 20 - length(TCONST.SOLDIERS[i])), TCONST.soldiers_help[i]);
      end;
    1:
      begin
        TSpartan.version;
        case ansiindexstr(ParamStr(1), TCONST.SOLDIERS) of
          1: { -c }
            begin
              Writeln('');
              Writeln(tenv.system.getConfig);
            end;

          2: { stare }
            begin
              spartError('A NAME to your new weapon must be informed.' + slinebreak + 'If you want to create new weapon in current folder, type "spartan stare ."');
            end;

          3: { push }
            begin
              spartError('You must choose one of the weapons bellow:' + slinebreak + '    model' + slinebreak + '    controller');
            end
        else
          spartError(format('Soldier "%s" is not part of our army.', [ParamStr(1)]));
        end;
      end;
    2:
      begin
        TSpartan.version;
        case ansiindexstr(ParamStr(1), TCONST.SOLDIERS) of
          2: { stare }
            begin
              if ParamStr(2) = '.' then
                TSpartan.raiseWeapons(tenv.system.currentPath)
              else
              begin
                if tfile.exists(tenv.system.currentPath + ParamStr(2)) then
                  spartError(format('A project "%s" already exists.', [ParamStr(2)]))
                else
                  TSpartan.raiseWeapons(tenv.system.currentPath + ParamStr(2));
              end;

              Writeln(format('Weapon "%s" created successfully' + slinebreak + 'Modify conf.ini to connect your database.', [ParamStr(2)]));
            end;
          3: { push }
            case ansiindexstr(ParamStr(2), TCONST.push_options) of
              0: { model }
                Writeln('list models');
              1: { controller }
                Writeln('generate controller');
            else
              spartError(format('Weapon "%s" is not part of our arsenal.', [ParamStr(2)]));
            end;
        else
          spartError(format('Soldier "%s" is not part of our army.', [ParamStr(1)]));
        end;

      end;
  end;
end;

end.
