Unit unitdim;

Interface

Type constantes = Record
	constante, valeur, unite: string
	end;
	
Type tableau = Record
	currentarray: Array of Array of String
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
	og: ordres_grandeurs
	end;

procedure fonctionnalite(var f: fichiers);
function parcoursfichier(var currentfile: TextFile): Integer;
procedure chargementdonnes(var t:tableau);
//function conversion (cv: conversions): string;
function constante (ct: constantes): string;
function dimension (dm: dimensions): string;
function ordre_grandeur (og: ordres_grandeurs): string;
procedure ajout(var fichierajout: TextFile; var f: fichiers);

Implementation

uses Sysutils;

Const cheminacces='C:\Users\sarra\OneDrive\Documents\INSA\Projet Informatique\';

procedure fonctionnalite(var f: fichiers);
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
		chargementdonnees;
		conversion(f.cv,currentarray);
		valide:=False;
		end;
		'ct': 
		begin;
		assign(currentfile,cheminacces+'constantes.csv');
		chargementdonnees;
		constante(ct);
		valide:=False;
		end;
		'dm': 
		begin;
		assign(currentfile,cheminacces+'dimensions.csv');
		chargementdonnees;
		dimension(dm);
		valide:=False;
		end;
		'og': 
		begin;
		assign(currentfile,cheminacces+'ordres_grandeurs.csv');
		chargementdonnees;
		ordre_grandeur(og);
		valide:=False;
		end;
		'aj': 
		begin;
		ajout(fichierajout,f);
		valide:=False
		end;
	else
		writeln('Saisie incorrecte, veuillez recommencer');
	end;
end;

function parcoursfichier(var currentfile: TextFile): Integer;
var k, n,m: Integer;
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
parcoursfichier:=10*n+m;
close(currentfile);
end;

procedure chargementdonnes(var t: tableau);
var i, j, k, n, m: Integer;
	lines, currentsquare, affichage: String;
	currentfile: TextFile;
begin
lines:='';
i:=0;
m:=parcoursfichier(currentfile) mod 10;
n:=(parcoursfichier(currentfile)-m) div 10;
setlength(t.currentarray,n,m);
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
	writeln(affichage);
	end;
close(currentfile);
end;

{function conversion(cv: conversions; var currentarray): String;
var trouve: Boolean;
	i: Integer;
begin
writeln('Valeur a convertir: ');
readln(cv.valeur_i);
writeln('Unite :');
readln(cv.unite_i);
writeln('Unite de conversion: ');
readln(cv.unite_f);
trouve:=False;
repeat 
	begin
	for i=1 to l
	if (cv.unite_i in currentarray[i][2]) and (cv.unite_f in currentarray[i][4]) then
	
	else
		for j=1 to length(currentarray) do
			
	end;
	until i=length(currentarray) or trouve
end;}

procedure ajout(var fichierajout: TextFile; var f: fichiers);
var nom_fichier_ajout: String;
begin
writeln('Quel fichier souhaitez-vous editer ?');
writeln('Saisissez au choix: "conversions" / "constantes" / "dimensions" / "odres_grandeur"');
readln(nom_fichier_ajout);
assign(fichierajout,cheminacces+nom_fichier_ajout+'.csv');
end;

end.
