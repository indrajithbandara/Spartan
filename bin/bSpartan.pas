unit bSpartan;

interface

uses vEnv, vConst, bFile, system.SysUtils, system.StrUtils, firedac.comp.client, dDB, bFormatter, bHelper;

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
  tfile.writeInFile(dir + '\' + TCONST.CONF_FILE, '[database]' + slinebreak + tenv.DB.All + slinebreak + 'password=');
  tfile.Create(dir + TCONST.CONTROLLER);
  tfile.Create(dir + TCONST.Model);
  tfile.Create(dir + TCONST.DAO);
  tfile.Create(dir + TCONST.View);
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
  qry, qry_aux: tfdquery;
  aName: string;
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
          0: { version already been promt }
            ;
          1: { -c }
            begin

              Writeln(format('Configuration file located in "%s"', [TCONST.getConfFile]));
              Writeln('--------------------------------------------------------');
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
                begin
                  qry := tdb.execute('select table_name from information_schema.tables where table_schema = ?', [tenv.DB.database]);
                  if qry <> nil then
                  begin
                    qry.first;
                    Writeln('Avaliable tables to became Model weapons: ');
                    while not qry.eof do
                    begin
                      aName := tformatter.modelFromTable(qry.fields[0].asString);
                      if thelper.existsInArray(tenv.system.currentPath + TCONST.Model + copy(aName, 2, length(aName)) + '.pas', tenv.system.Models) then
                        Writeln('       - ', aName, StringOfChar(' ', 40 - length(aName)), '( Created )')

                      else
                        Writeln('       - ', aName, StringOfChar(' ', 40 - length(aName)), '( Not created )');

                      qry.next;
                    end;
                  end;
                end;
              1: { controller }
                begin
                  qry := tdb.execute('select table_name from information_schema.tables where table_schema = ?', [tenv.DB.database]);
                  if qry <> nil then
                  begin
                    qry.first;
                    Writeln('Avaliable tables to became Controller weapons: ');
                    while not qry.eof do
                    begin
                      aName := tformatter.controllerFromTable(qry.fields[0].asString);
                      if thelper.existsInArray(tenv.system.currentPath + TCONST.CONTROLLER + copy(aName, 2, length(aName)) + '.pas', tenv.system.Controllers) then
                        Writeln('       - ', aName, StringOfChar(' ', 40 - length(aName)), '( Created )')

                      else
                        Writeln('       - ', aName, StringOfChar(' ', 40 - length(aName)), '( Not created )');

                      qry.next;
                    end;
                  end;
                end;
              2: { DAO }
                begin
                  qry := tdb.execute('select table_name from information_schema.tables where table_schema = ?', [tenv.DB.database]);
                  if qry <> nil then
                  begin
                    qry.first;
                    Writeln('Avaliable tables to became DAO weapons: ');
                    while not qry.eof do
                    begin
                      aName := tformatter.daoFromTable(qry.fields[0].asString);
                      if thelper.existsInArray(tenv.system.currentPath + TCONST.DAO + copy(aName, 2, length(aName)) + '.pas', tenv.system.DAos) then
                        Writeln('       - ', aName, StringOfChar(' ', 40 - length(aName)), '( Created )')

                      else
                        Writeln('       - ', aName, StringOfChar(' ', 40 - length(aName)), '( Not created )');

                      qry.next;
                    end;
                  end;
                end
            else
              spartError(format('Weapon "%s" is not part of our arsenal.', [ParamStr(2)]));
            end;
        else
          spartError(format('Soldier "%s" is not part of our army.', [ParamStr(1)]));
        end;

      end;
    3:
      begin
        case ansiindexstr(ParamStr(2), TCONST.push_options) of
          0: { model }
            ;
          1: { controler }
            ;
        else
          spartError(format('Weapon "%s" is not part of our arsenal.', [ParamStr(2)]));
        end
      end;
  end;
end;

end.
