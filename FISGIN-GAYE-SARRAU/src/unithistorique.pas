Unit unithistorique;

Interface

Const cheminacces='nom_dossier';

procedure historique(var retour_menu: Boolean);
procedure consultation(var save_calc: Textfile);
procedure viderhistorique(var save_calc: Textfile);

Implementation

Uses Sysutils, Crt;

procedure historique(var retour_menu: Boolean);
var choix: string; 
		save_calc: TextFile;
begin
retour_menu:=False;
choix:='';
ClrScr();
writeln('Bienvenu.e.s dans la section historique');
repeat
	writeln();
	writeln('Que souhaitez-vous realiser ?'); 
	writeln('Consulter l''historique de calculs = "C"');
	writeln('Supprimer l''historique de calculs = "S"');
	writeln('Quitter le menu historique = "q"');
 	writeln();
	write('Choix: ');
	readln(choix);
	ClrScr();
	if choix='C' then	
		consultation(save_calc)
	else if choix='S' then	
		viderhistorique(save_calc)
	else if choix='q' then
		retour_menu:=True
	else
		writeln('Saisie incorrecte');
	until retour_menu;
end;

procedure consultation(var save_calc: Textfile);
var lines: string;
begin
ClrScr();
assign(save_calc,cheminacces+'historique'+'.csv');
reset(save_calc);
while not(eof(save_calc)) do
  begin
  readln(save_calc,lines);
  writeln(lines);
  end;
close(save_calc);
end;

procedure viderhistorique(var save_calc: Textfile);
var choix: string;
begin
ClrScr();
writeln('! Attention, vous vous apprettez a supprimer l''ensemble de l''historique de calculs !');
writeln();
writeln('Confirmer la suppression = "S"');
writeln('Annuler la suppression = "A"');
write('Choix: ');
readln(choix);
if choix='S' then
  begin
  assign(save_calc,'historique' + '.csv');
  rewrite(save_calc);
  close(save_calc);
  end
else if choix<>'A' then
  begin
  ClrScr();
  writeln('Saisie incorrecte');
  end;
end;

end.