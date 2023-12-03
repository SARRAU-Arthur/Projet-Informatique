program CalculatriceStatistique;

uses SysUtils, Math;

const MAX=20;

type t = Array [0..MAX] of Real ;
type tableau1D=Array of Real;
type subtab=array of Array of real;

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
var n, eff_tot, i, k, j, pos_max, m:Integer;
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
	{l:=0;
	while not(trouve_min) do
		begin
		if tab_val[l]=MinValue(tab_val) then
			begin
			pos_min:=l;
			trouve_min:=True;
			end;
		l+=1;
		end;}
	TabI[pos_max][1]:=0;
	for m:=1 to Round(TabI[pos_max][1]) do
		tab_med[m]:=max;
	setlength(tab_med,eff_tot-k-1);
	end;
end;

{procedure CalculerMediane( var t2: t) ;
var  control,i:Integer;
	 mediane:Real;
	 t3:tab_med;
begin
control:=0;
  for i := 0 to MAX do
	begin
	if 	(t2[i]<>0)then
		begin
		t3:=creationtableau(control,i,t2[i]);	
		control:=control+i;
		end;
	end;
end;
  
function CalculerMoyenne(donnees:array of real):Real;
var total:Real;
begin
  total := 0;
  for i := 0 to n - 1 do
    total := total + donnees[i];
  CalculerMoyenne := total / n;
end;

procedure CalculerMediane;
begin
 
  if n mod 2 = 0 then
  begin
    // Si le nombre de donnÃ©es est pair, la mÃ©diane est la moyenne des deux valeurs du milieu
    mediane := (donnees[n div 2 - 1] + donnees[n div 2]) / 2;
  end
  else
  begin
    // Si le nombre de donnÃ©es est impair, la mÃ©diane est simplement la valeur du milieu
    mediane := donnees[n div 2];
  end;
end;

procedure CalculerEcartType;
var
  sommeCarres, ecartMoyen: real;
begin
  sommeCarres := 0;
  for i := 0 to n - 1 do
    sommeCarres := sommeCarres + Power(donnees[i] - moyenne, 2);
  ecartMoyen := sommeCarres / n;
  ecartType := Sqrt(ecartMoyen);
end;}

{var
  donnees: array of real;
  total, moyenne, mediane, ecartType: real;
  i, n: integer;
  t1:t;
  ti:subtab;}
var tab_med: tableau1D;
	i: integer;
begin
//SaisirTableau(ti,n);
creationtableau(tab_med);
for i:=1 to Length(tab_med) do
	writeln(tab_med[i]);
end.
