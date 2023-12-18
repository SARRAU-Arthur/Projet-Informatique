Unit unitcalcul;

Interface

const MAX=50;

procedure calcul(var retour_menu: Boolean);
procedure lireChaine(var str: string);
procedure rules();
function paranthese(expression: String ; openPos : Integer): integer;
function calcul(s: String): Real;
//procedure enregistrement(var save_calc: TextFile);

Implementation

uses Crt, Sysutils, Math;

procedure calcul(var retour_menu: Boolean);
var choix: String;
		j:Integer; 
	 	result:Real;
	 	SaveOperation: Array [1..Max] of String;
	 	SaveResult:  Array [1..Max] of String;
begin
retour_menu:=False;
ClrScr();
writeln('Bienvenu.e.s dans la section calcul classique');
repeat
	writeln();
	writeln('Realiser un calcul = "c"');
	writeln('Quitter le menu calcul classique = "q"');
	writeln;
	write('Choix: ');
	readln(choix);
	ClrScr();
  //rules();
	if choix='C' then
		begin
		j:=Length(SaveOperation);
		lireChaine(SaveOperation[j]);
		result:=calcul(SaveOperation[j]);
		SaveResult[j]:=FloatToStr(result);
		Writeln(SaveResult[j]);
		end;
		if choix='q' then
			retour_menu:=True;
	if choix='q' then
		retour_menu:=True
	else
		writeln('Saisie incorrecte');
	until retour_menu;
ClrScr();
end;

procedure lireChaine(var str : string);
begin
write('Entrez un calcul: ');
readln(str);
end;

procedure rules();
begin
Writeln('Quand tu dois faire calcul de cos ou sin, tu dois ecrire c pour cosinus et s pour sinüs. ');
Writeln('Example : =s90 ca veut dire sin(90) ');
Writeln('Les 4 operations mathematique sont memes');
Writeln('x pour la multiplication, + pour  addition, / pour la division, - pour la soustraction ');
Writeln('nlx pour la logaritma ,n est la base ,x est la valeur et et l est la logaritma ');
end;

function paranthese(expression: String ;  openPos : Integer):Integer;
var j:Integer;
  // Trouver la calcul dans la parathese
begin 
for j := openPos to Length(expression) do
	begin
  if expression[j] = ')' then
		begin
		Paranthese := j;
		break;
		end;
	end;
end;

procedure enregistrement(var save_calc: TextFile);
begin
end;

function calcul(s: String): Real;
var i,closePos:Integer;
		s1, s2: String;
begin
i := Length(s);
while i > 0 do
	begin
	if (s[i] = '(') then
		begin
		closePos:=Paranthese(s, i + 1); // trouver la parantehese
		s1:=Copy(s, i + 1, closePos - i - 1); // prendre entre les paratheses
		s:=Copy(s, 1, i - 1) + FloatToStr(calcul(s1)) + Copy(s, closePos + 1, Length(s)); // calcul 
		i:=Length(s); // calcul la longueur de s 
		end
	else
		Dec(i);
	end;
i := Length(s);
while i > 0 do
	begin
	if (s[i] = '+') or (s[i] = '-') then
		begin
		s1:=Copy(s, 0, i - 1);
		s2:=Copy(s, i + 1, Length(s)-(i-1));
		if s[i] = '+' then
		calcul:=calcul(s1) + calcul(s2)
		else
		calcul:=calcul(s1) - calcul(s2);
		exit;
		end
	else
	i:=i-1;
	end;
i := Length(s);
while i > 0 do
	begin
	if (s[i] = 'x') or (s[i] = '/') then
		begin
		s1 := Copy(s, 0, i - 1);
		s2 := Copy(s, i + 1, Length(s)-(i-1));
		if s[i] = 'x' then
			begin
			calcul := calcul(s1) * calcul(s2);
			exit;
			end
		else
			begin
			calcul := calcul(s1) / calcul(s2);
			exit;
			end;
		end
	else
		i:=i-1;
	end;
i := Length(s);
while i > 0 do
	begin
	if (s[i] = 'l') then
		begin
		s1 := Copy(s, 0, i - 1);
		s2 := Copy(s, i + 1, Length(s)-(i-1));
		calcul := Logn(calcul(s1),calcul(s2));
		exit;
		end
	else
		i:=i-1;
	end;	
i := Length(s);
while i > 0 do
	begin
	if (s[i] = 'r') then
		begin
		s1 := Copy(s, 0, i - 1);
		s2 := Copy(s, i + 1, Length(s)-(i-1));
		calcul :=  Sqrt(calcul(s2));
		exit;
		end
	else
		i:=i-1;
	end;	
i := Length(s);
while i > 0 do
	begin
	if (s[i] = 'e') then
		begin
		s1 := Copy(s, 0, i - 1);
		s2 := Copy(s, i + 1, Length(s)-(i-1));
		calcul :=  Exp(calcul(s2));
		exit;
		end
	else
		i:=i-1;
	end;	
i := Length(s);
while i > 0 do
	begin
	if (s[i] = '^') then
		begin
		s1 := Copy(s, 0, i - 1);
		s2 := Copy(s, i + 1, Length(s)-(i-1));
		calcul := power(calcul(s1),calcul(s2));
		exit;
		end
	else
		i:=i-1;
	end;
i := Length(s);
while i > 0 do
	begin
	if (s[i] = 'c') or (s[i] = 's') then
		begin
		s2 := Copy(s, i + 1, Length(s)-(i-1));
		if s[i] = 'c' then
			calcul := cos(DegToRad(calcul(s2)))
		else
			begin
			calcul := sin(DegToRad(calcul(s2)));
			exit;
			end;
		end
	else
		i:=i-1;
	end;		
calcul := StrToFloat(s);
end;

end.
