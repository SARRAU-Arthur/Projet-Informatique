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

procedure fonctionnalite(var f: fichiers; var t: tableau);
function parcoursfichier(var currentfile: TextFile): Integer;
procedure chargementdonnees(var t:tableau; nom: string);
function conversion (var t: tableau): string;
function constante (var t: tableau): string;
function dimension (var t: tableau): string;
function ordre_grandeur (var t: tableau): string;
procedure ajout(var fichierajout: TextFile; var f: fichiers; var t: tableau);

Implementation

uses Sysutils;

Const cheminacces='C:\Users\sarra\OneDrive\Documents\INSA\Projet-Informatique\';

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

function parcoursfichier(var currentfile: TextFile): String;
var k, n, m: Integer;
	lines: String;
begin
assign(currentfile,cheminacces);
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
close(currentfile);
end;

procedure chargementdonnees(var t: tableau; nom: string);
var i, j, k: Integer;
	lines, currentsquare, affichage, nm: String;
	currentfile: TextFile;
begin
lines:='';
i:=-1;
nm:=IntToStr(parcoursfichier(currentfile));
setlength(t.currentarray,StrToInt(nm[1]),StrToInt(nm[2]));
assign(currentfile,cheminacces);
reset(currentfile);
currentsquare:='';
while not(eof(currentfile)) do
	begin
	i+=1;
	j:=1;
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
	//writeln(affichage);
	end;
close(currentfile);
end;

function calc_conv (calcul_1, calcul_2, valeur_i: string): EStab;
var i, j, k: Integer;
	decim, puissance: String;
	atteint: Boolean;
	nombre: array [1..3,1..2] of String;
begin
nombre[1][1]:=calcul_1;
nombre[2][1]:=calcul_2;
nombre[3][1]:=valeur_i;
for j:=1 to 3 do
	begin
	decim:=' ';
	puissance:=' ';
	atteint:=False;
	for i:=1 to length(nombre[j][1]) do
		begin
		if ((nombre[j][1])[i]<>'E') and not(atteint) then
			decim+=(nombre[j][1])[i];
		if ((nombre[j][1])[i]='E') then
			atteint:=True;
		if ((nombre[j][1])[i]<>'E') and atteint then
			puissance+=(nombre[j][1])[i];
		end;
	calc_conv[j][1]:='';
	for k:=2 to length(decim) do
		calc_conv[j][1]:=calc_conv[j][1]+decim[k];
	for k:=2 to length(puissance) do
		calc_conv[j][2]:=calc_conv[j][2]+puissance[k];
	writeln(calc_conv[j][1],calc_conv[j][2]);
	end;
end;

procedure ajout(var f: fichiers; var t: tableau);
var nom_fichier_ajout, nm, saisie: String;
	k: Integer;
	fichierajout, currentfile: TextFile;
begin
writeln('Quel fichier souhaitez-vous editer ?');
writeln('Saisissez au choix: "conversions" / "constantes" / "dimensions" / "odres_grandeur"');
readln(nom_fichier_ajout);
assign(fichierajout,cheminacces+nom_fichier_ajout+'.csv');
chargementdonnees(t,nom_fichier_ajout);
nm:=IntToStr(parcoursfichier(currentfile));
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

end.
