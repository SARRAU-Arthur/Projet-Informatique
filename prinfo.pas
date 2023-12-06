unit unitstats;

Interface 

const MAX=20; 

type t = Array [0..MAX] of Real ;
type tableau1D=Array of Real;
type subtab=array of Array of real;

procedure SaisirTableau(var TabI:subtab ; var n:integer);
procedure creationtableau(var tab_med: tableau1D) ;
//procedure creationtableau(var tab_med: tableau1D) ;
function CalculerMoyenne(tab_med:Tableau1D):real;

Implementation

uses SysUtils, Math;

procedure SaisirTableau(var TabI:subtab ; var n:integer);
var i, effectif:integer;
var valeur:real;
begin
writeln('saisissez le nombre de valeur de la serie statistique: ');
readln(n);
setlength(TabI,n,2);
for i:=0 to n-1 do
	begin
	writeln('saisissez la valeur de la case ');
	readln(valeur);
	TabI[i][0]:= valeur;
	writeln('saisir l"effectif de cette valeur');
	readln(effectif);
	TabI[i][1]:=effectif;
	end;
end; 
  
procedure creationtableau(var tab_med: tableau1D) ;
var n, eff_tot, i, k, j, pos_max, m, eff_tot_int:Integer;
	TabI: subtab;
	trouve_max: Boolean;
	tab_val: tableau1D;
	max: real;
begin
//SaisirTableau(TabI,n);
n:=3;
setlength(TabI,n,2);
TabI[0][0]:=2.9;
TabI[0][1]:=10;
TabI[1][0]:=3.6;
TabI[1][1]:=7;
TabI[2][0]:=-9.6;
TabI[2][1]:=1;
eff_tot:=0;
eff_tot_int:=0;
trouve_max:=False;
setlength(tab_val,n);
for i:=0 to n-1 do
	begin
	eff_tot+=Round(TabI[i][1]);
	tab_val[i]:=TabI[i][0];
	end;
setlength(tab_med,eff_tot);
for k:=0 to n do
	begin
	max:=MaxValue(tab_val);
	j:=0;
	while not(trouve_max) do
		begin
		if tab_val[j]=max then
			begin
			pos_max:=j;
			trouve_max:=True;
			end;
		j+=1;
		end;
	TabI[pos_max][0]:=MinValue(tab_val)-1;
	for m:=1 to Round(TabI[pos_max][1]) do
		tab_med[eff_tot_int+m]:=max;
	eff_tot_int+=Round(TabI[j][1]);
	end;
end;
function CalculerMoyenne(tab_med: Tableau1D): Real;
var
  i: Integer;
  total: Real;
begin
  total := 0;
  for i := 0 to High(tab_med) do
    total := total + tab_med[i];
  Result := total / (High(tab_med) + 1);
end;

function CalculerMediane(tab_med: Tableau1D): Real;
var
  n: Integer;
begin
  n := High(tab_med) + 1;
  if n mod 2 = 0 then
    Result := (tab_med[n div 2 - 1] + tab_med[n div 2]) / 2
  else
    Result := tab_med[n div 2];
end;

function CalculerEcartType(tab_med: Tableau1D; moyenne: Real): Real;
var
  i: Integer;
  sommeCarres, ecartMoyen: Real;
begin
  sommeCarres := 0;
  for i := 0 to High(tab_med) do
    sommeCarres := sommeCarres + Power(tab_med[i] - moyenne, 2);
  ecartMoyen := sommeCarres / (High(tab_med) + 1);
  Result := Sqrt(ecartMoyen);
end;
