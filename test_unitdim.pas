program test;

uses {unitdim} sysutils;

Const cheminacces='C:\Users\sarra\OneDrive\Documents\INSA\Projet-Informatique\';

Type EStab = Array [1..3,1..2] of String;

Type conversions = Record
	unite_i, unite_f, valeur_i: string
	end;
	
Type tableau = Record
	currentarray: Array of Array of String;
	end;

function parcoursfichier(var currentfile: TextFile; nom: String): String;
var k, n, m: Integer;
	lines: String;
begin
assign(currentfile,cheminacces + nom + '.csv');
reset(currentfile);
n:=0;
m:=0;
while not(eof(currentfile)) do
	begin
	n+=1;
	readln(currentfile,lines);
	end;
for k:=1 to length(lines) do
	begin
	if lines[k]=';' then
		m+=1;
	end;	
parcoursfichier:=IntToStr(n)+IntToStr(m);
end;

procedure chargementdonnees(var t: tableau; nom: string);
var i, j, k: Integer;
	lines, currentsquare, affichage, nm: String;
	currentfile: TextFile;
begin
lines:='';
i:=0;
j:=0;
nm:=parcoursfichier(currentfile,nom);
assign(currentfile,cheminacces + nom + '.csv');
reset(currentfile);
setlength(t.currentarray,StrToInt(nm[1]),StrToInt(nm[2]));
currentsquare:='';
while not(eof(currentfile)) do
	begin
	i+=1;
	affichage:='';
	readln(currentfile,lines);
	for k:=1 to length(lines) do
		begin
		if lines[k]<>';' then
			currentsquare:=currentsquare+lines[k]
		else
			begin
			t.currentarray[i][j]:=currentsquare;
			affichage:=affichage + ' ' + t.currentarray[i][j];
			j+=1;
			currentsquare:='';
			end;
		end;
	writeln(affichage);
	end;
close(currentfile);
end;

function conversion(var currentfile: TextFile): String;
var i, j, k, i_c, i_l, f_c, f_l: Integer;
	cv: conversions;
	trouve_i, trouve_f: Boolean;
	nm, og_nm: String;
	t, og: tableau;
	result, result_int, power_adjust: Extended;
begin
chargementdonnees(t,'conversions');
assign(currentfile,'conversions');
nm:=parcoursfichier(currentfile,'conversions');
setlength(t.currentarray,StrToInt(nm[1]),StrToInt(nm[2]));
{write('Valeur a convertir: ');
readln(cv.valeur_i);
write('Unite :');
readln(cv.unite_i);
write('Unite de conversion: ');
readln(cv.unite_f);}
cv.unite_i:='mm Hg';
cv.unite_f:='bar';
cv.valeur_i:='5';
trouve_i:=False;
trouve_f:=False;
i:=2;
while not(trouve_i) or not(trouve_f) do
	begin
	j:=1;
	while j<=StrToInt(nm[2]) div 2 do
		begin
		if (t.currentarray[i][2*j]=cv.unite_i) then
			begin
			i_l:=i;
			i_c:=2*j;
			trouve_i:=True;
			end;
		if (t.currentarray[i][2*j]=cv.unite_f) then
			begin
			f_l:=i;
			f_c:=2*j;
			trouve_f:=True;
			end;
		j+=1;
		end;
	i+=1;
	end;
if not(trouve_i) and not(trouve_f) then
	writeln('Impossible de realiser votre conversion, verifiez les unites et formats de votre saisie')
else
	begin
	result_int:=StrToFloat(t.currentarray[i_l][i_c+1])*StrToFloat(cv.valeur_i)/StrToFloat(t.currentarray[i_l][i_c-1]);
	result:= result_int*StrToFloat(t.currentarray[f_l][f_c-1])/StrToFloat(t.currentarray[f_l][f_c+1]);
	chargementdonnees(og,'ordres_grandeurs');
	writeln(FloatToStr(result));
	og_nm:=parcoursfichier(currentfile,'ordres_grandeurs');
	power_adjust:=1;
	for k:=1 to StrToInt(og_nm[1]) do
		begin
		if (cv.unite_i[1]=og.currentarray[k][1]) or (cv.unite_i[1]+cv.unite_i[2]=og.currentarray[k][1]) then
			power_adjust:=power_adjust*StrToFloat(og.currentarray[k][2]);
		if (cv.unite_f[1]=og.currentarray[k][1]) or (cv.unite_f[1]+cv.unite_f[2]=og.currentarray[k][1]) then
			power_adjust:=power_adjust*StrToFloat(og.currentarray[k][2]);
		end;
	result*=power_adjust;
	conversion:=FloatToStr(result);
	writeln(cv.valeur_i,' ',cv.unite_i,' ','=',' ',conversion,' ',cv.unite_f);
	end;
end;

//var currentfile: TextFile;
var t: tableau;
begin
chargementdonnees(t,'ordres_grandeurs');{ordres_grandeurs}
//conversion(currentfile);
end.
