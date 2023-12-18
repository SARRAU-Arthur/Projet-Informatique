program main;

uses Crt, unitunites, unitcalcul, unitequation, unitstatistiques{, unithistorique};

var menu: String;
    retour_menu: Boolean;
begin
ClrScr();
writeln('Bienvenu.e.s dans la calculatrice scientifique avancee');
writeln();
repeat
  writeln('Quel menu souhaitez-vous utiliser ?');
  writeln();
  writeln('Calcul simple = "C"');
  writeln('Resolution d"equations = E"');
  writeln('Statistiques = "S"'); 
  writeln('Unites et conversions = "U"');
  writeln('Historique = "H"');
  writeln('Quitter la calculatrice = "Q"');
  writeln();
  write('Menu: ');
  readln(menu);
  if (menu<>'C') and (menu<>'E') and (menu<>'S') and (menu<>'U') and (menu<>'Q') then
    begin
    ClrScr();
    writeln('Saisie incorrecte');
    writeln();
    end
  else
    case menu of
      'C': calcul(retour_menu);
      'E': equation(retour_menu);
      'S': statistiques(retour_menu);
      'U': unites(retour_menu);
      {'N': calcul(retour_menu);}
      end;
  until menu='Q';
ClrScr();
exit;
end.
