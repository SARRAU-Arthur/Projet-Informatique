program StatsProgram;

uses
  unitstats,sysutils;

var
  option: char;
  n: integer;
  TabI: subtab;
  tab_med: tableau1D;
  tableauSaisi: boolean;

begin
  tableauSaisi := False;

  repeat
    writeln('Menu de calcul statistique:');
    writeln('1. Saisir un tableau');
    writeln('2. Afficher la moyenne');
    writeln('3. Afficher la mediane');
    writeln('4. Afficher la variance');
    writeln('5. Afficher l''ecart type');
    writeln('Q. Quitter');
    writeln;

    write('Choisissez une option : ');
    readln(option);

    case option of
      '1': begin
             SaisirTableau(TabI, n);
             creationtableau(tab_med, TabI);
             tableauSaisi := True;
           end;
      '2': begin
             if tableauSaisi then
               writeln('La moyenne est : ',FloatToStr(CalculerMoyenne(tab_med)))
             else
               writeln('Veuillez d''abord saisir le tableau.');
           end;
      '3': begin
             if tableauSaisi then
               writeln('La mediane est : ', FloatToStr(CalculerMediane(tab_med)))
             else
               writeln('Veuillez d''abord saisir le tableau.');
           end;
      '4': begin
             if tableauSaisi then
               writeln('La variance est : ', FloatToStr(CalculerVariance(tab_med)))
             else
               writeln('Veuillez d''abord saisir le tableau.');
           end;
      '5': begin
             if tableauSaisi then
               writeln('L''ecart type est : ', FloatToStr(CalculerEcartType(CalculerVariance(tab_med))))
             else
               writeln('Veuillez d''abord saisir le tableau.');
           end;
      'Q', 'q': writeln('Au revoir !');
    else
      writeln('Option invalide. Veuillez choisir une option valide.');
    end;

    writeln; 
  until (option = 'Q') or (option = 'q');
end.
