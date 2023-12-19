unit unitstatistiques;

Interface 

const MAX=30; 

Type TRegressionResult = Record
     a, b, r_squared: Real
     end;

Type t = Array [0..MAX] of Real ;

Type tableau1D=Array of Real;

Type subtab= Array of Array of real;

Type tableau = Array of Array of String;

procedure statistiques(var retour_menu: Boolean);
procedure tab_real_to_str(var t: tableau;var TabI: subtab);
procedure SaisirTableau(var TabI:subtab ; var n: integer);
procedure creationtableau(var tab_med: tableau1D;var TabI: subtab) ;
function CalculerMoyenne(var TabI: subtab): Real;
function CalculerMediane(var tab_med: tableau1D): Real;
function CalculerVariance(var TabI: subtab): Real;
function CalculerEcartType(CalculerVariance: Real): Real;
procedure regression_lineaire(var TabI: subtab; var   tab_med: Tableau1D ;var a, b, r_squared: Real);
//procedure enregistrement(var save_stat: TextFile);

Implementation

uses SysUtils, Math, Crt, unitunites;

procedure statistiques(var retour_menu: Boolean);
var option: char;
    n: integer;
    TabI: subtab;
    tab_med: tableau1D;
    tableauSaisi: boolean;
    t:tableau;
    a, b, r_squared: real;
begin
tableauSaisi:= False;
retour_menu:=False;
writeln('Bienvenu.e.s dans la section statistiques'); 
ClrScr(); 
repeat
  writeln();
  writeln('Saisir un tableau depuis un fichier = "0"');
  writeln('Saisir un tableau depuis le terminal = "1"');
  writeln('Moyenne = "2"');
  writeln('Mediane = "3"');
  writeln('Variance = "4"');
  writeln('Ecart-type = "5"');
  writeln('Regression lineaire = "6"');
  writeln('Enregistrement dans l"historique = "7"');
  writeln('Quitter le menu statistiques = "q"');
  writeln;
  write('Choix: ');
  readln(option);
  ClrScr();
  case option of
    '0': 
      begin
      tab_real_to_str(t,TabI);
      creationtableau(tab_med, TabI);
      tableauSaisi := True;
      writeln('Saisie effective');
      end;
    '1': 
      begin
      SaisirTableau(TabI, n);
      creationtableau(tab_med, TabI);
      tableauSaisi := True;
      writeln('Saisie effective');
      end;
    '2': 
      begin
      if tableauSaisi then
        write('Moyenne = ',FloatToStr(CalculerMoyenne(TabI)))
      else
        writeln('Saisissez les donnees suivantes:');
      end;
    '3': 
      begin
      if tableauSaisi then
        write('Mediane = ', FloatToStr(CalculerMediane(tab_med)))
      else
        writeln('Saisissez les donnees suivantes:');
      end;
    '4': 
      begin
      if tableauSaisi then
        write('Variance = ', FloatToStr(CalculerVariance(TabI)))
      else
        writeln('Saisissez les donnees suivantes:');
      end;
    '5': 
      begin
      if tableauSaisi then
        write('Ecart-type = ', FloatToStr(CalculerEcartType(CalculerVariance(TabI))))
      else
        writeln('Saisissez les donnees suivantes:');
      end;
    '6':
      begin
        if tableauSaisi then
        begin
          regression_lineaire(TabI,tab_med, a, b, r_squared);
          //writeln('La regression lineaire est de la forme : Y = ', a, 'X + ', b);
          writeln('a= ',a,' b= ',b,' R^2= ',r_squared);
        end
        else
          writeln('Saisissez les données suivantes:');
      end;
    '7':
      retour_menu := True;
    'q': 
      retour_menu:=True;
    else
      writeln('Saisie incorrecte');
    end;
  until option = 'q';
end;

procedure tab_real_to_str(var t: tableau;var TabI: subtab);
var i, j, k: integer;
    nm, affichage: string;
begin
chargementdonnees(t,nm,'stats');
setlength(TabI,(StrToInt(nm)-StrToInt(nm) mod 10) div 10,StrToInt(nm) mod 10);
for i:=0 to (StrToInt(nm)-StrToInt(nm) mod 10) div 10 - 1 do
	begin
		affichage:='';

	for j:=0 to StrToInt(nm) mod 10 - 1 do
	begin
		TabI[i][j]:=StrToFloat(t[i][j]);
		affichage:=affichage + ' ' + FloatToStr(TabI[i][j]);
	end;
	writeln(affichage);
end;
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

procedure creationtableau(var tab_med: tableau1D; var TabI: subtab);
var
  n, eff_tot, i, k, j, pos_max, m, eff_tot_int: Integer;
  trouve_max: Boolean;
  tab_val: tableau1D;
  max: Real;
begin
  n := Length(TabI);
  eff_tot := 0;
  eff_tot_int := 0;
  trouve_max := False;
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
    begin
      tab_med[eff_tot_int + m] := max;
    end;

    tab_val[pos_max] := MinValue(tab_val) - 1;
    eff_tot_int += Round(TabI[pos_max][1]);
  end;
end;




function CalculerMoyenne(var TabI: subtab): Real;
var
  i: Integer;
  sommeValeurs, Result, sommeEffectifs: Real;
begin
  sommeValeurs := 0;
  sommeEffectifs := 0;

  for i := 0 to High(TabI) do
  begin
    sommeValeurs := sommeValeurs + (TabI[i][0] * TabI[i][1]);
    sommeEffectifs := sommeEffectifs + TabI[i][1];
  end;

  if sommeEffectifs <> 0 then
    Result := sommeValeurs / sommeEffectifs
  else
    Result := 0;

  CalculerMoyenne := Result;
end;






function CalculerMediane(var tab_med: tableau1D): Real;
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


function CalculerVariance(var TabI: subtab): Real;
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

procedure regression_lineaire(var TabI: subtab; var tab_med: Tableau1D; var a, b, r_squared: Real);
var
  i: integer;
  s_n, s_d, x_mean, y_mean: Real;
begin
  s_n := 0;
  s_d := 0;
  x_mean := 0;
  y_mean := 0;

  for i := 0 to High(TabI) do
  begin
    x_mean += TabI[i][0];
    y_mean += TabI[i][1];
  end;

  x_mean /= Length(TabI);
  y_mean /= Length(TabI);

  for i := 0 to High(TabI) do
  begin
    s_n += (TabI[i][0] - x_mean) * (TabI[i][1] - y_mean);
    s_d += Power(TabI[i][0] - x_mean, 2);
  end;

  a := s_n / s_d;
  b := y_mean - a * x_mean;

  r_squared := s_n / Sqrt(s_d * Power(Length(TabI), 2));
end;


end.

