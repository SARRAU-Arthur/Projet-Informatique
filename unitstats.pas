unit unitstats;

Interface 

const MAX=20; 

type t = Array [0..MAX] of Real ;
type tableau1D=Array of Real;
type subtab=array of Array of real;
Type tableau = Array of Array of String;

procedure stats();
procedure tab_real_to_str(var t: tableau;var TabI: subtab);
procedure SaisirTableau(var TabI:subtab ; var n:integer);
procedure creationtableau(var tab_med: tableau1D;const TabI: subtab) ;
function CalculerMoyenne(tab_med:Tableau1D):real;
function CalculerMediane(tab_med: Tableau1D): Real;
function CalculerVariance(tab_med: tableau1D):real;
function CalculerEcartType(CalculerVariance: Real): Real;

Implementation

uses SysUtils, Math, unitdim;

procedure stats();
var
  option: char;
  nm: string;
  n: integer;
  TabI: subtab;
  tab_med: tableau1D;
  tableauSaisi: boolean;
  t:tableau;
begin
  tableauSaisi := False;

  repeat
    writeln('Menu de calcul statistique:');
    writeln('0. Saisir un tableau depuis un fichier');
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
      '0': begin
		 chargementdonnees(t,nm,'stat');
		 tab_real_to_str(t,TabI);
		 creationtableau(tab_med, TabI);
		 tableauSaisi := True;
		end;
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
end;

procedure tab_real_to_str(var t: tableau;var TabI: subtab);
var i, j: integer;
	nm: string;
	currentfile: TextFile;
begin
nm:=parcoursfichier(currentfile,'stat');
for i:=0 to (StrToInt(nm)-StrToInt(nm) mod 10) div 10 do
	begin
	for j:=0 to StrToInt(nm) mod 10 do
		begin
		t[i][j]:=FloatToStr(TabI[i][j]);
		end;
	end;
end;

procedure SaisirTableau(var TabI:subtab ; var n:integer);
var i, effectif:integer;
var valeur:real;
begin
writeln('saisissez le nombre de valeur de la serie statistique: ');
readln(n);
setlength(TabI,n,2);
for i:=0 to n-1 do
	begin
	writeln('saisissez la valeur de la case ',i);
	readln(valeur);
	TabI[i][0]:= valeur;
	writeln('saisir l"effectif de cette valeur');
	readln(effectif);
	TabI[i][1]:=effectif;
	end;
end; 
  
procedure creationtableau(var tab_med: tableau1D;const TabI: subtab) ;
var i, k, j, m, n, eff_tot,pos_max, eff_tot_int:Integer;
	
	trouve_max: Boolean;
	tab_val: tableau1D;
	max: real;
begin
//SaisirTableau(TabI,n);
{n:=3;
setlength(TabI,n,2);
TabI[0][0]:=2.9;
TabI[0][1]:=2;
TabI[1][0]:=2.6;
TabI[1][1]:=1;
TabI[2][0]:=-9.6;
TabI[2][1]:=3;}
n:=Length(TabI);
eff_tot:=0;
eff_tot_int:=0;
setlength(tab_val,n);
for i:=0 to n-1 do
	begin
	eff_tot+=Round(TabI[i][1]);
	tab_val[i]:=TabI[i][0];
	end;
setlength(tab_med,eff_tot);
for k:=0 to n - 1 do
	begin
	max:=MaxValue(tab_val);
	j:=0;
	trouve_max:=False;
	while not(trouve_max) do
		begin
		if tab_val[j]=max then
			begin
			pos_max:=j;
			trouve_max:=True;
			end;
		j+=1;
		end;
	for m:=0 to Round(TabI[pos_max][1]) do
		tab_med[eff_tot_int+m]:=max;
	tab_val[k]:=MinValue(tab_val)-1;
	eff_tot_int+=Round(TabI[k][1]);
	end;
end;

function CalculerMoyenne(tab_med: Tableau1D): Real;
var
  i: Integer;
  total: Real;
  Result:real;
begin
  total := 0;
  for i := 0 to High(tab_med) do
    total := total + tab_med[i];
  Result := total / (High(tab_med) + 1);
  CalculerMoyenne:=Result;
//writeln('La moyenne est : ', CalculerMoyenne);
end;

function CalculerMediane(tab_med: Tableau1D): Real;
var
  n: Integer;
  Result:real;
begin

  Result:=0;
  CalculerMediane:=0;
  n := High(tab_med) + 1;
  if n mod 2 = 0 then
    Result := (tab_med[n div 2 - 1] + tab_med[n div 2]) / 2
  else
    Result := tab_med[n div 2];
  CalculerMediane:=Result;
//writeln('La mediane est : ', CalculerMediane);
end;

function CalculerVariance(tab_med: tableau1D):real;
var
  i: Integer;
  Result, moyenne, sommeCarres: Real;
begin
  moyenne:=CalculerMoyenne(tab_med);
  sommeCarres := 0;
  for i := 0 to High(tab_med) do
    sommeCarres := sommeCarres + Power(tab_med[i] - moyenne, 2);
  Result := sommeCarres / (High(tab_med) + 1);
  CalculerVariance:=Result;
//writeln('La variance est : ',CalculerVariance);
end;

function CalculerEcartType(CalculerVariance: Real): Real;
var
   Result:real;
begin
  Result := Sqrt(CalculerVariance);
   CalculerEcartType:=Result;
//writeln('L''ecart type est : ', CalculerEcartType);
end;

end.
