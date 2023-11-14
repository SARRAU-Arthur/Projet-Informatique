program test;

uses {unitdim} sysutils;

Type conversions = Record
	unite_i, unite_f, valeur_i: string
	end;
	
function conversion(var t: tableau): String;
var trouve: Boolean;
	i: Integer;
	cv: conversions;
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
	for i:=1 to l
	if (cv.unite_i in currentarray[i][2]) and (cv.unite_f in currentarray[i][4]) then
	
	else
		for j=1 to length(currentarray) do
			
	end;
	until i=length(currentarray) or trouve
end;

var t: tableau;
begin
conversion(t);
end.
