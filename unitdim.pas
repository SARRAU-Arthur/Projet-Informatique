Unit unitdim;

Interface

Type tableau = Record
	currentarray: Array of Array of String
	end;
	
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

Implementation

uses Sysutils;

Const cheminacces='C:\Users\sarra\OneDrive\Documents\INSA\Projet Informatique\';

procedure fonctionnalite(var f: fichiers; var t: tableau);
function parcoursfichier(var currentfile: TextFile; nom: String): String;
procedure chargementdonnees(var t:tableau; nom: string);
function conversion (var t: tableau): string;
function constante(var t: tableau): string;
function dimension (var t: tableau): string;
function ordre_grandeur (var t: tableau): string;
procedure ajout(var fichierajout: TextFile; var f: fichiers; var t: tableau);

procedure fonctionnalite(var f: fichiers; var t: tableau);
var valide: Boolean; 
	choix: string; 
	currentfile: TextFile;
	fichierajout: Textfile;
begin
valide:=True;
choix:='';
while not(valide) do
	begin
	writeln('Que souhaitez-vous realiser ?'); 
	writeln('Entrez "cv" pour effectuer une conversion d"unites');
	writeln('Entrez "ct" pour connaitre la valeur d"une constante');
	writeln('Entrez "dm" pour verifier la dimension d"une grandeur');
	writeln('Entrez "og" pour consulter les differents ordres de grandeurs');
	writeln('Entrez "aj" pour ajouter des donnees dans la memoire de la calculatrice');
	readln(choix);
	case choix of
		'cv': 
		begin;
		assign(currentfile,cheminacces+'conversions.csv');
		conversion(t);
		valide:=False;
		end;
		'ct': 
		begin;
		assign(currentfile,cheminacces+'constantes.csv');
		constante(t);
		valide:=False;
		end;
		'dm': 
		begin;
		assign(currentfile,cheminacces+'dimensions.csv');
		dimension(t);
		valide:=False;
		end;
		'og': 
		begin;
		assign(currentfile,cheminacces+'ordres_grandeurs.csv');
		ordre_grandeur(t);
		valide:=False;
		end;
		'aj': 
		begin;
		ajout(fichierajout,f,t);
		valide:=False
		end;
	else
		writeln('Saisie incorrecte, veuillez recommencer');
	end;
end;
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
i:=-1;
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
			//writeln('OK');
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

function conversion(var currentfile: TextFile): Extended;
var i, j, k, i_c, i_l, f_c, f_l, delta: Integer;
	cv: conversions;
	trouve_i, trouve_f: Boolean;
	nm, og_nm, unite_i, unite_f: String;
	t, og: tableau;
	result, result_int, power_adjust: Extended;
begin
chargementdonnees(t,'conversions');
assign(currentfile,'conversions');
nm:=parcoursfichier(currentfile,'conversions');
setlength(t.currentarray,(StrToInt(nm)-(StrToInt(nm) mod 10)) div 10,StrToInt(nm) mod 10);
{write('Valeur intiale: ');
readln(cv.valeur_i);
write('Unite initiale: ');
readln(unite_i);
write('Unite finale: ');
readln(unite_f);}
cv.valeur_i:='1987778,7665';
unite_i:='m';
unite_f:='k m';
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
while not(trouve_i) or not(trouve_f) do
	begin
	j:=0;
	while j<((StrToInt(nm) mod 10) div 2) do
		begin
		if t.currentarray[i][2*j+1]=cv.unite_i then
			begin
			i_l:=i;
			i_c:=2*j+1;
			trouve_i:=True;
			end;
		if t.currentarray[i][2*j+1]=cv.unite_f then
			begin
			f_l:=i;
			f_c:=2*j+1;
			trouve_f:=True;
			end;
		j+=1;
		end;
	i+=1;
	end;
//writeln(i_l,' ',i_c,' ',f_l,' ',f_c);
if not(trouve_i) and not(trouve_f) then
	writeln('Impossible de realiser votre conversion, verifiez les unites et formats de votre saisie')
else
	begin
	if (i_l<>f_l) and (cv.unite_i<>cv.unite_f) then
		begin
		result_int:=StrToFloat(t.currentarray[i_l][i_c+1])*StrToFloat(cv.valeur_i)/StrToFloat(t.currentarray[i_l][i_c-1]);
		result:= result_int*StrToFloat(t.currentarray[f_l][f_c-1])/StrToFloat(t.currentarray[f_l][f_c+1]);
		end
	else if (i_l=f_l) and (cv.unite_i<>cv.unite_f) then 
		begin
		if i_c<f_c then
			delta:=-1
		else
			delta:=+1;
		result:=StrToFloat(cv.valeur_i)*StrToFloat(t.currentarray[f_l][f_c+delta])/StrToFloat(t.currentarray[f_l][i_c+delta])
		end;
	chargementdonnees(og,'ordres_grandeurs');
	og_nm:=parcoursfichier(currentfile,'ordres_grandeurs');
	if (cv.unite_i<>unite_i) or (cv.unite_f<>unite_f) or (cv.unite_i=cv.unite_f) then
		begin
		for k:=1 to (StrToInt(og_nm)-(StrToInt(og_nm) mod 10)) div 10 -1 do
			begin
			power_adjust:=1E0;
			if (unite_i[1]=og.currentarray[k][0]) and (cv.unite_i<>unite_i) and (cv.unite_i<>cv.unite_f) then
				power_adjust:=power_adjust*StrToFloat(og.currentarray[k][1]);
			if  (unite_f[1]=og.currentarray[k][0]) and (cv.unite_f<>unite_f) and (cv.unite_i<>cv.unite_f) then
				power_adjust:=power_adjust/StrToFloat(og.currentarray[k][1]);
			if (cv.unite_i=cv.unite_f) then
				begin
				if (i_c<f_c) then
					begin
					if unite_i[1]=og.currentarray[k][0] then
						result:=StrToFloat(cv.valeur_i)*StrToFloat(og.currentarray[k][1])
					else if unite_f[1]=og.currentarray[k][0] then
						result:=StrToFloat(cv.valeur_i)/StrToFloat(og.currentarray[k][1]);
					end
				else
					begin
					if unite_i[1]=og.currentarray[k][0] then
						result:=StrToFloat(cv.valeur_i)*StrToFloat(og.currentarray[k][1])
					else if unite_f[1]=og.currentarray[k][0] then
						result:=StrToFloat(cv.valeur_i)/StrToFloat(og.currentarray[k][1]);
					end;
				end;
			result*=power_adjust;
			end;
		end;
	{if abs(result-Round(result)<0.001 then
		result:=Round(result);}
	conversion:=result;	
	end;
writeln(cv.valeur_i,' ',unite_i,' ','=',' ',conversion,' ',unite_f);
end;

procedure ajout(var f: fichiers; var t: tableau);
var nom_fichier_ajout, nm, saisie: String;
	k: Integer;
	fichierajout, currentfile: TextFile;
begin
writeln('Quel fichier souhaitez-vous editer ?');
writeln('Saisissez au choix: "conversions" / "constantes" / "dimensions" / "odres_grandeur"');
readln(nom_fichier_ajout);
assign(fichierajout,cheminacces + nom_fichier_ajout + '.csv');
chargementdonnees(t,nom_fichier_ajout);
nm:=parcoursfichier(currentfile,nom_fichier_ajout);
setlength(t.currentarray,StrToInt(nm[1])+1,StrToInt(nm[2]));
//t.currentarray[StrToInt(nm[1])+1][StrToInt(nm[2])];
for k:=1 to StrToInt(nm[2]) do
	begin
	writeln('Saisissez',' ',t.currentarray[1][k]);
	readln(saisie);
	t.currentarray[StrToInt(nm[1])+1][k]:=saisie+';'
	end;
close(fichierajout);
end;

function constante(var t: tableau): string;
var constant, nm: string;
	currentfile: TextFile;
begin
nm:=parcoursfichier(currentfile,'conversions');
chargementdonnees(t,'conversions');
writeln('De quelle constante souhaitez-vous consulter la valeur');
readln(constant);
constante:=constant+nm;
end;

end.
