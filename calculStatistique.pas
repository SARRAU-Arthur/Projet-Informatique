program CalculatriceStatistique;

uses unitstats;

var tab_med: tableau1D;
begin
//SaisirTableau(ti,n);
//creationtableau(tab_med);
CalculerMediane(tab_med);
CalculerMoyenne(tab_med);
CalculerVariance(tab_med);
CalculerEcartType(CalculerVariance);
end.
