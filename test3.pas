program test3;

uses calculsimple;

var  expressions,check: String;
	 j:Integer; 
	 result:Real;
begin
writeln('Bienvenue dans la section calcul classique');
rules();
j := 1;
repeat
	lireChaine(expressions);
	result := calcul(expressions);
	Writeln(result);
	repeat
		writeln(' continue /c or exist /e ');
		readln(check);
		until (check = 'c') or (check = 'e');
	j := j + 1;
	until (check = 'e');
end.
