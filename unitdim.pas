Unit unitdim;

Interface

Const cheminacces='C:\Users\sarra\OneDrive\Documents\INSA\Projet Informatique\';

Type tableau = Array of Array of String;
	
Type constantes = Record
	constante, valeur, unite, dimension: string
	end;
	
Type conversions = Record
	unite_i, unite_f, valeur_i: string
	end;

{Type dimensions = Record
	grandeur: string
	end;}

Type fichiers = Record
	cv: conversions;
	ct: constantes
	end;

procedure fonctionnalites(var f: fichiers);
function parcoursfichier(var currentfile: TextFile; nom: String): String;
procedure chargementdonnees(var t:tableau; var nm: string; nom: string);
function conversion(var currentfile: TextFile): Extended;
function constante(var currentfile: TextFile): string;
//function dimension (var currentfile: TextFile): string;
procedure ajout(var f: fichiers);

Implementation

uses Sysutils, Math, Crt;

// Programme principale de l'unite
procedure fonctionnalites(var f: fichiers);
var valide: Boolean; 
	choix: string; 
	currentfile: TextFile;
begin
valide:=True;
choix:='';
repeat
	begin
	ClrScr();
	writeln('Que souhaitez-vous realiser ?'); 
	writeln('Entrez "cv" pour une conversions');
	writeln('Entrez "ct" pour la valeur de constante');
	//writeln('Entrez "dm" pour la dimension');
	writeln('Entrez "aj" pour ajouter des donnees');
	write('Choix: ');
	readln(choix);
	ClrScr();
	if choix='cv' then	
		conversion(currentfile);
	if choix='ct' then	
		constante(currentfile);
	if choix='aj' then	
		ajout(f);
	if choix='exit' then
		exit;
	{if choix='dm' then	
		dimension(currentfile);}
	if (choix<>'cv') and (choix<>'ct') and (choix<>'aj') then
		begin
		writeln('Saisie incorrecte');
		valide:=False;
		end;
	writeln('Souhaitez-vous continuer ? "o" / "n" : ');
	choix:=ReadKey;
	case choix of
		#111: 
		begin
		valide:=False;
		end;
		#110: 
		begin
		valide:=True;
		ClrScr();
		exit;
		end;
		end;
	end;
	until valide;
end;

// Determination nombre de lignes et colonnes d'un fichier csv ";"
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

// Chargement fichier csv en ";" vers un tableau Pascal
procedure chargementdonnees(var t: tableau; var nm: string; nom: string);
var i, j, k: Integer;
	lines, currentsquare, affichage: String;
	currentfile: TextFile;
begin
lines:='';
i:=0;
nm:=parcoursfichier(currentfile,nom);
reset(currentfile);
setlength(t,(StrToInt(nm)-StrToInt(nm) mod 10) div 10,StrToInt(nm) mod 10);
currentsquare:='';
while not(eof(currentfile)) do
	begin
	affichage:='';
	readln(currentfile,lines);
	j:=0;
	for k:=1 to length(lines) do
		begin
		if lines[k]<>';' then 
			currentsquare:=currentsquare + lines[k]
		else
			begin
			t[i][j]:=currentsquare;
			affichage:=affichage + ' ' + t[i][j];
			currentsquare:='';
			j+=1;
			end;
		end;
	//writeln(affichage);
	i+=1;
	end;
close(currentfile);
end;

// Realisation de conversions entre differentes unites et ordres de grandeur
function conversion(var currentfile: TextFile): Extended;
var i, j, k, i_c, i_l, f_c, f_l: Integer;
	cv: conversions;
	trouve_i, trouve_f, autorise: Boolean;
	nm, og_nm, unite_i, unite_f, valide: String;
	t, og: tableau;
	result, result_int, power_adjust: Extended;
begin
// Chargement fichier vers tableau avec donnees de conversions
chargementdonnees(t,nm,'conversions');
// Chargement fichier vers tableau avec donnes d'ordres de grandeur
chargementdonnees(og,og_nm,'ordres grandeurs');
trouve_i:=False;
trouve_f:=False;
autorise:=True;
power_adjust:=1E0;
conversion:=1E0;
cv.unite_i:='';
cv.unite_f:='';
valide:='0123456789E+-,';
// Saisie de valeur initiale et unites en jeu dans la conversion
write('Valeur intiale: ');
readln(cv.valeur_i);
write('Unite initiale: ');
readln(unite_i);
write('Unite finale: ');
readln(unite_f);
// Test de presence d'ordre de grandeur devant les unites saisies
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
// Determination de la position des unites dans le tableau
while (i<=(StrToInt(nm)-(StrToInt(nm) mod 10)) div 10-1) and (not(trouve_i) or not(trouve_f)) do
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
	i+=1;
	end;
// Calcul du resultat de conversion sans prise en compte des ordres de grandeurs eventuels
for i:=1 to length(cv.valeur_i) do	
	begin
	if (pos(cv.valeur_i[i],valide)=0) or (cv.unite_f='') or (cv.unite_i='') then
		autorise:=False;
	end;
if (not(trouve_i) and not(trouve_f)) or not(autorise) then
	writeln('Erreur, verifiez les unites et formats de votre saisie')
else
	begin
	if cv.unite_i<>cv.unite_f then 
		begin
		if (i_l<>f_l) then
			begin
			result_int:=StrToFloat(t[i_l][i_c+1])*StrToFloat(cv.valeur_i)/StrToFloat(t[i_l][i_c-1]);
			result:= result_int*StrToFloat(t[f_l][f_c-1])/StrToFloat(t[f_l][f_c+1]);
			end
		else
			result:=StrToFloat(cv.valeur_i)*StrToFloat(t[f_l][f_c-1])/StrToFloat(t[f_l][i_c-1]);
		end;
	// Integration au resultat des eventuels ordres de grandeurs
	if (cv.unite_i<>unite_i) or (cv.unite_f<>unite_f) then
		begin
		writeln('OK');
		for k:=1 to (StrToInt(og_nm)-(StrToInt(og_nm) mod 10)) div 10 - 1 do
			begin
			if (cv.unite_i<>cv.unite_f) then
				begin
				if (unite_i[1]=og[k][0]) then
					power_adjust*=StrToFloat(og[k][1]);
				if (unite_f[1]=og[k][0]) then
					power_adjust/=StrToFloat(og[k][1]);
				end
			else
				begin
				result:=StrToFloat(cv.valeur_i);
				if unite_i[1]=og[k][0] then
					power_adjust*=StrToFloat(og[k][1]);
				if unite_f[1]=og[k][0] then
					power_adjust/=StrToFloat(og[k][1]);	
				end;
			end;
		writeln(power_adjust);
		result*=power_adjust;
		end;
	conversion:=result;
	// Affichage a l'ecran, potentiellement ameliorable avec modulo et div, pour n'afficher que "precision" chiffres a l'ecran
	ClrScr();
	writeln(cv.valeur_i,' ',unite_i,' ','=',' ',conversion,' ',unite_f);
	end;
end;

// Consultation valeur d'une constante physique
function constante(var currentfile: TextFile): string;
var nm: string;
	ct: constantes;
	i: Integer;
	t: tableau;
	trouve: Boolean;
begin
chargementdonnees(t,nm,'constantes');
write('Constante dont vous souhaitez consulter la valeur: ');
readln(ct.constante);
trouve:=False;
i:=0;
while (i<=(StrToInt(nm)-(StrToInt(nm) mod 10)) div 10) and not(trouve) do
	begin
	if (t[i][0]=ct.constante) or (t[i][1]=ct.constante) then
		begin
		ct.valeur:=t[i][2];
		ct.unite:=t[i][3];
		ct.constante:=t[i][0];
		ct.dimension:=t[i][4];
		trouve:=True;
		end;
	i+=1;
	end;
if trouve=False then
	writeln('Saisie incorrecte, veuillez recommencer');
constante:=ct.constante + ' = ' + ct.valeur + ' ' + ct.unite + ' ; dimension = ' + ct.dimension ;
ClrScr();
writeln(constante);
end;

{Determination de la dimension d'une operations de grandeurs
function dimension (var currentfile: TextFile): string;
var nm: string;
	t: tableau;
	decoupage: Array of 
	grandeurs: string;
begin
writeln('Saisissez les grandeurs de votre problème');
readln(grandeurs)
chargementdonnees(t,nm,'dimensions');
for i=1 to length(grandeurs) do
	begin
	if (grandeurs[i]<>'*') or (grandeurs[i]<>'/') then
		begin
		decoupage:=grandeurs[i];
		end; 
	i+=1;
	end;
dimension:='à coder grâce aux CODES ASCII';
end;}

// Ajout d'informations dans les fichiers de base de données
procedure ajout(var f: fichiers);
var nom_fichier_ajout, nm, saisie: String;
	k: Integer;
	fichierajout: TextFile;
	t: tableau;
begin
writeln('Quel fichier souhaitez-vous editer ?');
write('Saisissez au choix: "conversions" / "constantes" / "dimensions" / "odres grandeur": ');
readln(nom_fichier_ajout);
chargementdonnees(t,nm,nom_fichier_ajout);
assign(fichierajout,cheminacces + nom_fichier_ajout + '.csv');
append(fichierajout);
writeln(fichierajout,'');
for k:=0 to (StrToInt(nm) mod 10) - 1 do
	begin
	write('Saisissez',' ',t[0][k] + ': ');
	readln(saisie); 
	write(fichierajout,saisie + ';');
	end;
ClrScr();
close(fichierajout);
end;

end.
