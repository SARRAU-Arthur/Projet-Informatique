unit unitstats;

interface

const
  MAX = 20;

type
  t = array [0..MAX] of Real;
  tableau1D = array of Real;
  subtab = array of array of Real;
procedure statistiques(var retour_menu: Boolean);
procedure SaisirTableau(var TabI: subtab; var n: integer);
procedure creationtableau(var tab_med: tableau1D; const TabI: subtab; n: integer);
function CalculerMoyenne(tab_med: tableau1D): Real;
function CalculerMediane(tab_med: tableau1D): Real;
function CalculerVariance(tab_med: tableau1D): Real;
function CalculerEcartType(CalculerVariance: Real): Real;

implementation

uses
  SysUtils, Math;
procedure statistiques(var retour_menu: Boolean);
var option: char;
    n: integer;
    TabI: subtab;
    tab_med: tableau1D;
    tableauSaisi: boolean;
begin
tableauSaisi:= False;
retour_menu:=False;
writeln('Bienvenu.e.s dans la section statistiques');  
repeat
  
  writeln();
  writeln('Saisir un tableau depuis le terminal = "1"');
  writeln('Moyenne = "2"');
  writeln('Mediane = "3"');
  writeln('Variance = "4"');
  writeln('Ecart-type = "5"');
  writeln('Enregistrement dans l"historique = "6"');
  writeln('Quitter le menu statistiques = "q"');
  writeln;
  write('Choix: ');
  readln(option);
  case option of
    
     '1': begin
             SaisirTableau(TabI, n);
             creationtableau(tab_med, TabI, n);
             tableauSaisi := True;
           end;
      '2': begin
             if tableauSaisi then
               writeln('La moyenne est : ', CalculerMoyenne(tab_med))
             else
               writeln('Veuillez d''abord saisir le tableau.');
           end;
      '3': begin
             if tableauSaisi then
               writeln('La mediane est : ', CalculerMediane(tab_med))
             else
               writeln('Veuillez d''abord saisir le tableau.');
           end;
      '4': begin
             if tableauSaisi then
               writeln('La variance est : ', CalculerVariance(tab_med))
             else
               writeln('Veuillez d''abord saisir le tableau.');
           end;
      '5': begin
             if tableauSaisi then
               writeln('L''ecart type est : ', CalculerEcartType(CalculerVariance(tab_med)))
             else
               writeln('Veuillez d''abord saisir le tableau.');
           end;
      'Q', 'q': writeln('Au revoir !');
    else
      writeln('Option invalide. Veuillez choisir une option valide.');
    end;

    writeln; 
  until (option = 'Q') or (option = 'q');
end;


procedure SaisirTableau(var TabI: subtab; var n: integer);
var
  i, effectif: integer;
  valeur: Real;
begin
  writeln('Saisissez le nombre de valeurs de la série statistique: ');
  readln(n);
  SetLength(TabI, n, 2);
  for i := 0 to n - 1 do
  begin
    writeln('Saisissez la valeur de la case ');
    readln(valeur);
    TabI[i][0] := valeur;
    writeln('Saisir l''effectif de cette valeur');
    readln(effectif);
    TabI[i][1] := effectif;
  end;
end;

procedure creationtableau(var tab_med: tableau1D; const TabI: subtab; n: integer);
var
  i, k, j, m, eff_tot, pos_max, eff_tot_int: Integer;
  trouve_max: Boolean;
  tab_val: tableau1D;
  max: Real;
begin
  n := Length(TabI);
  eff_tot := 0;
  eff_tot_int := 0;
  SetLength(tab_val, n);
  for i := 0 to n - 1 do
  begin
    eff_tot += Round(TabI[i][1]);
    tab_val[i] := TabI[i][0];
  end;
  SetLength(tab_med, eff_tot);
  for k := 0 to n - 1 do
  begin
    max := MaxValue(tab_val);
    j := 0;
    trouve_max := False;
    while not (trouve_max) do
    begin
      if tab_val[j] = max then
      begin
        pos_max := j;
        trouve_max := True;
      end;
      j += 1;
    end;
    for m := 0 to Round(TabI[pos_max][1]) - 1 do
      tab_med[eff_tot_int + m] := max;
    tab_val[k] := MinValue(tab_val) - 1;
    eff_tot_int += Round(TabI[k][1]);
  end;
end;

function CalculerMoyenne(tab_med: tableau1D): Real;
var
  i: Integer;
  total,Result: Real;
begin
  Result := 0;
  total := 0;
  for i := 0 to High(tab_med) do
    total := total + tab_med[i];
  Result := total / (High(tab_med) + 1);
  CalculerMoyenne := Result;
  writeln('La moyenne est : ', CalculerMoyenne);
end;

function CalculerMediane(tab_med: tableau1D): Real;
var
  n: Integer;
  Result: Real;
begin
  Result := 0;
  CalculerMediane := 0;
  n := High(tab_med) + 1;
  if n mod 2 = 0 then
    Result := (tab_med[n div 2 - 1] + tab_med[n div 2]) / 2
  else
    Result := tab_med[n div 2];
  CalculerMediane := Result;
  writeln('La mediane est : ', CalculerMediane);
end;

function CalculerVariance(tab_med: tableau1D): Real;
var
  i: Integer;
  Result, moyenne, sommeCarres: Real;
begin
  moyenne := CalculerMoyenne(tab_med);
  sommeCarres := 0;
  for i := 0 to High(tab_med) do
    sommeCarres := sommeCarres + Power(tab_med[i] - moyenne, 2);
  Result := sommeCarres / (High(tab_med) + 1);
  CalculerVariance := Result;
  writeln('La variance est : ', CalculerVariance);
end;

function CalculerEcartType(CalculerVariance: Real): Real;
var
  Result: Real;
begin
  Result := Sqrt(CalculerVariance);
  CalculerEcartType := Result;
  writeln('L''ecart type est : ', CalculerEcartType);
end;

end.
