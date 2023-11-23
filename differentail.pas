

program Differential;
uses sysutils,math;

type ComplexNumber = record
    RealPart: Real;
    ImaginaryPart: Real;
  end;


var a,b,c,delta:Real;
	x1,x2:ComplexNumber;
BEGIN
		Writeln('example  equation : ax^2+bx+c');
		Writeln('Ecrivez votre coefficient de a');
		Readln(a);
		Writeln('Ecrivez votre coefficient de b');
		Readln(b);
		Writeln('Ecrivez votre  c');
		Readln(c);
		delta := b * b - 4 * a * c;

  // calculer  les racines et imprimer
		if (delta > 0) then
			begin
			x1.RealPart := (-b + Sqrt(delta)) / (2 * a);
			x2.RealPart := (-b - Sqrt(delta)) / (2 * a);
			Writeln('Il y a deux racines reels.');
			Writeln('x1 =  ' , x1.RealPart);
			Writeln('x2 = ' , x2.RealPart );
			end;
		if (delta = 0) then
			begin
				x1.RealPart := -b / (2 * a);
				Writeln('Il y a une double racine.');
				Writeln('x = ', x1.RealPart);
			end;
	    if (delta < 0) then
			begin
				x1.RealPart := (-b + Sqrt(delta)) / (2 * a);
				x2.RealPart := (-b - Sqrt(delta)) / (2 * a);
				x1.ImaginaryPart := (Sqrt(Abs(delta)) / (2 * a));
				x2.ImaginaryPart := (Sqrt(Abs(delta)) / (2 * a));
				Writeln('Il y a deux racines reels.');
				Writeln('x1= ', x1.RealPart , '  +  ' ,x1.ImaginaryPart ,'i');
				Writeln('x2 = ', x2.RealPart , ' + ', 	x2.ImaginaryPart  , 'i');
			end;

	

END.

