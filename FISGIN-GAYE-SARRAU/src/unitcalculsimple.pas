Unit unitcalculsimple;

Interface

Const cheminacces='C:\Users\sarra\OneDrive\Documents\INSA\Projet Informatique\';

procedure calculsimple(var retour_menu: Boolean);
procedure lireChaine(var str: string);
procedure rules();
function parantehese(expression: String ;  openPos : Integer): integer;
procedure enregistrement(s: string; result: Real ; var save_calc: TextFile);
function calcul(s: String): Real;

Implementation

uses Crt, Sysutils, Math;

procedure calculsimple(var retour_menu: Boolean);
var choix, s: String;
	 	result:Real;
		save_calc: TextFile;
begin
retour_menu:=False;
ClrScr();
writeln('Bienvenu.e.s dans la section calcul classique');
repeat
  writeln();
  writeln('Realiser un calcul = "c"');
  writeln('Consulter la notice d''utilisation de saisie de calcul = "n"' );
  writeln('Quitter le menu calcul classique = "q"');
  writeln;
  write('Choix: ');
  readln(choix);
  ClrScr();
  if choix = 'c' then
    begin
    lireChaine(s);
    result:= calcul(s);
    enregistrement(s,result,save_calc);
    Writeln(s+' = '+FloatToSTr(result));
    end
  else if choix = 'n' then
    rules()
  else if choix = 'q' then
    retour_menu := True
  else
    writeln('Saisie incorrecte');
  until retour_menu;
ClrScr();
end;

procedure lireChaine(var str : string);
begin
write('Saisissez votre calcul: ');
readln(str);
end;

procedure rules();
begin
Writeln('cos(x) = "cx" / sin(x) = "sx"');
Writeln('Addition = "+" / Soustraction = "-" / Multiplication = "x" / Division = "/"');
Writeln('Logarithme de x base n = "nlx" / Exponentielle de x = ex');
end;

function parantehese(expression: String ;  openPos : Integer):Integer;
var j:Integer;
  // Trouver la calcul dans la parathese
begin 
for j := openPos to Length(expression) do
	begin
  if expression[j] = ')' then
		begin
		Parantehese := j;
		break;
		end;
	end;
end;

procedure enregistrement(s: string; result: Real ; var save_calc: TextFile);
begin
assign(save_calc,cheminacces+'historique'+'.csv');
append(save_calc);
writeln(save_calc,'');
write(save_calc,s+ ' = '+ FloatToSTr(result));
close(save_calc);
end;

function calcul(s: String): Real;
var
i,closePos:Integer;
s1, s2: String;
begin
	i := Length(s);
		while i > 0 do
	begin
		if (s[i] = '(') then
		begin
		closePos := Parantehese(s, i + 1); // trouver la Parantehese
		s1 := Copy(s, i + 1, closePos - i - 1);  // prendre entre les paratehes 
		s := Copy(s, 1, i - 1) + FloatToStr(calcul(s1)) + Copy(s, closePos + 1,  Length(s)-(i-1)); // calcul 
		i := Length(s); // calcul la length 
		end
		else
			Dec(i);
			end;
	i := Length(s);
	while i > 0 do
		begin
				if (s[i] = '-') and ((s[i-1] = 's') or(s[i-1] = 'c') )then 
			begin
			s1 := Copy(s, 1, i - 1);
			s2 := Copy(s, i , Length(s)-(i-1));
			s2 := FloatToStr(StrToFloat(s2));
			if s[i] = 'c' then
				calcul := cos(DegToRad(calcul(s2)))
				else
				calcul := sin(DegToRad(calcul(s2)));
				exit;			 
			end;				   
				if (s[i] = '-') and ((s[i-1] = '^')  )then 
			begin
			s1 := Copy(s, 1, i - 1);
			s2 := Copy(s, i , Length(s)-(i-1));
			s2 := FloatToStr(StrToFloat(s2));
			end;
					if (s[i] = '-') and ((s[i-1] = 'e')  )then 
			begin
			s1 := Copy(s, 1, i - 1);
			s2 := Copy(s, i , Length(s)-(i-1));
			s2 := FloatToStr(StrToFloat(s2));
			end;
				if ((s[i-1] = 'x')or (s[i-1] = '/') or (s[i-1] = '^')or (s[i-1] = 'e') or(s[i-1] = 'r')  or(s[i-1] = 'c') or (s[i-1] = 's') )or ((s[i] = '+') ) then
						begin
			if( (s[i] = '+') and (s[i-1] = 'x'))then 
			begin
			s1 := Copy(s, 1, i - 1);
			s2 := Copy(s, i , Length(s)-(i-1));
			s2 := FloatToStr(StrToFloat(s2));
			s:=s1+s2;
			end;
				if( (s[i] = '+') and (s[i-1] = '^'))then 
			begin
			s1 := Copy(s, 1, i - 1);
			s2 := Copy(s, i , Length(s)-(i-1));
			s2 := FloatToStr(StrToFloat(s2));
			s:=s1+s2;
			end;	
				if( (s[i] = '+') and (s[i-1] = 'r'))then 
				begin
				s1 := Copy(s, 1, i - 1);
				s2 := Copy(s, i , Length(s)-(i-1));
				s2 := FloatToStr(StrToFloat(s2));
				s:=s1+s2;
			end;			
				if( (s[i] = '+') and (s[i-1] = '/'))then 
				begin
				s1 := Copy(s, 1, i - 1);
				s2 := Copy(s, i , Length(s)-(i-1));
				s2 := FloatToStr(StrToFloat(s2));
				s:=s1+s2;
					end;	
				if( (s[i] = '+') and (s[i-1] = 'c'))then 
				begin
				s1 := Copy(s, 1, i - 1);
				s2 := Copy(s, i , Length(s)-(i-1));
				s2 := FloatToStr(StrToFloat(s2));
				s:=s1+s2;
				end;	
				if( (s[i] = '+') and (s[i-1] = 's'))then 
				begin
				s1 := Copy(s, 1, i - 1);
				s2 := Copy(s, i , Length(s)-(i-1));
				s2 := FloatToStr(StrToFloat(s2));
				s:=s1+s2;
				end;		
						if (s[i] = '+') and ((s[i-1] = 'e')  )then 
			begin
			s1 := Copy(s, 1, i - 1);
			s2 := Copy(s, i , Length(s)-(i-1));
			s2 := FloatToStr(StrToFloat(s2));
			end;	
			end;			  
		if ((s[i] = '+') or (s[i] = '-'))and ((s[i-1] <> 'x') and (s[i-1] <> 'e') and (s[i-1] <> '/') and (s[i-1] <> '^') and (s[i-1] <> 'r')and (s[i-1] <>' c') and  (s[i-1] <>'s')) then
			begin
			if (i=1) and ((s[i] = '+') or (s[i] = '-')) then
						begin
							if  (s[i] = '+')  then
				begin
					s1 := '0';
					s2 := Copy(s, i + 1, Length(s)-(i-1));   
								calcul := calcul(s1) + calcul(s2);
								exit;
				end;
							if  (s[i] = '-')  then
				begin
					s1 := '0';
				s2 := Copy(s, i + 1, Length(s)-(i-1));   
				calcul := calcul(s1) - calcul(s2);
				exit;
			end;
					end;
				s1 := Copy(s, 1, i - 1);
				s2 := Copy(s, i + 1, Length(s)-(i-1));

				if s[i] = '+' then
				calcul := calcul(s1) + calcul(s2)
				else
				calcul := calcul(s1) - calcul(s2);
			exit;
				end
		else
		i:=i-1;
		end;
	i := Length(s);
	while i > 0 do
	begin
			if ((s[i] = 'x') or (s[i] = '/')) and (s[i+1] = '-') then
			begin
			if(s[i] = 'x')then
			begin
			s1 := Copy(s, 1, i - 1);
			s2 := Copy(s, i +2, Length(s)-(i-1));
			s1:= '-'+Copy(s, 1, i - 1);
			calcul := calcul(s1) * calcul(s2)
			end;
			if(s[i] = '/')then
			begin
			s1 := Copy(s, 1, i - 1);
			s2 := Copy(s, i +2, Length(s)-(i-1));
			s1:= '-'+Copy(s, 1, i - 1);
			calcul := calcul(s1) / calcul(s2)
			end;
			end;
			
		if (s[i] = 'x') or (s[i] = '/')  then
		begin
			s1 := Copy(s, 1, i - 1);
			s2 := Copy(s, i + 1, Length(s)-(i-1));
			if s[i] = 'x' then
				calcul := calcul(s1) * calcul(s2)
			else
				calcul := calcul(s1) / calcul(s2);
				exit;
			end
		else
		i:=i-1;
		end;
		i := Length(s);
		while i > 0 do
		begin
	if (s[i] = 'l') then
			begin
		s1 := Copy(s, 1, i - 1);
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
		s1 := Copy(s, 1, i - 1);
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
			calcul := sin(DegToRad(calcul(s2)));
			exit;
		end
		else
			i:=i-1;
		end;			
calcul := StrToFloat(s);
end;
end.
