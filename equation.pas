Unit equation;


Interface
function deltasolution(var a,b,c:Real): Real;
procedure poylnomiale_equation_order();
function y(a, b: Real): String;
procedure Equation_ordre_1();
procedure  Equation_ordre_2();
procedure choix();




Implementation


uses sysutils,math,calculsimple;

type ComplexNumber = record
    RealPart: String;
    ImaginaryPart: String;
  end;


function deltasolution(var a,b,c:Real):Real;
begin
		deltasolution := b * b - 4 * a * c;

end;


procedure poylnomiale_equation_order();
var a,b,c,delta:Real;
	x1,x2:ComplexNumber;
	i,lastpoint:Integer;
	equation:String;
BEGIN
		Writeln('example  equation du second degre : ax^2+bx+c=0  quand a,b,c sont reels ' );
		Readln(equation);
		a:=0;b:=0;c:=0;
		lastpoint:=0;
		for i:=1 to length(equation) do
			begin
			 if ((equation[i] = 'x') and (equation[i+1] = '^')) then
				begin
					a:= (StrToFloat(Copy(equation, 1, i -1)));
					lastpoint:=i+3;
				end
			 else if ((equation[i] = 'x') and (equation[i+1] <> '^') and (equation[i+1] = '+')) then
			    begin
					b:= StrToFloat((Copy(equation,lastpoint, i-lastpoint)));
					lastpoint:=i+2;
				end
			 else if ((equation[i] <> 'x') and (equation[i+1] <> '^')and (equation[i] = '='))  then
				begin
					c:= StrToFloat(Copy(equation,lastpoint, i-lastpoint));
				end;
			end;	
		delta:=deltasolution(a,b,c);
		// calculer  les racines et imprimer
		if (delta > 0) then
			begin
			x1.RealPart := FloatToStr((-b + Sqrt(delta)) / (2 * a));
			x2.RealPart := FloatToStr((-b - Sqrt(delta)) / (2 * a));
			Writeln('Il y a deux racines reels.');
			Writeln('x1 =  ' , x1.RealPart);
			Writeln('x2 = ' , x2.RealPart );
			end;
		if (delta = 0) then
			begin
				x1.RealPart := FloatToStr(-b / (2 * a));
				Writeln('Il y a une double racine.');
				Writeln('x = ', x1.RealPart);
			end;
	    if (delta < 0) then
			begin
				x1.RealPart :=FloatToStr ((-b ) / (2 * a));
				x2.RealPart := FloatToStr((-b ) / (2 * a));
				x1.ImaginaryPart := FloatToStr((Sqrt(Abs(delta)) / (2 * a)));
				x2.ImaginaryPart := FloatToStr(-(Sqrt(Abs(delta)) / (2 * a)));
				Writeln('Il y a deux racines complex.');
				Writeln('x1= ', (x1.RealPart) , '  +  ' , (x1.ImaginaryPart) , 'i');
				Writeln('x2 = ',( x2.RealPart) , ' + '  , (x2.ImaginaryPart)  , 'i');
			end;

	

END;

 function y(a, b: Real): String;
	begin
  y := 'ke^(' + FloatToStr(a) + 'x)-' + FloatToStr(b/a);
	end;
procedure Equation_ordre_1();
var
  solution, equation: String;
  b, a: Real;
  i, j: Integer;
begin
  Writeln('Example: y''=ay+b   quand a et b sont reels' );
  Writeln('Ecrivez equation differeantial avec ordre 1');
  Readln(equation);

  i := 0;
  while (i <= Length(equation)) do
  begin
    if (equation[i] = '=') then
    begin
      j := i + 1;
      while (j <= Length(equation)) and (equation[j] <> '+') do
      begin
        Inc(j);
      end;
      a := StrToFloat(Copy(equation, i + 1, j - i -2));
      if (j <= Length(equation)) then
      begin
        b := StrToFloat(Copy(equation, j + 1, Length(equation) - j));
      end
      else
      begin
        b := 0; 
      end;

      Break; 
    end;
    Inc(i);
  end;
  solution:=y(a,b);
  Writeln(solution);
end;
procedure yH(a, b,c: Real  ; var  x1,x2:ComplexNumber);
 var delta:Real; 
	begin
		delta:=deltasolution(a,b,c);
		if(delta>0)then
			begin
				Writeln('c1 et c2 sont constantes');
				x1.RealPart := FloatToStr((-b + Sqrt(delta)) / (2 * a));
				x2.RealPart := FloatToStr((-b - Sqrt(delta)) / (2 * a));
				Writeln('Yh(x)=c1e^',x1.RealPart ,'+ c2e^',x2.RealPart);
			end;
		if(delta=0)then
			begin
				Writeln('c1 et c2 sont constantes');
				x1.RealPart := FloatToStr(-b / (2 * a));
				Writeln('Yh(x)=(c1',x1.RealPart ,'+ c2)e^c2',x1.RealPart );
			end;	
		if(delta<0)then
			begin
				x1.RealPart :=FloatToStr ((-b ) / (2 * a));
				x2.RealPart := FloatToStr((-b ) / (2 * a));
				x1.ImaginaryPart := FloatToStr((Sqrt(Abs(delta)) / (2 * a)));
				x2.ImaginaryPart := FloatToStr(-(Sqrt(Abs(delta)) / (2 * a)));
				Writeln('Yh(x)=e^',x1.RealPart,'x(',x1.RealPart,'cos(',x1.ImaginaryPart,'x)+','c1sin(',x2.ImaginaryPart,'x))');
			end;
	end;
	
	
	
procedure  Equation_ordre_2();
var
  equation: String;
  b, a,c,d: Real;
  i, lastpoint: Integer;
  x1,x2:ComplexNumber;

begin
  Writeln('Example: ay''''+by''+cy=d   quand a,b,c et d sont reels' );
  Writeln('Ecrivez equation differeantial avec ordre 2');
  Readln(equation);
  a:=0;b:=0;c:=0;d:=0;
  lastpoint:=0;
  for i:=1 to length(equation) do
	begin
		if ((equation[i] = 'y') and (equation[i+1] = '''')and (equation[i+2] = '''')) then
		 begin
			a:= (StrToFloat(Copy(equation, 1, i -1)));
			lastpoint:=i+4;
		 end
		else if ((equation[i] = 'y') and (equation[i+1] = '''') and (equation[i+2] <> '''')) then
		 begin
			b:= StrToFloat((Copy(equation,lastpoint, i-lastpoint)));
			lastpoint:=i+3;
		 end
        else if ((equation[i] = 'y') and (equation[i+1] <> '''') and (equation[i+2] <> '''')) then
		 begin
		   c:= StrToFloat(Copy(equation,lastpoint, i-lastpoint));
		   lastpoint:=i+2;
		 end
		else if(equation[i] = '=') then
		 begin
		  d:= StrToFloat(Copy(equation,lastpoint, length(equation)-lastpoint+1));
		 end;
	
   end;
  
   yH(a,b,c,x1,x2);
 
	
	
end;

 
procedure choix();
var j:Integer;
begin
Writeln('Bienvenue');
Writeln('1-Resoudre equation du second degre , 2-Resoudre equation differentielle ordre 1 , ');
Writeln('3-Resoudre equation differentielle ordre 2');
readln(j);
	if(j = 1)then
	begin
		poylnomiale_equation_order();
	end;
	if(j = 2)then
	begin
		Equation_ordre_1();
	end;
	if(j = 3)then
	begin
		Equation_ordre_2();
	end;	

end;
end.







