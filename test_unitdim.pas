program test_unitdim;

uses unitdim, sysutils;

//var currentfile: TextFile;
//var f: fichiers;
var t: tableau; nm: string;
//var i, j: integer;
begin
//conversion(currentfile);
//dimension(currentfile);
chargementdonnees(t,nm,'conversions');
{i:=-1;
j:=-1;
while i<=(StrToInt(nm)-(StrToInt(nm) mod 10)) div 10 do
	begin
	i+=1;
	while j<=(StrToInt(nm) mod 10) do
		begin
		j+=1;
		writeln(t[i][j]);
		end;
	end;}
end.
