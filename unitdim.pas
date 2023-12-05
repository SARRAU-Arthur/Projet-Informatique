Unit unitdim;

Interface

Type tableau = Array of Array of String;
	
Type EStab = Array [1..3,1..2] of String;

Type constantes = Record
	constante, valeur, unite: string
	end;
	
Type conversions = Record
	unite_i, unite_f, valeur_i: string
	end;
	
Type dimensions = Record
	grandeur: string
	end;

Type ordres_grandeurs = Record
	prefixe, puissance_de_10: string
	end;

Type fichiers = Record
	cv: conversions;
	ct: constantes;
	dm: dimensions;
	og: ordres_grandeurs;
	end;

procedure fonctionnalites(var f: fichiers);
function parcoursfichier(var currentfile: TextFile; nom: String): String;
procedure chargementdonnees(var t:tableau; var nm: string; nom: string);
function conversion(var currentfile: TextFile): Extended;
function constante(var currentfile: TextFile): string;
function dimension (var currentfile: TextFile): string;
procedure ajout(var f: fichiers; var t: tableau);

Implementation

uses Sysutils, Math;

Const cheminacces='C:\Users\sarra\OneDrive\Documents\INSA\Projet Informatique\';

procedure fonctionnalites(var f: fichiers);
var valide: Boolean; 
	choix: string; 
	currentfile: TextFile;
	t: tableau;
begin
valide:=True;
choix:='';
repeat
	begin
	writeln('Que souhaitez-vous realiser ?'); 
	writeln('Entrez "cv" pour effectuer une conversion d"unites');
	writeln('Entrez "ct" pour connaitre la valeur d"une constante');
	writeln('Entrez "dm" pour verifier la dimension d"une grandeur');
	writeln('Entrez "aj" pour ajouter des donnees dans la memoire de la calculatrice');
	writeln('Entrez "cs" pour consulter les consignes d"utilisation');
	readln(choix);
	case choix of
		'cv': conversion(currentfile);
		'ct': constante(currentfile);
		'dm': dimension(currentfile);
		'aj': ajout(f,t);
	else
		begin
		writeln('Saisie incorrecte, veuillez recommencer');
		valide:=False;
		end;
	end;
	end;
	until valide;
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

procedure chargementdonnees(var t: tableau; var nm: string; nom: string);
var i, j, k: Integer;
	lines, currentsquare, affichage: String;
	currentfile: TextFile;
begin
lines:='';
i:=-1;
j:=-1;
nm:=parcoursfichier(currentfile,nom);
reset(currentfile);
setlength(t,StrToInt(nm)-(StrToInt(nm) mod 10),StrToInt(nm) mod 10);
currentsquare:='';
while not(eof(currentfile)) do
	begin
	i+=1;
	affichage:='';
	readln(currentfile,lines);
	for k:=1 to length(lines) do
		begin
		j+=1;
		if lines[k]<>';' then
			currentsquare:=currentsquare+lines[k]
		else
			begin
			t[i][j]:=currentsquare;
			affichage:=affichage + ' ' + t[i][j];
			currentsquare:='';
			end;
		end;
	//writeln(affichage);
	end;
close(currentfile);
end;

function conversion(var currentfile: TextFile): Extended;
var i, j, k, i_c, i_l, f_c, f_l, delta: Integer;
	cv: conversions;
	trouve_i, trouve_f: Boolean;
	nm, og_nm, unite_i, unite_f: String;
	t, og: tableau;
	result, result_int, power_adjust: Extended;
begin
chargementdonnees(t,nm,'conversions');
{write('Valeur intiale: ');
readln(cv.valeur_i);
write('Unite initiale: ');
readln(unite_i);
write('Unite finale: ');
readln(unite_f);}
cv.valeur_i:='6,78';
unite_i:='bar';
unite_f:='Pa';
trouve_i:=False;
trouve_f:=False;
if unite_i[2]=' ' then
	begin
	for k:=3 to length(unite_i) do
		cv.unite_i:=cv.unite_i+unite_i[k];
	end	
else 
	cv.unite_i:=unite_i;
if unite_f[2]=' ' then
	begin
	for k:=3 to length(unite_f) do
		cv.unite_f:=cv.unite_f+unite_f[k];
	end
else
	cv.unite_f:=unite_f;
i:=0;
while (i<=(StrToInt(nm)-(StrToInt(nm) mod 10)) div 10) and (not(trouve_i) or not(trouve_f)) do
	begin
	j:=0;
	while j<((StrToInt(nm) mod 10) div 2) do
		begin
		if t[i][2*j+1]=cv.unite_i then
			begin
			i_l:=i;
			i_c:=2*j+1;
			trouve_i:=True;
			end;
		if t[i][2*j+1]=cv.unite_f then
			begin
			f_l:=i;
			f_c:=2*j+1;
			trouve_f:=True;
			end;
		j+=1;
		end;
	writeln(t[i][2*j+1]);
	i+=1;
	end;
writeln(i_l,' ',i_c,' ',f_l,' ',f_c);
if not(trouve_i) and not(trouve_f) then
	writeln('Impossible de realiser votre conversion, verifiez les unites et formats de votre saisie')
else
	begin
	if (i_l<>f_l) and (cv.unite_i<>cv.unite_f) then
		begin
		result_int:=StrToFloat(t[i_l][i_c+1])*StrToFloat(cv.valeur_i)/StrToFloat(t[i_l][i_c-1]);
		result:= result_int*StrToFloat(t[f_l][f_c-1])/StrToFloat(t[f_l][f_c+1]);
		end
	else if (i_l=f_l) and (cv.unite_i<>cv.unite_f) then 
		begin
		if i_c<f_c then
			delta:=-1
		else
			delta:=+1;
		result:=StrToFloat(cv.valeur_i)*StrToFloat(t[f_l][f_c+delta])/StrToFloat(t[f_l][i_c+delta])
		end;
	chargementdonnees(og,og_nm,'ordres_grandeurs');
	if (cv.unite_i<>unite_i) or (cv.unite_f<>unite_f) or (cv.unite_i=cv.unite_f) then
		begin
		for k:=1 to (StrToInt(og_nm)-(StrToInt(og_nm) mod 10)) div 10 -1 do
			begin
			power_adjust:=1E0;
			if (unite_i[1]=og[k][0]) and (cv.unite_i<>unite_i) and (cv.unite_i<>cv.unite_f) then
				power_adjust:=power_adjust*StrToFloat(og[k][1]);
			if  (unite_f[1]=og[k][0]) and (cv.unite_f<>unite_f) and (cv.unite_i<>cv.unite_f) then
				power_adjust:=power_adjust/StrToFloat(og[k][1]);
			if (cv.unite_i=cv.unite_f) then
				begin
				if (i_c<f_c) then
					begin
					if unite_i[1]=og[k][0] then
						result:=StrToFloat(cv.valeur_i)*StrToFloat(og[k][1])
					else if unite_f[1]=og[k][0] then
						result:=StrToFloat(cv.valeur_i)/StrToFloat(og[k][1]);
					end
				else
					begin
					if unite_i[1]=og[k][0] then
						result:=StrToFloat(cv.valeur_i)*StrToFloat(og[k][1])
					else if unite_f[1]=og[k][0] then
						result:=StrToFloat(cv.valeur_i)/StrToFloat(og[k][1]);
					end;
				end;
			result*=power_adjust;
			end;
		end;
	if ABS(result-Round(result))<0.001 then
		result:=Round(result);
	conversion:=result;	
	writeln(cv.valeur_i,' ',unite_i,' ','=',' ',conversion,' ',unite_f);
	end;
end;

function constante(var currentfile: TextFile): string;
var constant, nm, valeur, unite: string;
	i: integer;
	t: tableau;
	trouve: Boolean;
begin
chargementdonnees(t,nm,'constantes');
writeln('De quelle constante souhaitez-vous consulter la valeur');
readln(constant);
trouve:=False;
i:=-1;
while (i<=(StrToInt(nm)-(StrToInt(nm) mod 10)) div 10) and not(trouve) do
	begin
	if (t[i][0]=constant) or (t[i][1]=constant) then
		begin
		valeur:=t[i][2];
		unite:=t[i][3];
		constant:=t[i][0];
		trouve:=True;
		end;
	end;
if trouve=False then
	writeln('Saisie incorrecte, veuillez recommencer');
constante:=constant + ' = ' + valeur + ' ' + unite;
writeln(constante);
end;

function dimension (var currentfile: TextFile): string;
var nm: string;
	t: tableau;
begin
chargementdonnees(t,nm,'dimensions');

dimension:='à coder grâce aux CODES ASCII';
end;

procedure ajout(var f: fichiers; var t: tableau);
var nom_fichier_ajout, nm, saisie: String;
	k: Integer;
	fichierajout: TextFile;
begin
writeln('Quel fichier souhaitez-vous editer ?');
write('Saisissez au choix: "conversions" / "constantes" / "dimensions" / "odres_grandeur": ');
readln(nom_fichier_ajout);
assign(fichierajout,cheminacces + nom_fichier_ajout + '.csv');
append(fichierajout);
chargementdonnees(t,nm,nom_fichier_ajout);
for k:=1 to StrToInt(nm[2]) do
	begin
	writeln('Saisissez',' ',t[1][k]);
	readln(saisie); 
	writeln(saisie);
	setlength(t,StrToInt(nm[1])+1,StrToInt(nm[2]));
	t[StrToInt(nm[1])+1][k]:=saisie+';'
	end;
close(fichierajout);
end;

end.
