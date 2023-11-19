Unit calculsimple;


Interface

procedure lireChaine(var str: string);
procedure rules();
function Parantehese(expression: String ;  openPos : Integer): integer;
function calcul(s: String): Real;

Implementation
uses crt,sysutils,math;

//////////////////
 procedure lireChaine(var str : string);
	begin
   writeln('Entrez un calcul : ');
   readln(str);
	end;
//////////////////


//////////////////
procedure rules();
begin
Writeln('Quand tu doit faire calcul de cos ou sin, tu dois ecrire c pour cosinus et s pour sinüs. ');
Writeln('Example : =s90 ca veut dire sin(90) ');
Writeln('Les 4 operations mathematique sont memes');
Writeln('x pour la multiplication, + pour  addition, / pour la division, - pour la soustraction ');



end;



//////////////////
function Parantehese(expression: String ;  openPos : Integer):Integer;
var j:Integer;
  // Parantez içindeki ilk işlemi bul
 begin 
  for j := openPos to Length(expression) do
    if expression[j] = ')' then
    begin
      Parantehese := j;
      break;
    end;
  end;

//////////////////
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
      s1 := Copy(s, i + 1, closePos - i - 1); // prendre entre les paratehes
      s := Copy(s, 1, i - 1) + FloatToStr(calcul(s1)) + Copy(s, closePos + 1, Length(s)); // calcul 
      i := Length(s); // Yeni uzunluğu al
    end
    else
      Dec(i);
  end;

		i := Length(s);
		while i > 0 do
		begin
			if (s[i] = '+') or (s[i] = '-') then
			begin
				s1 := Copy(s, 0, i - 1);
				s2 := Copy(s, i + 1, Length(s));
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
			if (s[i] = 'x') or (s[i] = '/') then
			begin
				s1 := Copy(s, 0, i - 1);
				s2 := Copy(s, i + 1, Length(s));
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
		if (s[i] = '^') then
		begin
         s1 := Copy(s, 0, i - 1);
         s2 := Copy(s, i + 1, Length(s));
		 if s[i] = '^' then
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
			s2 := Copy(s, i + 1, Length(s));
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
 
   

END.

