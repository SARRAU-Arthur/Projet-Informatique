Unit unitcalcul;

Interface

const MAX=60;

procedure calculs(var retour_menu: Boolean);
procedure lireChaine(var str: string);
procedure rules();
function parantehese(expression: String ;  openPos : Integer): integer;
//procedure enregistrement(var save_calc: TextFile);
function calcul(s: String): Real;

Implementation

uses Crt, Sysutils, Math;

procedure calculs(var retour_menu: Boolean);
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
    writeln('Quitter le menu calcul classique = "q"');
    writeln('Realiser un calcul = "C"');
    writeln;
    write('Choix: ');
    readln(choix);
    ClrScr();
    rules();

    if choix = 'C' then
    begin
        j := Length(SaveOperation);
        lireChaine(SaveOperation[j]);
        result := calcul(SaveOperation[j]);
        SaveResult[j] := FloatToStr(result);
        Writeln(SaveResult[j]);
    end
    else
    begin
        if choix = 'q' then
            retour_menu := True
        else
            writeln('Saisie incorrecte');
    end;

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
Writeln('Quand tu dois faire calcul de cos ou sin, tu dois ecrire c pour cosinus et s pour sinus. ');
Writeln('Example : =s90 ca veut dire sin(90) ');
Writeln('Les 4 operations mathematique sont memes');
Writeln('x pour la multiplication, + pour  addition, / pour la division, - pour la soustraction ');
Writeln('nlx pour la logaritma ,n est la base ,x est la valeur et et l est la logaritma ');
Writeln('e2 ca veut dire exponatielle carre');

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

procedure enregistrement(var save_calc: TextFile);
begin
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
			s1 := Copy(s, i + 1, closePos - i - 1); // prendre entre les paratehes
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
				calcul := power(calcul(s1),calcul(s2));
				exit;
				
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
