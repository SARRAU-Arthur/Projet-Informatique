program test3;
uses calculsimple,sysutils;
const MAX=60;
var  check: String;
	 j:Integer; 
	 result:Real;
	 SaveOperation: Array [1..Max] of String;
	 SaveResult:  Array [1..Max] of String;
begin
writeln('Bienvenue dans la section calcul classique');
rules();
j := 1;
repeat
	lireChaine(SaveOperation[j]);
	result := calcul(SaveOperation[j]);
	SaveResult[j]:=FloatToStr(result);
	Writeln(SaveResult[j]);
	repeat
		writeln(' continue /c or exist /e ');
		readln(check);
		until (check = 'c') or (check = 'e');
	j := j + 1;
	until (check = 'e');
end.
