program CalculatriceStatistique;

uses SysUtils, Math;

const MAX=20;

 
type t = Array [0..MAX] of Real ;
type tab_med=Array[1..100] of Real;
type subtab=array of Array of real;


 procedure SaisirTableau(var TabI:subtab ; var n:integer);
 var i,j:integer;
 var valeur:real;
 begin
 writeln('saisissez le nombre de valeur de la serie statistique: ');
 readln(n);
 setlength(TabI,n,2);
 for i:=0 to n do
	begin
	for j:=0 to 1 do
		begin
		writeln('saisissez la valeur de la case ',i,j);
		readln(valeur);
		TabI[i][0]:= valeur;
		writeln('saisir l"effectif de cette valeur');
		readln(effectif);
		TabI[i][1]:=effectif;
		end;
	end;
 end; 
  
  
  
procedure creationtableau(var tab_med:array of real) ;
var n,eff_tot,i,k:Integer;
begin
eff_tot:=0;
for i:=0 to n-1 do
	begin
	eff_tot+=TabI[i][1];
	end;
setlength(tab_med,eff_tot);
for k:=0 to n do
	begin
		creationtableau[k]:=nombre;
	end;

end;



///////////////
procedure CalculerMediane( var t2: t) ;
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
  
  ///////////////
  
  
  

///////////////
function CalculerMoyenne(donnees:array of real):Real;
var total:Real;
begin
  total := 0;
  for i := 0 to n - 1 do
    total := total + donnees[i];
  CalculerMoyenne := total / n;
end;
///////////////
}{
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
///////////////
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
///////////////
var
  donnees: array of real;
  total, moyenne, mediane, ecartType: real;
  i, n: integer;
  t1:t;
  ti:subtab;
begin
SaisirTableau(ti,n);
end.
