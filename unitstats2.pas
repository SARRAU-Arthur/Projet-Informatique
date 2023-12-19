unit unitstats;

interface

const
  MAX = 20;

type
  tableau1D = array of Real;
  subtab = array of array of Real;

procedure statistiques(var retour_menu: Boolean);
procedure SaisirTableau(var TabI: subtab; var n: integer);
procedure creationtableau(var tab_med: tableau1D; const TabI:subtab);
function CalculerMoyenne(const TabI: subtab): Real;
function CalculerMediane(tab_med: tableau1D): Real;
function CalculerVariance(const TabI: subtab): Real;
function CalculerEcartType(CalculerVariance: Real): Real;

implementation

uses
  SysUtils, Math;

procedure statistiques(var retour_menu: Boolean);
var
  option: char;
  n: integer;
  TabI: subtab;
  tab_med: tableau1D=nil;
  tableauSaisi: boolean;
begin
  tableauSaisi := False;
  retour_menu := False;
  writeln('Bienvenu.e.s dans la section statistiques');
  repeat
    writeln();
    writeln('Saisir un tableau depuis le terminal = "1"');
    writeln('Moyenne = "2"');
    writeln('Mediane = "3"');
    writeln('Variance = "4"');
    writeln('Ecart-type = "5"');
    writeln('Quitter le menu statistiques = "q"');
    writeln;
    write('Choix: ');
    readln(option);
    case option of
      '1': begin
             SaisirTableau(TabI, n);
             creationtableau(tab_med, TabI);
             tableauSaisi := True;
           end;
      '2': begin
             if tableauSaisi then
               writeln('La moyenne est : ', FloatToStr(CalculerMoyenne(TabI)))
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
               writeln('La variance est : ', FloatToStr(CalculerVariance(TabI)))
             else
               writeln('Veuillez d''abord saisir le tableau.');
           end;
      '5': begin
             if tableauSaisi then
               writeln('L''ecart type est : ', FloatToStr(CalculerEcartType(CalculerVariance(TabI))))
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
    writeln('Saisissez la valeur de la case ', i);
    readln(valeur);
    TabI[i][0] := valeur;
    writeln('Saisir l''effectif de cette valeur');
    readln(effectif);
    TabI[i][1] := effectif;
  end;
end;

procedure creationtableau(var tab_med: tableau1D; const TabI:subtab);
var
  n, eff_tot, i, k, j, pos_max, m, eff_tot_int: Integer;
  trouve_max: Boolean;
  
  tab_val: tableau1D;
  max: Real;
begin
  

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

    while not (trouve_max) and (j < n) do
    begin
      if tab_val[j] = max then
      begin
        pos_max := j;
        trouve_max := True;
      end;
      j += 1;
    end;

    if trouve_max then
    begin
      TabI[pos_max][0] := MinValue(tab_val) - 1;
      for m := 1 to Round(TabI[pos_max][1]) do
        tab_med[eff_tot_int + m] := max;
      eff_tot_int += Round(TabI[pos_max][1]);
    end;
  end;
end;


function CalculerMoyenne(const TabI: subtab): Real;
var
  i: Integer;
  total, Result, effectifTotal: Real;
begin
  total := 0;
  effectifTotal := 0;

  for i := 0 to High(TabI) do
  begin
    total := total + (TabI[i][0] * TabI[i][1]);
    effectifTotal := effectifTotal + TabI[i][1];
  end;

  if effectifTotal <> 0 then
    Result := total / effectifTotal
  else
    Result := 0;
   CalculerMoyenne:=Result;
end;

function CalculerMediane(tab_med: tableau1D): Real;
var
  n: Integer;
  Result: Real;
begin
  Result := 0;
  n := High(tab_med) + 1;

  if n mod 2 = 0 then
    Result := (tab_med[n div 2 - 1] + tab_med[n div 2]) / 2
  else
    Result := tab_med[n div 2];

  //writeln('La mediane est : ', Result);
  CalculerMediane := Result;
end;


function CalculerVariance(const TabI: subtab): Real;
var
  i, j, n, m: Integer;
  Result, moyenne, sommeCarres: Real;
  tab_val: tableau1D;
begin
  n := Length(TabI);
  m := 0;
  sommeCarres := 0;

  for i := 0 to n - 1 do
    m := m + Round(TabI[i][1]);

  SetLength(tab_val, m);
  m := 0;

  for i := 0 to n - 1 do
    for j := 1 to Round(TabI[i][1]) do
    begin
      tab_val[m] := TabI[i][0];
      m := m + 1;
    end;

  moyenne := CalculerMoyenne(TabI);

  for i := 0 to n - 1 do
    sommeCarres := sommeCarres + Power(tab_val[i] - moyenne, 2);

  Result := sommeCarres / (m - 1);
  CalculerVariance := Result;
end;

function CalculerEcartType(CalculerVariance: Real): Real;
var
Result:real;
begin
  Result := Sqrt(CalculerVariance);
  CalculerEcartType:=Result;
end;

end.



